import 'package:flutter/material.dart';
import 'package:sunshine/components/MainWeatherItem.dart';
import 'package:sunshine/components/WeatherItem.dart';
import 'package:sunshine/weather.dart';

class WeatherList extends StatelessWidget {
  WeatherList({this.forecastData, this.weather, this.isMetric});

  final List<Weather> forecastData;
  final Weather weather;
  final bool isMetric;

  @override
  Widget build(BuildContext context) {
    // return ListView(
    //   children: <Widget>[
    //     MainWeather(weather: Weather(date: 'Today, June 21', high: 21, low: 13, state: 'Clouds'),),
    //     WeatherItem(weather: Weather(date: 'Tomorrow', high: 18, low: 11, state: 'Clear')),
    //     WeatherItem(weather: Weather(date: 'Monday', high: 16, low: 11, state: 'Clear'))
    //   ],
    // );
    if (isMetric) {
      weather.changeToMetric();
      forecastData.forEach((element) {
        element.changeToMetric();
      });
    } else {
      weather.changeToImperial();
      forecastData.forEach((element) {
        element.changeToImperial();
      });
    }

    List<Widget> something = <Widget>[MainWeather(weather: weather)];
    for (int i = 0; i < forecastData.length; ++i) {
      something.add(WeatherItem(weather: forecastData[i]));
    }

    return ListView(
      children: something,
    );
  }
}