import 'package:flutter/material.dart';
import 'package:sunshine/weather.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({this.weather});

  final Weather weather;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Container(
        padding: EdgeInsets.only(top:20),
        child: Column(
          children: <Widget>[
            DetailItem(first: 'Time:', second: '${weather.getDate()}'),
            DetailItem(first: 'Temperature High:', second: '${weather.high}'),
            DetailItem(first: 'Temperature Low:', second: '${weather.low}'),
            DetailItem(first: 'State:', second: '${weather.state}'),
          ],
        ),
      ),
    );
  }
}

class DetailItem extends StatelessWidget {
  const DetailItem({Key key, this.first, this.second}) : super(key: key);

  final String first;
  final String second;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Text(first, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),), 
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Text(second, style: TextStyle(fontSize: 24,))
          ),
        ],
      ),
    );
  }
}
