import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:iot/screens/bluetooth_info.dart';

class BluetoothConnectivity extends StatefulWidget {
  const BluetoothConnectivity({Key? key}) : super(key: key);

  @override
  _BluetoothConnectivityState createState() => _BluetoothConnectivityState();
}

class _BluetoothConnectivityState extends State<BluetoothConnectivity> {
  List<BluetoothDevice> _pairedDevices = [];
  final List<BluetoothDevice> _availableDevices = [];
  bool _isDiscovering = false;
  bool? _isBluetoothEnabled;
  BluetoothDevice? _connectingDevice;
  BluetoothConnection? _connection;
  Map<BluetoothDevice, String> _connectionStatus = {};

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
    _connection?.close();
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

  Future<void> _connectToDevice(BluetoothDevice device) async {
    if (_connection != null) {
      await _connection!.close();
      _connection = null;
    }

    setState(() {
      _connectingDevice = device;
      _connectionStatus[device] = 'Connecting...';
    });

    try {
      BluetoothConnection connection =
      await BluetoothConnection.toAddress(device.address);

      setState(() {
        _connectingDevice = null;
        _connectionStatus[device] = 'Connected';
        _connection = connection;
      });

      // Do something with the connection, e.g., send/receive data
    } catch (e) {
      print('Connection failed: $e');
      setState(() {
        _connectingDevice = null;
        _connectionStatus[device] = 'Failed';
      });
    }
  }

  void _sendCommand(String command) {
    if (_connection != null) {
      Uint8List bytes = Uint8List.fromList(utf8.encode(command));
      _connection!.output.add(bytes);
      _connection!.output.allSent.then((_) {
        print('Command sent: $command');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bluetooth Connectivity'),
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshDevices(),
        child: ListView.builder(
          itemCount: _pairedDevices.length + _availableDevices.length + 3,
          itemBuilder: (context, index) {
            if (index == 0) {
              // Display toggle button for Bluetooth
              return ListTile(
                title: const Text('Bluetooth'),
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
            } else if (index == 1) {
              // Display "Paired Devices" ListTile
              return const ListTile(
                title: Text('Paired Devices'),
                dense: true,
              );
            } else if (index <= _pairedDevices.length + 1) {
              // Display paired device ListTile
              BluetoothDevice device = _pairedDevices[index - 2];
              bool isConnected = device == _connectingDevice;

              return ListTile(
                leading: const Icon(Icons.devices_other_outlined),
                title: Text(device.name ?? 'Unknown Device'),
                subtitle: isConnected
                    ? const Text('Connecting...')
                    : _connectionStatus.containsKey(device)
                    ? Text(_connectionStatus[device]!)
                    : Text(device.address),
                trailing: IconButton(
                  icon: Icon(Icons.info_outlined),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return BluetoothInfo();
                        },
                      ),
                    );
                  },
                ),
                onTap: () => _connectToDevice(device),
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
                    valueColor:
                    AlwaysStoppedAnimation<Color>(Colors.blue),
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
                onTap: () => _connectToDevice(device),
              );
            }
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.power_settings_new),
            label: 'On',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.power_settings_new),
            label: 'Off',
          ),
        ],
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            _sendCommand('1'); // Send '2' command when 'On' button is tapped
          } else if (index == 1) {
            _sendCommand('0'); // Send '3' command when 'Off' button is tapped
          }
        },
      ),
    );
  }
}
