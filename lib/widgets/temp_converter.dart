import 'package:converter/converter.dart';
import 'package:flutter/material.dart';

class TempConverter extends StatefulWidget {
  final double tempKelvin;

  const TempConverter({Key? key, required this.tempKelvin}) : super(key: key);

  @override
  State<TempConverter> createState() => _TempConverterState();
}

class _TempConverterState extends State<TempConverter> {
  final borderSide = const BorderSide(color: Colors.white, width: 2);
  bool isCelsius = true;

  tempButtonBuilder(VoidCallback onClick, String label, isEnabled) => Expanded(
        child: GestureDetector(
          onTap: onClick,
          child: Container(
            alignment: Alignment.center,
            child: Text(
              label,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isEnabled
                      ? Color.fromARGB(255, 192, 47, 47)
                      : Theme.of(context).primaryColor),
            ),
            decoration: BoxDecoration(color: isEnabled ? Colors.white : Colors.transparent),
          ),
        ),
      );

  String kelvinToCelsius(double kelvin) {
    return (kelvin - 273.15).toStringAsFixed(0);
  }

  String kelvinToFahrenheit(double kelvin) {
    return ((kelvin - 273.15) * (9 / 5) + 32).toStringAsFixed(0);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          isCelsius ? kelvinToCelsius(widget.tempKelvin) : kelvinToFahrenheit(widget.tempKelvin),
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 70,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 17),
          height: 35,
          width: 65,
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(2)),
          child: Row(children: [
            tempButtonBuilder(() {
              setState(() {
                isCelsius = true;
              });
            }, '\u2103', isCelsius),
            tempButtonBuilder(() {
              setState(() {
                isCelsius = false;
              });
            }, '\u2109', !isCelsius),
          ]),
        ),
      ],
    );
  }
}
