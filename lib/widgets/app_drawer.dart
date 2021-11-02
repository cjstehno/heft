import 'package:flutter/material.dart';
import 'package:heft/screens/settings_screen.dart';
import 'package:package_info/package_info.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Heft'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () =>
                Navigator.of(context).pushNamed(SettingsScreen.routeName),
          ),
          const Divider(),
          AboutListTile(
            icon: const Icon(Icons.info),
            child: const Text('About'),
            applicationIcon: const Text(
              '📔',
              style: TextStyle(fontSize: 50),
            ),
            applicationName: 'Heft',
            applicationVersion: _packageInfo.version,
            applicationLegalese: '© 2021 Christopher J. Stehno',
            aboutBoxChildren: const [
              Text('Disclaimer', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(
                'This application is meant for simple personal weight tracking '
                'with no explicit or implied medical benefit. It is intended for '
                'use by adults and the BMI calculations are based on the values '
                'relevant for adults. Use at your own risk.',
              ),
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'v${_packageInfo.version}',
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }
}
