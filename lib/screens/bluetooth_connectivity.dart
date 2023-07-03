import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothDevicesPage extends StatefulWidget {
  @override
  _BluetoothDevicesPageState createState() => _BluetoothDevicesPageState();
}

class _BluetoothDevicesPageState extends State<BluetoothDevicesPage> {
  List<BluetoothDevice> _pairedDevices = [];
  List<BluetoothDevice> _availableDevices = [];
  bool _isDiscovering = false;
  bool? _isBluetoothEnabled;

  @override
  void initState() {
    super.initState();
    _checkBluetoothStatus();
    _startDiscovery();
    _getPairedDevices();
  }

  Future<void> _checkBluetoothStatus() async {
    bool? isEnabled = await FlutterBluetoothSerial.instance.isEnabled;
    setState(() {
      _isBluetoothEnabled = isEnabled;
    });
  }

  Future<void> _enableBluetooth() async {
    await FlutterBluetoothSerial.instance.requestEnable();
    _checkBluetoothStatus();
  }

  Future<void> _disableBluetooth() async {
    await FlutterBluetoothSerial.instance.requestDisable();
    _checkBluetoothStatus();
  }

  @override
  void dispose() {
    _cancelDiscovery();
    super.dispose();
  }

  dynamic _startDiscovery() async {
    setState(() {
      _isDiscovering = true;
    });

    FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      setState(() {
        _availableDevices.add(r.device);
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

  Future<void> _getPairedDevices() async {
    List<BluetoothDevice> devices =
    await FlutterBluetoothSerial.instance.getBondedDevices();
    setState(() {
      _pairedDevices = devices;
    });
  }

  Future<void> _refreshDevices() async {
    setState(() {
      _availableDevices.clear();
    });
    await _startDiscovery();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _refreshDevices(),
      child: ListView.builder(
        itemCount: _pairedDevices.length + _availableDevices.length + 3,
        itemBuilder: (context, index) {
          if (index == 0) {
            // Display toggle button for Bluetooth
            return ListTile(
              title: Text('Bluetooth'),
              trailing: Switch(
                value: _isBluetoothEnabled ?? false,
                onChanged: (value) {
                  if (value) {
                    _enableBluetooth();
                  } else {
                    _disableBluetooth();
                  }
                },
              ),
            );
          }   else if (index == 1) {
            // Display "Paired Devices" ListTile
            return ListTile(
                            title: Text('Paired Devices'),
              dense: true,
            );
          } else if (index <= _pairedDevices.length + 1) {
            // Display paired device ListTile
            BluetoothDevice device = _pairedDevices[index - 2];
            return ListTile(
              leading: Icon(Icons.devices_other_outlined),
              title: Text(device.name ?? 'Unknown Device'),
              subtitle: Text(device.address),
              onTap: () {
                // Handle device selection
              },
            );
          } else if (index == _pairedDevices.length + 2) {
            // Display "Available Devices" ListTile with refresh button
            return ListTile(
              title: const Text('Available Devices'),
              dense: true,
              trailing: _isDiscovering
                  ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              )
                  : TextButton(
                onPressed: _refreshDevices,
                child: const Text('Refresh'),
              ),
            );
          } else {
            // Display available device ListTile
            BluetoothDevice device =
            _availableDevices[index - _pairedDevices.length - 3];
            return ListTile(
              leading: const Icon(Icons.device_hub_outlined),
              title: Text(device.name ?? 'Unknown Device'),
              subtitle: Text(device.address),
              onTap: () {
                // Handle device selection
              },
            );
          }
        },
      ),
    );
  }
}