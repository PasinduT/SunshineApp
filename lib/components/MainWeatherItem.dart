import 'package:flutter/material.dart';
import 'package:sunshine/weather.dart';

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
          Container(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Date label
                Container(
                    padding: EdgeInsets.only(left: 40, top: 10, bottom: 10),
                    child: Text(weather.date,
                        style: TextStyle(fontSize: 21, color: Colors.white)),
                    alignment: Alignment.centerLeft),
                // High label
                Container(
                    padding: EdgeInsets.only(left: 40),
                    child: Text('${weather.high.toString()}\u00b0',
                        style: TextStyle(
                          fontSize: 55,
                          color: Colors.white,
                        )),
                    alignment: Alignment.centerLeft),
                // Low Label
                Container(
                  padding: EdgeInsets.only(left: 40, top: 10, bottom: 10),
                  child: Text('${weather.low.toString()}\u00b0',
                      style: TextStyle(fontSize: 32, color: Colors.white)),
                  alignment: Alignment.centerLeft,
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                // The Weather Icon
                Container(
                  child: Icon(
                    weather.getIcon(),
                    color: Colors.white,
                    size: 60,
                  ),
                ),
                // The Weather state text
                Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(weather.state,
                      style: TextStyle(fontSize: 21, color: Colors.white)),
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
