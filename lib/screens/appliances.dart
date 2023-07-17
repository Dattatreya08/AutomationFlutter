import 'package:flutter/material.dart';
import 'package:iot/helper/helper.dart';
class RoomLayout extends StatefulWidget {
  const RoomLayout({Key? key}) : super(key: key);

  @override
  State<RoomLayout> createState() => _RoomLayoutState();
}

class _RoomLayoutState extends State<RoomLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Automation"),
      ),
      body:  Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView(
          children:const [ Row(
            children: [
              Expanded(
                  child: CreateCardButton(Icons.lightbulb_outline,"Light","1","2")
              ),
              Expanded(
                  child: CreateCardButton(Icons.wind_power_outlined,"Fan","3","4")
              ),
            ],
          ),

            Row(
              children: [
                Expanded(
                    child: CreateCardButton(Icons.tv_outlined,"Television","5","6")
                ),
                Expanded(
                    child: CreateCardButton(Icons.ac_unit_outlined,"AC","7","8")
                ),
              ],
            ),

            Row(
              children: [
                Expanded(
                    child: CreateCardButton(Icons.power_outlined,"Appliance","10","11")
                ),
                Expanded(
                    child: CreateCardButton(Icons.power_settings_new_outlined,"All On","9","0")
                ),
              ],
            ),
          ]
        ),
      ),
    );
  }
}
