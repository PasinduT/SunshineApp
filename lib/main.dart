import 'dart:convert';

import 'package:credentials_helper/credentials_helper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sunshine/components/MainWeatherItem.dart';
import 'package:sunshine/weather.dart';
import 'package:sunshine/components/WeatherItem.dart';


String weatherApiKey = "";
final API_FORECAST_REQUEST = 'http://api.openweathermap.org/data/2.5/forecast?q=kirksville&units=metric&appid=$weatherApiKey';
final API_WEATHER_REQUEST = 'http://api.openweathermap.org/data/2.5/weather?q=kirksville&units=metric&appid=$weatherApiKey';

Future<List<Weather>> fetchForecast() async{

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

Future<Weather> fetchWeather() async{

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

  @override
  void initState() {
    super.initState();
    data = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sunshine App',
      theme: ThemeData(
        primaryColor: Colors.lightBlue[300],
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.wb_sunny, color: Colors.yellow, size: 32,),
          title: Text('Sunshine', style: TextStyle(color: Colors.white),),
        ),
        body: Center(
          child: FutureBuilder<List> (
            future: data,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return WeatherList(
                  forecastData: snapshot.data[1],
                  weather: snapshot.data[0],
                );
              }
              else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

class WeatherList extends StatelessWidget {
  WeatherList({this.forecastData, this.weather});

  final List<Weather> forecastData;
  final Weather weather;

  @override
  Widget build(BuildContext context) {
    // return ListView(
    //   children: <Widget>[
    //     MainWeather(weather: Weather(date: 'Today, June 21', high: 21, low: 13, state: 'Clouds'),),
    //     WeatherItem(weather: Weather(date: 'Tomorrow', high: 18, low: 11, state: 'Clear')),
    //     WeatherItem(weather: Weather(date: 'Monday', high: 16, low: 11, state: 'Clear'))
    //   ],
    // );
    List<Widget> something = <Widget>[
      MainWeather(weather: weather)
    ];
    for (int i = 0; i < forecastData.length; ++i) {
      something.add(WeatherItem(weather: forecastData[i]));
    }

    return ListView (
      children: something,
    );
  }
}

void main() {
  runApp(SunshineApp());
}