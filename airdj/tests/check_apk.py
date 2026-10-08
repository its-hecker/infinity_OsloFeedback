#!/usr/bin/env python3
"""Check definitions across every DEX in the packaged experimental plugin."""
import struct
import sys
import zipfile

required = {b'Lcom/google/oslo/' + name + b';' for name in (
    b'AirDjController', b'AirDjPolicy', b'OsloExperiments', b'OsloExperiments$Surface',
    b'ExperimentPolicy', b'LabGlowRenderer')}
owners = {}
with zipfile.ZipFile(sys.argv[1]) as apk:
    dexes = [n for n in apk.namelist() if n.startswith('classes') and n.endswith('.dex')]
    assert dexes, 'No DEX files'
    for name in dexes:
        data = apk.read(name)
        assert data.startswith(b'dex\n'), name
        def word(offset):
            return struct.unpack_from('<I', data, offset)[0]
        strings, types, count, classes = word(60), word(68), word(96), word(100)
        for index in range(count):
            type_index = word(classes + index * 32)
            string_index = word(types + type_index * 4)
            start = word(strings + string_index * 4)
            while data[start] & 128:
                start += 1
            start += 1
            descriptor = data[start:data.index(b'\0', start)]
            assert descriptor not in owners, f'Duplicate {descriptor!r}: {owners.get(descriptor)}, {name}'
            owners[descriptor] = name
assert required <= owners.keys(), f'Missing helpers: {required - owners.keys()}'
print(f'Packaged plugin: {len(dexes)} DEX files, {len(owners)} classes, zero duplicate definitions; all feature helpers present')
