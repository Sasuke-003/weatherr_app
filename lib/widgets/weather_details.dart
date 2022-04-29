import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weather_app/providers/weather.dart';

class WeatherDetails extends StatelessWidget {
  const WeatherDetails({Key? key}) : super(key: key);

  String kelvinToCelsius(double kelvin) {
    return (kelvin - 273.15).toStringAsFixed(0);
  }

  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<Weather>(context);
    List<Map<String, Object>> weatherDetailList = [
      {
        'title': 'Min-Max',
        'value':
            '${kelvinToCelsius(weatherData.currentWeather?.tempMin as double)}\u2103 - ${kelvinToCelsius(weatherData.currentWeather?.tempMax as double)}\u2103',
        'iconLink': 'assets/images/icon_temperature_info.png',
        'height': 35.0,
        'width': 20.0
      },
      {
        'title': 'Humidity',
        'value': '${weatherData.currentWeather?.humidity}',
        'iconLink': 'assets/images/icon_humidity_info.png',
        'height': 30.0,
        'width': 23.0
      },
      {
        'title': 'Wind',
        'value': '${weatherData.currentWeather?.windSpeed}kmph',
        'iconLink': 'assets/images/icon_wind_info.png',
        'height': 25.0,
        'width': 35.0
      },
      {
        'title': 'Visibility',
        'value': '${weatherData.currentWeather?.visibility}',
        'iconLink': 'assets/images/icon_visibility_info.png',
        'height': 20.00,
        'width': 33.00
      },
    ];

    return Expanded(
        flex: 2,
        child: Container(
          // padding: EdgeInsets.only(left: 20),
          decoration: BoxDecoration(
              color: Colors.white10,
              border: Border(
                top: BorderSide(color: Theme.of(context).primaryColor, width: 0.5),
              )),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: weatherDetailList
                  .map((weatherDetail) => Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          const SizedBox(
                            width: 15,
                          ),
                          Image.asset(
                            weatherDetail['iconLink']! as String,
                            fit: BoxFit.contain,
                            height: weatherDetail['height'] as double,
                            width: weatherDetail['width'] as double,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(weatherDetail['title']! as String,
                                    style:
                                        const TextStyle(fontSize: 13, fontWeight: FontWeight.w400)),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(weatherDetail['value']! as String,
                                    style: Theme.of(context).textTheme.bodyMedium)
                              ]),
                        ]),
                      ))
                  .toList(),
            ),
          ),
        ));
    ;
  }
}
