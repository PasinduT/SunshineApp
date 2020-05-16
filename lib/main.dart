import 'dart:convert';

import 'package:credentials_helper/credentials_helper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Weather>> fetchData() async{

  final response = await http.get('http://api.openweathermap.org/data/2.5/forecast?q=kirksville&units=metric&appid=$weather_api_key');
  
  if (response.statusCode == 200) {
    List<Weather> weathers = List<Weather>(); 
    Map<String, dynamic> data = jsonDecode(response.body);
    int n = data['list'].length;
    for (int i = 0; i < n; ++i) {
      Weather w = Weather(
        date: data['list'][i]['dt_txt'], 
        high: (data['list'][i]['main']['temp_max']) * 1.0, 
        low: (data['list'][i]['main']['temp_min']) * 1.0, 
        state: data['list'][i]['weather'][0]['main']
      );
      weathers.add(w);
    }
    return weathers;
  }

  throw Exception('Failed to load weather data');
}

class SunshineApp extends StatefulWidget {
  @override
  SunshineAppState createState() => SunshineAppState();
}

class SunshineAppState extends State<SunshineApp> {
  Future<List<Weather>> weatherData;

  @override
  void initState() {
    super.initState();
    weatherData = fetchData();
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
          actions: <Widget>[
            IconButton(icon: Icon(Icons.more_vert, color: Colors.white), onPressed: null),

          ],
        ),
        // body: WeatherList(
        //   weathers: <Weather>[
        //     Weather(date: 'Tomorrow', high: 44),
        //     Weather(date: 'Day after tomorrow', high: 32),
        //     Weather(date: 'The day after day after tomorrow', high: 34)
        // ]),
        body: Center(
          child: FutureBuilder<List<Weather>> (
            future: weatherData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return WeatherList(
                  weathers: snapshot.data,
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

class Weather {
  Weather({this.date, this.high, this.low, this.state});
  final String date;
  final double high;
  final double low;
  final String state;
}

class WeatherList extends StatelessWidget {
  WeatherList({this.weathers});

  final List<Weather> weathers;

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
      MainWeather(weather: weathers[0])
    ];
    for (int i = 1; i < weathers.length; ++i) {
      something.add(WeatherItem(weather: weathers[i]));
    }

    return ListView (
      children: something,
    );
  }
}

class MainWeather extends StatelessWidget {
  MainWeather({this.weather});

  final Weather weather;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20, top: 20),
      color: Theme.of(context).primaryColor,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                // Date label
                Container(padding: EdgeInsets.only(left:40, top:10, bottom: 10), child: Text(weather.date, style: TextStyle(fontSize: 21, color: Colors.white)), alignment: Alignment.centerLeft),
                // High label
                Container(padding: EdgeInsets.only(left:40), child: Text(weather.high.toString(), style: TextStyle(fontSize: 60, color: Colors.white,)), alignment: Alignment.centerLeft),
                // Low Label
                Container(padding: EdgeInsets.only(left:40, top:10, bottom: 10), child: Text(weather.low.toString(), style: TextStyle(fontSize: 32, color: Colors.white)), alignment: Alignment.centerLeft,)
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                // The Weather Icon
                Container(
                  child: Icon(Icons.cloud, color: Colors.white, size: 60,),
                ),
                // The Weather state text
                Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child:Text(weather.state, style: TextStyle(fontSize: 21, color: Colors.white)),
                  
                )
              ],
              mainAxisAlignment: MainAxisAlignment.start,
            ),
          )
        ],
      ),
    );
  }
}

class WeatherItem extends StatelessWidget {
  WeatherItem({this.weather});

  final Weather weather;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top:10, bottom: 10),
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                child: Icon(Icons.cloud, size: 30, color: Colors.grey,),
              )
            ],
          ),
          Expanded(child: Column(
            children: <Widget>[
              // Weather date label
              Container(child: Text(weather.date, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),), alignment: Alignment.centerLeft,),
              // Weather State label
              Container(child: Text(weather.state, style: TextStyle(fontSize: 15),), alignment: Alignment.centerLeft,),
            ],
          )),
          Column(
            children: <Widget>[
              // High temperature label
              Container(padding: EdgeInsets.only(right: 20, bottom: 5), child: Text(weather.high.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)),
              // Low temperature label
              Container(padding: EdgeInsets.only(right: 20, bottom: 5), child: Text(weather.low.toString()))
            ],
          )
        ],
      ),
    );
  }
}

String weather_api_key = "";

void main() {
  runApp(SunshineApp());
}