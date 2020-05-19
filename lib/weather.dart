import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Weather {
  Weather({this.date, this.high, this.low, this.state, this.dt, bool isMetric}) : _isMetric = true;
  final String date;
  int dt;
  double high;
  double low;
  final String state;
  bool _isMetric = true;

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

  double _toC(double temp) {
    return temp * 9 / 5 + 32; 
  }

  double _toF(double temp) {
    return (temp - 32) * 5 / 9;
  }

  void changeToMetric() {
    if (!_isMetric) {
      high = _toF(high);
      low = _toF(low);
      _isMetric = true;
    }
  }

  void changeToImperial() {
    if (_isMetric) {
      high = _toC(high);
      low = _toC(low);
      _isMetric = false;
    }
  }

  static String parseDate(int dt, int timezone) {
    DateTime d = DateTime.fromMillisecondsSinceEpoch((dt + timezone) * 1000,
        isUtc: true);
    DateTime n = DateTime.now();
    if (d.day == n.day)
      return 'Today, ${DateFormat("h:mm a").format(d)}';
    else if (d.difference(n).inHours < 24)
      return 'Tomorrow, ${DateFormat("h a").format(d)}';
    return DateFormat("MMM d, h a").format(d).toString();
  }

  String getTempHigh({int dp = 2}) {
    return (_isMetric) ? '${high.toStringAsFixed(dp)}\u00b0C' : '${high.toStringAsFixed(dp)} F';
  }

  String getTempLow({int dp = 2}) {
    return (_isMetric) ? '${low.toStringAsFixed(dp)}\u00b0C' : '${low.toStringAsFixed(dp)} F';
  }

  String getWeatherItemDate() {
    return date;
  }

  String getDetailsItemDate() {
    return DateFormat('EEE, MMM d. h:mm')
       .format(DateTime.fromMillisecondsSinceEpoch(this.dt, isUtc: true));
  }

  String getMainWeatherItemDate() {
    DateTime d = DateTime.fromMillisecondsSinceEpoch(dt,
        isUtc: true);
    DateTime n = DateTime.now();
    if (d.day == n.day)
      return 'Today, ${DateFormat("MMM d\nh:mm a").format(n)}';
    else if (d.difference(n).inHours < 24)
      return 'Tomorrow, ${DateFormat("h a").format(d)}';
    return DateFormat("MMM d, h a").format(d).toString();
  }

  factory Weather.fromJson(Map<String, dynamic> data) {
    return Weather(
      date: parseDate(data['dt'], data['timezone']),
      dt: (data['dt'] + data['timezone']) * 1000,
      high: (data['main']['temp_max']) * 1.0,
      low: (data['main']['temp_min']) * 1.0,
      state: data['weather'][0]['main'],
      isMetric: true,
    );
  }
}
