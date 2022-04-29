import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather.dart';
import 'package:weather_app/widgets/time_display.dart';

class LocationDetails extends StatelessWidget {
  const LocationDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<Weather>(context);

    return
        // Consumer<Weather>(
        //     builder: (_, weatherData, __) =>
        Expanded(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TimeDisplay(),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${weatherData.currentPlaceName}, ${weatherData.currentWeather?.country as String}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton.icon(
                  onPressed: () {
                    weatherData.toggleFavoriteStatus(weatherData.currentPlaceName);
                    // add to fav
                  },
                  icon: Icon(weatherData.currentWeather?.isFavorite as bool
                      ? Icons.favorite
                      : Icons.favorite_border),
                  label: Text('Add to Favorite'),
                )
              ],
            )
            // )
            );
  }
}
