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

### Generate Type Adapters

To generate the model type adapters (if they change), run the following:

    flutter packages pub run build_runner build

---

To Do:

* [ ] about screen - medical disclaimer, link to BMI calc, this is intended for adults
* [ ] unit testing
* [ ] tap on trend to see graph of data
* [ ] tap on weight to see graph of data
* [ ] tap on BMI to see graph of data
