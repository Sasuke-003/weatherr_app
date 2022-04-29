import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeDisplay extends StatefulWidget {
  const TimeDisplay({Key? key}) : super(key: key);

  @override
  State<TimeDisplay> createState() => _TimeDisplayState();
}

class _TimeDisplayState extends State<TimeDisplay> {
  String? _now;
  Timer? _everySecond;

  @override
  void initState() {
    super.initState();

    // sets first value
    _now = DateTime.now().second.toString();

    // defines a timer
    _everySecond = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        _now = DateTime.now().second.toString();
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _everySecond?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      DateFormat('EEE, d MMM yyyy, HH:mm a', 'en_US').format(DateTime.now()),
      style: Theme.of(context).textTheme.bodySmall,
    );
  }
}
