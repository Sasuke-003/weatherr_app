import 'package:flutter/material.dart';
import 'package:weather_app/screens/home_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    return Drawer(
        child: Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        ListTile(
          title: Text('Home'),
          onTap: () {
            if (currentRoute != HomeScreen.routeName) {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            } else {
              Scaffold.of(context).openEndDrawer();
            }
          },
        ),
      ],
    ));
  }
}
