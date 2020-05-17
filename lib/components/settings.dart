
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Metric units'),
            trailing: Switch(
              activeColor: Colors.blue,
              activeTrackColor: Colors.lightBlue,
              value: true, 
              onChanged: null,
            ),
          )
        ],
      ),
    );
  }
}