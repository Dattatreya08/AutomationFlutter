import 'package:flutter/material.dart';
import 'package:iot/functionality/bluetooth_manager.dart';

class MyScreen extends StatelessWidget {
  void _sendCommand(String command) {
    BluetoothManager bluetoothManager = BluetoothManager();
    bluetoothManager.sendCommand(command);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Screen'),
      ),
      body:  Center(
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
                      CircleAvatar(
                        radius: 30,
                        child: IconButton(onPressed:(){
                          _sendCommand("U");
                        } ,
                            icon: const Icon(Icons.swipe_up_alt)
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30,
                          child: IconButton(onPressed:(){
                            _sendCommand("L");
                          } ,
                              icon: const Icon(Icons.swipe_left_alt)
                          ),
                      ),
                      const SizedBox(width: 20),
                      CircleAvatar(
                        radius: 30,
                        child: IconButton(onPressed:(){
                          _sendCommand("S");
                        } ,
                            icon: const Icon(Icons.circle)
                        ),
                      ),
                      const SizedBox(width: 20),
                      CircleAvatar(
                        radius: 30,
                        child: IconButton(onPressed:(){
                          _sendCommand("R");
                        } ,
                            icon: const Icon(Icons.swipe_right_alt)
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30,
                          child: IconButton(onPressed:(){
                            _sendCommand("D");
                          } ,
                              icon: const Icon(Icons.swipe_down_alt)
                          ),
                      ),
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
