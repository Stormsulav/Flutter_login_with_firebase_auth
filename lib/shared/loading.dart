import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown[100], // background color
      child: Center(
        child: SpinKitFadingFour(
          color: Colors.brown,
          size: 40.0,
        ),
      ),
    );
  }
}