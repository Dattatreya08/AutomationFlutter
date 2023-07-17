import 'package:flutter/material.dart';
import 'package:iot/functionality/bluetooth_manager.dart';
import 'package:iot/helper/helper.dart';

class GestureButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Screen'),
      ),
      body:  const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 140,
              backgroundColor: Colors.white,
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      createCircularAvatar(30, "U", Icons.swipe_up_alt)
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      createCircularAvatar(30, "L", Icons.swipe_left_alt),
                      SizedBox(width: 20),
                      createCircularAvatar(30, "S", Icons.circle),
                      SizedBox(width: 20),
                      createCircularAvatar(30, "R", Icons.swipe_right_alt)
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      createCircularAvatar(30, "D", Icons.swipe_down_alt_rounded)
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
