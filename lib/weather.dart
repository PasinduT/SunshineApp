import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Weather {
  Weather({this.date, this.high, this.low, this.state, this.dt});
  final String date;
  int dt;
  final double high;
  final double low;
  final String state;

  IconData getIcon() {
    if (state == "Clouds") {
      return Icons.cloud;
    } else if (state == "Rain") {
      return Icons.flash_on;
    } else if (state == "Clear") {
      return Icons.wb_sunny;
    }
    return Icons.error;
  }

  static String parseDate(int dt, int timezone) {
    DateTime d = DateTime.fromMillisecondsSinceEpoch((dt + timezone) * 1000,
        isUtc: true);
    DateTime n = DateTime.now();
    if (d.day == n.day)
      return 'Today, ${DateFormat("MMM d, h:mm a").format(d)}';
    else if (d.difference(n).inHours < 24)
      return 'Tomorrow, ${DateFormat("h a").format(d)}';
    return DateFormat("MMM d, h a").format(d).toString();
  }

  String getDate() {
    return DateFormat('EEE, MMM d. h:mm')
        .format(DateTime.fromMillisecondsSinceEpoch(this.dt, isUtc: true));
  }

  factory Weather.fromJson(Map<String, dynamic> data) {
    return Weather(
      date: parseDate(data['dt'], data['timezone']),
      dt: (data['dt'] + data['timezone']) * 1000,
      high: (data['main']['temp_max']) * 1.0,
      low: (data['main']['temp_min']) * 1.0,
      state: data['weather'][0]['main'],
    );
  }
}
