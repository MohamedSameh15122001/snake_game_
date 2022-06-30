import 'package:flutter/material.dart';

class PixelOfFood extends StatelessWidget {
  const PixelOfFood({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        // Padding(
        //   padding: const EdgeInsets.all(2.0),
        //   child:
        Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Container(
          height: 24,
          width: 24,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.yellow,
          ),
          // ),
        ),
      ),
    );
  }
}
