import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:iot/functionality/bluetooth_manager.dart';

const ballSize = 20.0;
const step = 10.0;

class SquareJoystickExample extends StatefulWidget {
  const SquareJoystickExample({Key? key}) : super(key: key);

  @override
  _SquareJoystickExampleState createState() => _SquareJoystickExampleState();
}

class _SquareJoystickExampleState extends State<SquareJoystickExample> {
  double _x = 0;
  double _y = 0;
  JoystickMode _joystickMode = JoystickMode.all;

  void _sendCommand(String command) {
    BluetoothManager bluetoothManager = BluetoothManager();
    bluetoothManager.sendCommand(command);
  }

  void _controller(){
    if( _x==0.0 && _y==0){
      _sendCommand("S");
    }else if( _x==0.0 && (_y<0.0 && _y>=-10.0)){
      _sendCommand("U");
    }else if( _x==0.0 && (_y>0.0 && _y<=10.0)){
      _sendCommand("D");
    }else if( (_x<0.0 && _x>=-10.0) && _y==0.0){
      _sendCommand("L");
    }else if( (_x>0.0 && _x<=10.0) && _y==0.0){
      _sendCommand("R");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,

      body: SafeArea(
        child: Stack(
          children: [
            Container(
              color: Colors.white,
              child: Text("${_x}   ${_y}"),
            ),
            // Ball(_x, _y),
            Align(
              alignment: const Alignment(0, 0.8),
              child: Joystick(
                mode: JoystickMode.horizontalAndVertical,
                base: JoystickSquareBase(mode: _joystickMode),
                stickOffsetCalculator: const RectangleStickOffsetCalculator(),
                listener: (details) {
                  setState(() {
                    _x =  step*details.x;
                    _y = step * details.y;
                    _controller();
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
