# heft

An Android weight-tracking app, written using the Flutter framework.

## Building

### Build and Install on Local Device

> TBD...

### Generate Type Adapters

To generate the model type adapters (if they change), run the following:

    flutter packages pub run build_runner build

---

To Do:

* [ ] hive storage integration
* [x] properly support screen rotation
* [ ] ability to set reminder (time and day of week) to log weight.
* [ ] ensure proper theme usage
* [ ] about screen - medical disclaimer, link to BMI calc, this is intended for adults
* [ ] create a home screen widget with current wt, bmi, and an "add" button

https://medium.com/flutter-community/storing-local-data-with-hive-and-provider-in-flutter-a49b6bdea75a
https://blog.logrocket.com/handling-local-data-persistence-flutter-hive/
https://codingwithdhrumil.com/2021/03/hive-flutter-local-database-example.html
