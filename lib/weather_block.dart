import 'dart:async';
import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:sunshine/weather.dart';
import 'package:http/http.dart' as http;

String weatherApiKey = "";
String API_FORECAST_REQUEST =
    'http://api.openweathermap.org/data/2.5/forecast?q=kirksville&units=metric&appid=$weatherApiKey';
String API_WEATHER_REQUEST =
    'http://api.openweathermap.org/data/2.5/weather?q=kirksville&units=metric&appid=$weatherApiKey';

Future<List<Weather>> fetchForecast() async {
  final response = await http.get(API_FORECAST_REQUEST);

  if (response.statusCode == 200) {
    List<Weather> weathers = List<Weather>();
    Map<String, dynamic> data = jsonDecode(response.body);
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
    print(DateFormat('yyyy MMM dd, HH:mm:ss a').format(
        DateTime.fromMillisecondsSinceEpoch(
            (data['dt'] + data['timezone']) * 1000,
            isUtc: true)));
    return Weather.fromJson(data);
  }
  throw Exception('Failed to load weather data');
}

Future<List> fetchData() async {
  final forecastData = await fetchForecast();
  final weatherData = await fetchWeather();
  return [weatherData, forecastData];
}

class WeatherBloc {
  Stream<List> get weatherData => _weatherData.stream;

  final _weatherData = StreamController<List>();

  void updateWeatherData() async {
    _weatherData.add(null);
    try {
      List<dynamic> data = await fetchData();
      _weatherData.add(data);
    } catch (err) {
      _weatherData.addError(err);
    }
  }
}
