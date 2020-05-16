# Sunshine App

This is a weather app developed using [Flutter](flutter.dev). The goal of the project was to learn Flutter.

Weather data is obtained from the [OpenWeatherMap](openweathermap.org), where the API call has the following format:

http://api.openweathermap.org/data/2.5/forecast?q=kirksville&appid={api_key}&units=metric

`{api_key}` must be obtained from the site using a free account, and entered in the main.dart file as follows.

```Dart
226  String weatherApiKey = "{api_key}";
```

### Images of the App

![An image of the app](/assets/avd1.png "Testing")

### TODO
- Add ability to switch between units
- Ability to change location
- Get current weather in the main window
- View more data when you click on an item
- Organize the code better and comment it
- Add custom Icons/Images