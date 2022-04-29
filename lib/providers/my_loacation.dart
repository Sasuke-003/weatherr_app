import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/providers/weather.dart';

class MyLocation {
  static const baseURL = 'https://api.openweathermap.org/data/2.5/weather';
  static const openWeatherApiKey = '17404e911ee3942aa04aedead3b3eded';
  static const mapQuestApiKey = 'BAkZ0ozJq16IDwibV5fJQvv3hQrY5io6';

  static Future<String> getLocationNameByLatLon(double lat, double lon) async {
    final url = Uri.parse(
        'https://open.mapquestapi.com/geocoding/v1/reverse?key=${MyLocation.mapQuestApiKey}&location=${lat},${lon}&includeRoadMetadata=true&includeNearestIntersection=true');
    var response = await http.get(url);
    return json.decode(response.body)['results'][0]['locations'][0]['adminArea5'];
  }

  static Future<WeatherItem> getWeatherDetailsOfLocByName(String placeName) async {
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$placeName&lang=en&appid=${MyLocation.openWeatherApiKey}');

    var res = await http.get(url);

    var wData = json.decode(res.body);

    return WeatherItem(
        title: wData['weather'][0]['main'],
        temp: wData['main']['temp'],
        tempMin: wData['main']['temp_min'],
        tempMax: wData['main']['temp_max'],
        humidity: wData['main']['humidity'],
        visibility: wData['visibility'],
        windSpeed: wData['wind']['speed'],
        iconName: wData['weather'][0]['icon'],
        country: wData['sys']['country'],
        createdAt: DateTime.now(),
        timezone: wData['timezone']);
  }
}
