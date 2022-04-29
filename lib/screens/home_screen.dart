import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather.dart';
import 'package:weather_app/screens/search_screen.dart';
import 'package:weather_app/widgets/app_drawer.dart';
import 'package:weather_app/widgets/background_image_container.dart';
import 'package:weather_app/widgets/location_details.dart';
import 'package:weather_app/widgets/my_app_bar.dart';
import 'package:weather_app/widgets/temperature_details.dart';

import 'package:weather_app/widgets/weather_details.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/';
  final locName;
  final Function setLocation;

  const HomeScreen({Key? key, required this.locName, required this.setLocation}) : super(key: key);

  Widget loadingWidgetBuilder() {
    return const BackgroundImageContainer(
        child: Center(
      child: CircularProgressIndicator(),
    ));
  }

  Widget errorWidgetBuilder() {
    return const BackgroundImageContainer(
        child: Center(
      child: Text('error'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        drawer: AppDrawer(),
        appBar: MyAppBar(
          setLocation: setLocation,
          appBar: AppBar(),
        ),
        body: FutureBuilder(
            future: (locName == null || locName.isEmpty)
                ? Provider.of<Weather>(context, listen: false).getWeatherByLocName()
                : Provider.of<Weather>(context, listen: false)
                    .getWeatherByLocName(locName: locName),
            builder: (BuildContext ctx, dataSnapshot) {
              if (dataSnapshot.connectionState == ConnectionState.waiting) {
                return loadingWidgetBuilder();
              }

              if (dataSnapshot.error != null) {
                return errorWidgetBuilder();
              }

              return HomeScreenBody();
            }));
  }
}

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    return BackgroundImageContainer(
      child: isLandscape
          ? CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      LocationDetails(),
                      TemperatureDetails(),
                      const SizedBox(
                        height: 30,
                      ),
                      WeatherDetails()
                    ],
                  ),
                ),
              ],
            )
          : Column(
              children: [LocationDetails(), TemperatureDetails(), WeatherDetails()],
            ),
    );
  }
}
