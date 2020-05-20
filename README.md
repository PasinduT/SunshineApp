# Sunshine App

This is a weather app developed using [Flutter](flutter.dev). The goal of the project was to learn Flutter.

Weather data is obtained from the [OpenWeatherMap](openweathermap.org), where the API call has the following format:

http://api.openweathermap.org/data/2.5/forecast?q=kirksville&appid={api_key}&units=metric

`{api_key}` must be obtained from the site using a free account, and entered in the weather_bloc.dart file as follows.

```Dart
String weatherApiKey = "{api_key}";
```

### Gallery

![An image of the home page](/assets/avd_home.png "Home Page") ![An image of the settings page](/assets/avd_settings.png "Settings")
![An image of the details page](/assets/avd_details.png "Details Page")

### TODO
- [x] Add ability to switch between units
- [ ] Ability to change location
- [x] Add animations
- [x] Get current weather in the main window
- [x] View more data when you click on an item
    - [ ] Parse more weather features and add them in the details page
- [x] Organize the code better and comment it
- [ ] Add custom Icons/Images
- [ ] Add to Google Play / Appstore