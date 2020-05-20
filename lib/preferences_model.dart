
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesModel extends ChangeNotifier {
  bool _isMetric = false;

  bool get isMetric => _isMetric;


  PreferencesModel (bool isMetric) {
    _isMetric = isMetric;
    getIsMetricPreference();
  }

  void toggleIsMetric() {
    if (_isMetric) _isMetric = false;
    else _isMetric = true;
      
    setIsMetricPreference();
    notifyListeners();
  }

  void setIsMetricPreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      prefs.setBool('metric', _isMetric);
    } catch (e) {
      print(e);
    }
  }

  void getIsMetricPreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (prefs.getBool('metric') == null) {
        print('Failed to load isMetric configuration from disk');
      } else {
        _isMetric = prefs.getBool('metric');
        notifyListeners();
        print('Loaded isMetric configuration from disk');
      }
      // isMetric = prefs.getBool('metric') ?? isMetric;
    } catch (e) {
      print(e);
    }
  }

}