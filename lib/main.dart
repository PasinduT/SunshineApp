import 'package:credentials_helper/credentials_helper.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunshine/components/settings.dart';
import 'package:sunshine/components/weatherlist.dart';
import 'package:sunshine/weather_block.dart';



class SunshineApp extends StatefulWidget {
  @override
  SunshineAppState createState() => SunshineAppState();
}

class SunshineAppState extends State<SunshineApp> {
  bool isMetric = true;
  WeatherBloc weatherBloc = WeatherBloc();

  @override
  void initState() {
    super.initState();
    getIsMetricPreference();
    _update();
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

  void _update() {
    weatherBloc.updateWeatherData();
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
            icon: Icon(Icons.refresh, color: Colors.white,), 
            tooltip: 'Refresh data',
            onPressed: () {
              _update();
            },
          ),
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            tooltip: "Settings",
            onPressed: () {
              // _toggleIsMetric();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SettingsPage(
                            isMetricToggle: _toggleIsMetric,
                            initialIsMetric: isMetric,
                          )));
            }
          ),
        ],
      ),
      body: Center(
        child: StreamBuilder<List>(
          stream: weatherBloc.weatherData,
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
