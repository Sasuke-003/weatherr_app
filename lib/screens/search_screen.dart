import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather.dart';
import 'package:weather_app/screens/home_screen.dart';
import 'package:weather_app/widgets/background_image_container.dart';

class SearchScreen extends StatefulWidget {
  static final routeName = '/search';
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool _placeNotFound = false;
  final _searchFieldController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _searchFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: TextField(
          onChanged: (_) {
            if (_placeNotFound = true) {
              setState(() {
                _placeNotFound = false;
              });
            }
          },
          controller: _searchFieldController,
          onEditingComplete: () async {
            try {
              bool found = await Provider.of<Weather>(context, listen: false)
                  .getWeatherByLocName(locName: _searchFieldController.text.toUpperCase());
              if (found) {
                Navigator.of(context).pop(_searchFieldController.text.toUpperCase());
              } else {
                setState(() {
                  _placeNotFound = true;
                });
              }
            } catch (error) {
              setState(() {
                _placeNotFound = true;
              });
            }
          },
          cursorColor: const Color.fromRGBO(115, 115, 115, 1),
          style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
          decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Search for city',
              hintStyle: TextStyle(color: Colors.black38, fontWeight: FontWeight.w300)),
        ),
        actions: [
          if (_searchFieldController.text.length > 0)
            IconButton(
                onPressed: () {
                  _searchFieldController.clear();
                },
                icon: Icon(Icons.clear_outlined))
        ],
      ),
      body: _placeNotFound
          ? Center(
              child: Container(
                decoration: BoxDecoration(color: Colors.grey),
                child: Image.asset(
                  'assets/images/icon_nothing.png',
                  fit: BoxFit.contain,
                  width: 200,
                ),
              ),
            )
          : null,
    );
  }
}
