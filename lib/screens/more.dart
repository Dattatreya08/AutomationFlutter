import 'package:flutter/material.dart';
import 'package:iot/screens/appliances.dart';
import 'package:iot/screens/car_controller.dart';
import 'package:iot/screens/car_controller_command_mode.dart';
// import 'package:iot/screens/layout.dart';

class More extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        ListTile(
          leading: const Icon(Icons.gamepad_outlined,
          color:Color.fromARGB(255, 0, 52, 122),
          ),
          title: const Text(
            "Car Controller",
            style: TextStyle(color:Color.fromARGB(255, 0, 52, 122),fontWeight: FontWeight.bold),
          ),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return  SquareJoystickExample();
            }));
          },
          // contentPadding: EdgeInsets.all(8.0),
        ),

        ListTile(
          leading: const Icon(Icons.home_outlined,
            color:Color.fromARGB(255, 0, 52, 122),
          ),
          title: const Text("Home Automation",
              style: TextStyle(color:Color.fromARGB(255, 0, 52, 122),fontWeight: FontWeight.bold)
          ),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return const RoomLayout();
            }));
          },
        ),
      ]),
    );
  }
}
