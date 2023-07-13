import 'package:flutter/material.dart';
import 'package:iot/screens/layout.dart';
import 'package:iot/screens/wifi_connectivity.dart';
class More extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.gamepad_outlined),
            title: const Text("Car Controller"),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder:(BuildContext context){
                  return MainPage();
              }));
            },
          ),

          ListTile(
            leading: const Icon(Icons.gamepad_outlined),
            title: const Text("Home Automation"),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder:(BuildContext context){
                return Text("Under Development");
              }));
            },
          )
        ],
      ),
    );
  }
}
