import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/screens/search_screen.dart';

import './providers/weather.dart';

import './screens//home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MaterialColor white = const MaterialColor(
    0xFFFFFFFF,
    <int, Color>{
      50: Color(0xFFFFFFFF),
      100: Color(0xFFFFFFFF),
      200: Color(0xFFFFFFFF),
      300: Color(0xFFFFFFFF),
      400: Color(0xFFFFFFFF),
      500: Color(0xFFFFFFFF),
      600: Color(0xFFFFFFFF),
      700: Color(0xFFFFFFFF),
      800: Color(0xFFFFFFFF),
      900: Color(0xFFFFFFFF),
    },
  );

  String? locName = null;

  void setLocName(String value) {
    setState(() {
      locName = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Weather(),
      child: MaterialApp(
        title: 'weather_app',
        theme: ThemeData(
            // primaryColor: Colors.white,
            // backgroundColor: Colors.black,
            primarySwatch: white,
            accentColor: Colors.deepOrange,
            textTheme: ThemeData.light().textTheme.copyWith(
                  bodySmall: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                      letterSpacing: 1.5),
                  bodyMedium: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                  titleMedium: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                )),
        initialRoute: HomeScreen.routeName,
        routes: {
          HomeScreen.routeName: (ctx) => HomeScreen(locName: locName, setLocation: setLocName),
          SearchScreen.routeName: (ctx) => SearchScreen(),
        },
      ),
    );
  }
}
