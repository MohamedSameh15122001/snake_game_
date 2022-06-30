import 'dart:math';

import 'package:flutter/material.dart';
import 'package:snake_game/methods.dart';

class PixelOfSnake extends StatelessWidget {
  const PixelOfSnake({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        // Padding(
        //   padding: const EdgeInsets.all(2.0),
        //   child:
        Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Transform.rotate(
          angle: currentDirection == snakeDirections.RIGHT ||
                  currentDirection == snakeDirections.LEFT
              ? pi
              : pi / 2,
          child: Container(
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.green,
            ),
            // ),
          ),
        ),
      ),
    );
  }
}
