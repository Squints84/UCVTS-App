import 'package:flutter/material.dart';

class ExtraStuff {
  static Widget weLoveAIT = Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        child: Image.asset('assets/AIT_Logo.png'), //LETS GO AIT
        alignment: Alignment.center),
      const SizedBox(
        height: 10,
      ),
      const Center(
        child: Text("BEST SCHOOL",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 38,
            color: Colors.amber,
            decoration: TextDecoration.underline,
            decorationStyle: TextDecorationStyle.double),
          textAlign: TextAlign.center
        )
      )
    ]
  ); // WE LOVE AIT (A widget to commemorate our love)

  static Widget trueCenterAlign(List<Widget> widg) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: widg
    );
  }  // Self-made aligment widget so barebonesy stuff looks nice
}
