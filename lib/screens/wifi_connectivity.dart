import 'package:flutter/material.dart';
import 'package:wifi_iot/wifi_iot.dart';

const String STA_DEFAULT_SSID = "STA_SSID";
const String STA_DEFAULT_PASSWORD = "STA_PASSWORD";
const NetworkSecurity STA_DEFAULT_SECURITY = NetworkSecurity.WPA;

class WifiConnectivity extends StatefulWidget {
  const WifiConnectivity({Key? key}) : super(key: key);

  @override
  _WifiConnectivityState createState() => _WifiConnectivityState();
}

class _WifiConnectivityState extends State<WifiConnectivity> {
  bool _isEnabled = false;
  bool _isConnected = false;

  @override
  void initState() {
    super.initState();
    WiFiForIoTPlugin.isEnabled().then((val) {
      setState(() {
        _isEnabled = val;
      });
    });

    WiFiForIoTPlugin.isConnected().then((val) {
      setState(() {
        _isConnected = val;
      });
    });
  }

  void enableWifi() {
    WiFiForIoTPlugin.setEnabled(true, shouldOpenSettings: true);
  }

  void disableWifi() {
    WiFiForIoTPlugin.setEnabled(false, shouldOpenSettings: true);
  }

  Future<void> connectToNetwork() async {
    if (_isConnected) {
      await WiFiForIoTPlugin.disconnect();
    } else {
      await WiFiForIoTPlugin.forceWifiUsage(true);
      await WiFiForIoTPlugin.connect(STA_DEFAULT_SSID,
          password: STA_DEFAULT_PASSWORD,
          joinOnce: true,
          security: STA_DEFAULT_SECURITY);
    }

    WiFiForIoTPlugin.isConnected().then((val) {
      setState(() {
        _isConnected = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: ListView(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            if (_isConnected)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Connected",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  DataTable(
                    columnSpacing: 16,
                    columns: const [
                      DataColumn(label: Text('Attribute')),
                      DataColumn(label: Text('Value')),
                    ],
                    rows: [
                      DataRow(
                        cells: [
                          DataCell(Text('SSID')),
                          DataCell(FutureBuilder(
                            future: WiFiForIoTPlugin.getSSID(),
                            initialData: "Loading..",
                            builder: (BuildContext context,
                                AsyncSnapshot<String?> ssid) {
                              return Text(ssid.data ?? '');
                            },
                          )),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(Text('BSSID')),
                          DataCell(FutureBuilder(
                            future: WiFiForIoTPlugin.getBSSID(),
                            initialData: "Loading..",
                            builder: (BuildContext context,
                                AsyncSnapshot<String?> bssid) {
                              return Text(bssid.data ?? '');
                            },
                          )),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(Text('Signal')),
                          DataCell(FutureBuilder(
                            future: WiFiForIoTPlugin.getCurrentSignalStrength(),
                            initialData: 0,
                            builder: (BuildContext context,
                                AsyncSnapshot<int?> signal) {
                              return Text(signal.data?.toString() ?? '');
                            },
                          )),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(Text('Frequency')),
                          DataCell(FutureBuilder(
                            future: WiFiForIoTPlugin.getFrequency(),
                            initialData: 0,
                            builder: (BuildContext context,
                                AsyncSnapshot<int?> freq) {
                              return Text(freq.data?.toString() ?? '');
                            },
                          )),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(Text('IP')),
                          DataCell(FutureBuilder(
                            future: WiFiForIoTPlugin.getIP(),
                            initialData: "Loading..",
                            builder: (BuildContext context,
                                AsyncSnapshot<String?> ip) {
                              return Text(ip.data ?? '');
                            },
                          )),
                        ],
                      ),
                    ],
                  ),
                ],
              )
            else
              const Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Disconnected",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 280,)
                  ]),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _isEnabled ? disableWifi : enableWifi,
                  child: Text(_isEnabled ? 'Disable WiFi' : 'Enable WiFi'),
                ),
                ElevatedButton(
                  onPressed: connectToNetwork,
                  child: Text(_isConnected ? 'Disconnect' : 'Connect'),
                ),
              ],
            ),
          ],
        ),
      ]),
    );
  }
}

