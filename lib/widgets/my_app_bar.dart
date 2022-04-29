import 'package:flutter/material.dart';
import 'package:weather_app/screens/search_screen.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;
  final Function setLocation;
  const MyAppBar({Key? key, required this.appBar, required this.setLocation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // shape: Border(bottom: BorderSide(color: Colors.white38, width: 1.5)),
      centerTitle: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: Theme.of(context).primaryColor,
      title: Image.asset(
        "assets/images/logo_splash.png",
        fit: BoxFit.contain,
        width: 120,
      ),
      actions: [
        IconButton(
            // padding: EdgeInsets.only(right: 10),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(SearchScreen.routeName)
                  .then((value) => setLocation(value));
            },
            icon: Icon(Icons.search))
      ],
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
