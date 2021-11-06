# heft

An Android weight-tracking app, written using the Flutter framework.

## Building

> TBD.

### Internal Release

For testing on your own device, you can install the app via USB.

First, ensure version info updated in pubspec.yml if releasing new version - the release number will need to be incremented
each time you want to push a release, though the application version can remain unchanged.

Run the following from the command line (`--release` is used by default):

    flutter build apk --split-per-abi

Then, to install it on a USB-connected device use:

    flutter install 

> **Note:** You can also run the obfuscator, if desired. See [Obfuscating Dart Code](https://flutter.dev/docs/deployment/obfuscate)
> for more details.

### Upgrading Existing Internal Version

The installation method described above will easily push a release to the attached device; however, it will wipe out any
preferences or stored data. In order to perform an upgrade (maintaining data) you must do the following:

  adb install -r <the apk for your device>

If you need to push an update without bumping the app version, you can replace the exising with: 

  adb install -r <the apk for your device>

> Note: You will need to determine which apk should be installed for your device (e.g. `app-arm64-v8a-release.apk`).

### Generate Type Adapters

To generate the model type adapters (if they change), run the following:

    flutter packages pub run build_runner build

