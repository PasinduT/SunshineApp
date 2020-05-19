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
        padding: EdgeInsets.only(top: 20),
        child: ListView(
          children: <Widget>[
            DetailItem(
                first: 'Time:', second: '${weather.getDetailsItemDate()}'),
            DetailItem(
                first: 'Temperature High:', second: '${weather.getTempHigh()}'),
            DetailItem(
                first: 'Temperature Low:', second: '${weather.getTempLow()}'),
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
      child: ListTile(
        title: Text(
          first,
          style: TextStyle(
              fontSize: Theme.of(context).textTheme.headline6.fontSize,
              fontWeight: FontWeight.bold),
        ),
        trailing: Container(
            child: Text(second,
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.headline6.fontSize,
                ))),
      ),
    );
  }
}
