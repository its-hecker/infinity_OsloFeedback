#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Compress only DEX storage in the ROM input; Soong subsequently aligns and platform-signs it."""
from pathlib import Path
from copy import copy
import os
import sys
import tempfile
from zipfile import ZipFile, ZIP_DEFLATED


def pack(path):
    path = Path(path)
    fd, temporary = tempfile.mkstemp(prefix='oslo-rom-input-', suffix='.apk', dir=path.parent)
    os.close(fd)
    temporary = Path(temporary)
    try:
        with ZipFile(path) as original, ZipFile(temporary, 'w') as result:
            result.comment = original.comment
            for entry in original.infolist():
                entry = copy(entry)
                if entry.filename.startswith('classes') and entry.filename.endswith('.dex'):
                    entry.compress_type = ZIP_DEFLATED
                result.writestr(entry, original.read(entry.filename), compresslevel=9)
        with ZipFile(path) as original, ZipFile(temporary) as result:
            assert original.namelist() == result.namelist()
            for name in original.namelist():
                assert original.read(name) == result.read(name), name
        os.replace(temporary, path)
    finally:
        temporary.unlink(missing_ok=True)


if __name__ == '__main__':
    pack(sys.argv[1])
