import 'package:flutter/material.dart';
import 'package:iot/screens/car_controller.dart';
class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>  JoystickExample()),
              );
            },
            child: const Text('Joystick'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>  JoystickAreaExample()),
              );
            },
            child: const Text('Joystick Area'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>  SquareJoystickExample()),
              );
            },
            child: const Text('Square Joystick'),
          ),
        ],
      ),
    );
  }
}