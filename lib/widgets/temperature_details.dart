import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weather_app/widgets/temp_converter.dart';
import 'package:weather_app/providers/weather.dart';

class TemperatureDetails extends StatelessWidget {
  const TemperatureDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<Weather>(context);
    return Expanded(
        flex: 7,
        child: Container(
          margin: EdgeInsets.only(top: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                'https://openweathermap.org/img/wn/${weatherData.currentWeather?.iconName}@4x.png',
                fit: BoxFit.cover,
                width: 190,
                height: 120,
              ),
              TempConverter(
                tempKelvin: weatherData.currentWeather?.temp as double,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                weatherData.currentWeather?.title as String,
                style: Theme.of(context).textTheme.bodyMedium,
              )
            ],
          ),
        ));
  }
}
