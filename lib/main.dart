import 'package:credentials_helper/credentials_helper.dart';
import 'package:flutter/material.dart';

import 'package:sunshine/components/settings.dart';
import 'package:sunshine/components/weatherlist.dart';
import 'package:flutter/animation.dart';
import 'package:sunshine/preferences_model.dart';
import 'package:sunshine/weather_block.dart';
import 'package:provider/provider.dart';

class SunshineApp extends StatefulWidget {
  @override
  SunshineAppState createState() => SunshineAppState();
}

class SunshineAppState extends State<SunshineApp> {
  WeatherBloc weatherBloc = WeatherBloc();

  @override
  void initState() {
    super.initState();
    _update();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _update() {
    weatherBloc.updateWeatherData();
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SettingsPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.easeIn;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
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
              Icons.refresh,
              color: Colors.white,
            ),
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
                Navigator.push(context,
                    _createRoute());
              }),
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
                isMetric: Provider.of<PreferencesModel>(context).isMetric,
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
  runApp(ChangeNotifierProvider(
    create: (context) => PreferencesModel(false),
    child: MaterialApp(
        title: 'SunshineApp',
        home: SunshineApp(),
        theme: ThemeData(
          primaryColor: Colors.lightBlue[300],
        )),
  ));
}
