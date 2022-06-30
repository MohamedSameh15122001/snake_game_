import 'dart:math';

import 'package:flutter/material.dart';
import 'package:snake_game/methods.dart';

class PixelOfHead extends StatelessWidget {
  const PixelOfHead({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double theHeadDirection() {
      if (currentDirection == snakeDirections.RIGHT) {
        return pi + 5 / pi;
      } else if (currentDirection == snakeDirections.LEFT) {
        return pi / 2;
      } else if (currentDirection == snakeDirections.UP) {
        return pi;
      }
      return pi * 2;
    }

    return
        // Padding(
        //   padding: const EdgeInsets.all(2.0),
        //   child:
        Scaffold(
      backgroundColor: Colors.grey[900],
      body: Transform.rotate(
        angle: theHeadDirection(),
        child: Container(
          height: 200,
          width: 200,
          decoration: const BoxDecoration(
              // borderRadius: BorderRadius.circular(10),
              // color: Colors.brown,
              ),
          child: Image.asset('assets/images/head.png'),
          // ),
        ),
      ),
    );
  }
}
