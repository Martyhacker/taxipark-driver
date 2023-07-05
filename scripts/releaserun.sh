#!/bin/bash
var=$(pwd)
adb uninstall dev.peykam.taxipark
flutter clean
flutter pub get
flutter build apk --split-per-abi
adb install -r $var/build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk
