# heft

An Android weight-tracking app, written using the Flutter framework.

## Building

### Generate Type Adapters

To generate the model type adapters (if they change), run the following:

    flutter packages pub run build_runner build

---

This is temporary dev stuff...

Uses: https://www.cdc.gov/healthyweight/assessing/bmi/adult_bmi/index.html

Settings (shared_preferences):
    gender: M | F
    units: Metric | Imperial
    height: number (in cm or in)

Records ([hive](https://pub.dev/packages/hive))
    timestamp
    weight (in the configured units)

https://medium.com/flutter-community/storing-local-data-with-hive-and-provider-in-flutter-a49b6bdea75a
https://blog.logrocket.com/handling-local-data-persistence-flutter-hive/
https://codingwithdhrumil.com/2021/03/hive-flutter-local-database-example.html


* how to send reminders to log weight?
* support screen rotation
* provide a link to BMI information (this is meant for adults)
* medical disclaimer