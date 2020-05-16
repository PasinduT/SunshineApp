import 'package:flutter/material.dart';

class SunshineApp extends StatelessWidget {

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
        body: WeatherList(
          weathers: <Weather>[
            Weather(date: 'Tomorrow', high: 44),
            Weather(date: 'Day after tomorrow', high: 32),
            Weather(date: 'The day after day after tomorrow', high: 34)
        ]),
      ),
    );
  }
}

class Weather {
  Weather({this.date, this.high, this.low, this.state});
  final String date;
  final int high;
  final int low;
  final String state;
}

class WeatherList extends StatelessWidget {
  WeatherList({this.weathers});

  final List<Weather> weathers;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        MainWeather(weather: Weather(date: 'Today, June 21', high: 21, low: 13, state: 'Clouds'),),
        WeatherItem(weather: Weather(date: 'Tomorrow', high: 18, low: 11, state: 'Clear')),
        WeatherItem(weather: Weather(date: 'Monday', high: 16, low: 11, state: 'Clear'))
      ],
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

void main() {
  runApp(SunshineApp());
}