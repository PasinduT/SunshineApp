import 'dart:convert';

import 'package:credentials_helper/credentials_helper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunshine/components/settings.dart';
import 'package:sunshine/weather.dart';
import 'package:sunshine/components/weatherlist.dart';

String weatherApiKey = "";
final API_FORECAST_REQUEST =
    'http://api.openweathermap.org/data/2.5/forecast?q=kirksville&units=metric&appid=$weatherApiKey';
final API_WEATHER_REQUEST =
    'http://api.openweathermap.org/data/2.5/weather?q=kirksville&units=metric&appid=$weatherApiKey';

Future<List<Weather>> fetchForecast() async {
  final response = await http.get(API_FORECAST_REQUEST);

  if (response.statusCode == 200) {
    List<Weather> weathers = List<Weather>();
    Map<String, dynamic> data = jsonDecode(response.body);
    // Testing only
    print(data['list'].runtimeType);
    int n = data['list'].length;
    for (int i = 0; i < n; ++i) {
      Map<String, dynamic> dataItem = data['list'][i];
      dataItem['timezone'] = data['city']['timezone'];
      Weather w = Weather.fromJson(data['list'][i]);
      weathers.add(w);
    }
    return weathers;
  }
  throw Exception('Failed to load forecast data');
}

Future<Weather> fetchWeather() async {
  final response = await http.get(API_WEATHER_REQUEST);

  if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(response.body);
    // Testing only
    return Weather.fromJson(data);
  }
  throw Exception('Failed to load forecast data');
}

Future<List> fetchData() async {
  final forecastData = await fetchForecast();
  final weatherData = await fetchWeather();
  return [weatherData, forecastData];
}

class SunshineApp extends StatefulWidget {
  @override
  SunshineAppState createState() => SunshineAppState();
}

class SunshineAppState extends State<SunshineApp> {
  Future<List> data;
  bool isMetric = true;

  @override
  void initState() {
    super.initState();
    data = fetchData();
    getIsMetricPreference();
  }

  @override
  void dispose() {
    setIsMetricPreference();
    super.dispose();
  }

  void getIsMetricPreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (prefs.getBool('metric') == null) {
        print('Failed to load isMetric configuration from disk');
      }
      else {
        isMetric = prefs.getBool('metric');
        print('Loaded isMetric configuration from disk');
      }
      // isMetric = prefs.getBool('metric') ?? isMetric;
    } catch (e) {
      print(e);
    }
  }

  void setIsMetricPreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      prefs.setBool('metric', isMetric);
    } catch (e) {
      print(e);
    }
  }

  void _toggleIsMetric() {
    setState(() {
      if (isMetric) {
        isMetric = false;
      } else {
        isMetric = true;
      }
    });
    setIsMetricPreference();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.wb_sunny,
          color: Colors.yellow,
          size: 32,
        ),
        title: Text(
          'Sunshine',
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              onPressed: () {
                // _toggleIsMetric();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SettingsPage(
                              isMetricToggle: _toggleIsMetric,
                              initialIsMetric: isMetric,
                            )));
              }),
        ],
      ),
      body: Center(
        child: FutureBuilder<List>(
          future: data,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return WeatherList(
                forecastData: snapshot.data[1],
                weather: snapshot.data[0],
                isMetric: isMetric,
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
      title: 'SunshineApp',
      home: SunshineApp(),
      theme: ThemeData(
        primaryColor: Colors.lightBlue[300],
      )));
}
