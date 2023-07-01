import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothDevicesPage extends StatefulWidget {
  @override
  _BluetoothDevicesPageState createState() => _BluetoothDevicesPageState();
}

class _BluetoothDevicesPageState extends State<BluetoothDevicesPage> {
  List<BluetoothDevice> _devicesList = [];
  bool _isDiscovering = false;

  @override
  void initState() {
    super.initState();
    _startDiscovery();
  }

  @override
  void dispose() {
    _cancelDiscovery();
    super.dispose();
  }

  void _startDiscovery() async {
    setState(() {
      _isDiscovering = true;
    });

    FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      setState(() {
        _devicesList.add(r.device);
      });
    }).onDone(() {
      setState(() {
        _isDiscovering = false;
      });
    });
  }

  void _cancelDiscovery() {
    FlutterBluetoothSerial.instance.cancelDiscovery();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_isDiscovering)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          ),
        Expanded(
          child: ListView.builder(
            itemCount: _devicesList.length,
            itemBuilder: (context, index) {
              BluetoothDevice device = _devicesList[index];
              return ListTile(
                title: Text(device.address ?? ''),
                subtitle: Text(device.address),
                onTap: () {
                  // Handle device selection
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
