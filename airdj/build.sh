#!/usr/bin/env bash
set -euo pipefail
AIR_DJ_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
: "${APK_EDITOR_JAR:?Set APK_EDITOR_JAR to APKEditor 1.4.9}"
: "${ANDROID_JAR:?Set ANDROID_JAR to the Android 35 SDK android.jar}"
: "${R8_JAR:?Set R8_JAR to R8 8.7.18}"
AIR_DJ_OUTPUT="${1:?Provide the output APK path}"
AIR_DJ_WORK="$(mktemp -d)"
trap 'rm -rf "$AIR_DJ_WORK"' EXIT
mkdir -p "$AIR_DJ_WORK/classes" "$AIR_DJ_WORK/dex" "$AIR_DJ_WORK/tests"
java com.sun.tools.javac.Main -d "$AIR_DJ_WORK/tests" \
    "$AIR_DJ_ROOT/airdj/src/com/google/oslo/AirDjPolicy.java" \
    "$AIR_DJ_ROOT/airdj/tests/com/google/oslo/AirDjPolicyTest.java"
java -cp "$AIR_DJ_WORK/tests" com.google.oslo.AirDjPolicyTest
java com.sun.tools.javac.Main -d "$AIR_DJ_WORK/tests" \
    "$AIR_DJ_ROOT/airdj/src/com/google/oslo/ExperimentPolicy.java" \
    "$AIR_DJ_ROOT/airdj/tests/com/google/oslo/ExperimentPolicyTest.java"
java -cp "$AIR_DJ_WORK/tests" com.google.oslo.ExperimentPolicyTest
python3 "$AIR_DJ_ROOT/airdj/tests/test_controller.py"
java com.sun.tools.javac.Main -source 8 -target 8 -classpath "$ANDROID_JAR" \
    -d "$AIR_DJ_WORK/classes" "$AIR_DJ_ROOT"/airdj/src/com/google/oslo/*.java
java -cp "$R8_JAR" com.android.tools.r8.D8 --min-api 29 --lib "$ANDROID_JAR" \
    --output "$AIR_DJ_WORK/dex" "$AIR_DJ_WORK"/classes/com/google/oslo/*.class
java -cp "$APK_EDITOR_JAR" org.jf.baksmali.Main disassemble \
    "$AIR_DJ_WORK/dex/classes.dex" -o "$AIR_DJ_ROOT/smali/classes2"
java -jar "$APK_EDITOR_JAR" b -no-cache -i "$AIR_DJ_ROOT" -o "$AIR_DJ_OUTPUT"
