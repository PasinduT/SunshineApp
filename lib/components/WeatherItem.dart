import 'package:flutter/material.dart';
import 'package:sunshine/components/details.dart';
import 'package:sunshine/weather.dart';

class WeatherItem extends StatelessWidget {
  WeatherItem({this.weather});

  final Weather weather;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Goto the details page
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsPage(weather: weather),
            ));
      },
      child: Container(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            // The Icon
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    weather.getIcon(),
                    size: 30,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
            // The Text
            Expanded(
                child: Column(
              children: <Widget>[
                // Weather date label
                Container(
                  child: Text(
                    weather.getWeatherItemDate(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  alignment: Alignment.centerLeft,
                ),
                // Weather State label
                Container(
                  child: Text(
                    weather.state,
                    style: TextStyle(fontSize: 15),
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ],
            )),
            // The temperature
            Column(
              children: <Widget>[
                // High temperature label
                Container(
                    padding: EdgeInsets.only(right: 20, bottom: 5),
                    child: Text(
                      '${weather.getTempHigh()}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    )),
                // Low temperature label
                Container(
                    padding: EdgeInsets.only(right: 20, bottom: 5),
                    child: Text('${weather.getTempLow()}'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
