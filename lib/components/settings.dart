import 'package:flutter/material.dart';

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
        children: <Widget>[
          MetricTile(
            isMetricToggle: isMetricToggle,
            initialIsMetric: initialIsMetric,
          )
        ],
      ),
    );
  }
}

class MetricTile extends StatefulWidget {
  MetricTile({Key key, this.initialIsMetric, this.isMetricToggle})
      : super(key: key);
  final VoidCallback isMetricToggle;
  final bool initialIsMetric;

  @override
  _MetricTileState createState() => _MetricTileState(
    isMetricToggle: isMetricToggle,
    isMetric: initialIsMetric,
  );
}

class _MetricTileState extends State<MetricTile> {
  _MetricTileState({this.isMetric, this.isMetricToggle});

  final VoidCallback isMetricToggle;
  bool isMetric;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: Text('Metric units'),
        trailing: Switch(
          activeColor: Colors.blue,
          activeTrackColor: Colors.lightBlue,
          value: isMetric,
          onChanged: (bool) {
            isMetricToggle();
            setState(() {
              if (isMetric) {
                isMetric = false;
              }
              else {
                isMetric = true;
              }
            });
          },
        ),
      ),
    );
  }
}
