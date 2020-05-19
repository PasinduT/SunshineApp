import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunshine/preferences_model.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key key, this.isMetricToggle, this.initialIsMetric})
      : super(key: key);

  final VoidCallback isMetricToggle;
  final bool initialIsMetric;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[MetricTile()],
      ),
    );
  }
}

class MetricTile extends StatelessWidget {
  const MetricTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesModel>(
        builder: (context, preferencesModel, child) {
      return ListTile(
        title: Text('Metric units'),
        trailing: Switch(
          activeColor: Colors.blue,
          activeTrackColor: Colors.lightBlue,
          value: preferencesModel.isMetric,
          onChanged: (bool) {
            preferencesModel.toggleIsMetric();
          },
        ),
      );
    });
  }
}
