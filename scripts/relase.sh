#!/bin/bash
var=$(pwd)
flutter clean
flutter pub get
flutter build apk --split-per-abi
open $var/build/app/outputs/flutter-apk/
