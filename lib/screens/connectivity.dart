import 'package:flutter/material.dart';
import 'package:iot/screens/bluetooth_connectivity.dart';
import 'package:iot/screens/wifi_connectivity.dart';


class Connectivity extends StatefulWidget {
  @override
  _ConnectivityState createState() => _ConnectivityState();
}

class _ConnectivityState extends State<Connectivity> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connectivity'),
        actions: [
          IconButton(onPressed: (){

          },
              icon: Icon(Icons.bluetooth_disabled_outlined)
          ),
          IconButton(onPressed: (){

          },
              icon: Icon(Icons.wifi_off_outlined)
          )
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color.fromARGB(255, 255, 200, 0),
          indicatorWeight: 4.0,
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: const [
            Tab(text: 'Bluetooth'),
            Tab(text: 'WiFi'),
          ],
          labelColor: const Color.fromARGB(255, 255, 200, 0),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Content for Tab 1
          BluetoothConnectivity(),
          // Content for Tab 2
          WifiConnectivity()
        ],
      ),
    );
  }
}
