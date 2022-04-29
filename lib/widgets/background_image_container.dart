import 'package:flutter/material.dart';

class BackgroundImageContainer extends StatelessWidget {
  final Widget? child;
  const BackgroundImageContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: Scaffold.of(context).appBarMaxHeight as double),
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background_image.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: child /* add child content here */,
    );
  }
}
