import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:location/location.dart';

import 'package:http/http.dart' as http;
import 'package:weather_app/providers/my_loacation.dart';

class WeatherItem {
  final String title;
  final double temp;
  final double tempMin;
  final double tempMax;
  final int humidity;
  final int visibility;
  final double windSpeed;
  final String iconName;
  final String country;
  final DateTime createdAt;
  final int timezone;
  bool isFavorite;
  bool isRecentlySearched;

  WeatherItem(
      {required this.title,
      required this.temp,
      required this.tempMin,
      required this.tempMax,
      required this.humidity,
      required this.visibility,
      required this.windSpeed,
      required this.iconName,
      required this.country,
      required this.createdAt,
      required this.timezone,
      this.isFavorite = false,
      this.isRecentlySearched = false});
}

class Weather with ChangeNotifier {
  Map<String, WeatherItem> _locations = {};

  String _currentWeatherId = '';

  Map<String, WeatherItem> get locations {
    return {..._locations};
  }

  WeatherItem? get currentWeather {
    return _locations[_currentWeatherId];
  }

  String get currentPlaceName {
    return _currentWeatherId;
  }

  Future<bool> getWeatherByLocName({String? locName}) async {
    if (locName == null && _currentWeatherId != '' && _locations.containsKey(_currentWeatherId)) {
      print('yeah');
      return true;
    }

    try {
      String searchLocationName = '';
      if (locName == null) {
        final locData = await Location().getLocation();
        searchLocationName =
            await MyLocation.getLocationNameByLatLon(locData.latitude!, locData.longitude!);
      } else {
        searchLocationName = locName;
      }

      var dataFound = _locations.containsKey(searchLocationName.toUpperCase());
      if (dataFound) {
        _currentWeatherId = searchLocationName.toUpperCase();
        notifyListeners();

        print('found');
      } else {
        WeatherItem weatherData = await MyLocation.getWeatherDetailsOfLocByName(searchLocationName);
        _locations[searchLocationName.toUpperCase()] = weatherData;
        _currentWeatherId = searchLocationName.toUpperCase();
        notifyListeners();
        print('not found');
      }
      return true;
    } catch (error) {
      print(error.toString());
      return false;
    }
  }

  void toggleFavoriteStatus(String placeName) {
    _locations.update(
        placeName,
        (prevValues) => WeatherItem(
            title: prevValues.title,
            temp: prevValues.temp,
            tempMin: prevValues.tempMin,
            tempMax: prevValues.tempMax,
            humidity: prevValues.humidity,
            visibility: prevValues.visibility,
            windSpeed: prevValues.windSpeed,
            iconName: prevValues.iconName,
            country: prevValues.country,
            createdAt: prevValues.createdAt,
            timezone: prevValues.timezone,
            isFavorite: !prevValues.isFavorite));
    notifyListeners();
  }
}
