
import 'package:flutter/cupertino.dart';
import 'settings-list/bluetooth-page.dart';
import 'settings-list/wifi-page.dart';

void main() => runApp(CupertinoApp(
  theme: CupertinoThemeData(
    brightness: Brightness.light,
  ),
  debugShowCheckedModeBanner: false,
  home: MyApp(),
));

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool airplaneMode = false;
  bool isBluetoothOn = false; // Bluetooth status

  // Function to navigate to BluetoothPage and update status dynamically
  Future<void> navigateToBluetoothPage() async {
    final result = await Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => BluetoothPage(isBluetoothOn: isBluetoothOn)),
    );

    if (result != null && result is bool) {
      setState(() {
        isBluetoothOn = result; // Update Bluetooth status dynamically
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Settings', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        child: SafeArea(
            child: Column(
              children: [
                Expanded(
                    child: ListView(
                      children: [
                        const SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: CupertinoSearchTextField(
                            placeholder: "Search",
                            prefixInsets: const EdgeInsets.all(8),
                            suffixInsets: const EdgeInsets.all(8),
                            suffixIcon: const Icon(CupertinoIcons.mic_fill, size: 18),
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                            borderRadius: BorderRadius.circular(10),
                            backgroundColor: CupertinoColors.systemGrey6,
                          ),

                        ),

                        const SizedBox(height: 25),

                        // User Profile Section
                        CupertinoListTile(
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                          title: const Text(
                            'Maricar Mangulabnan ',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: const Text(
                            'Apple Account, iCloud, and more',
                            style: TextStyle(
                              fontSize: 12,
                              color: CupertinoColors.systemGrey,
                            ),
                          ),
                          leading: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: CupertinoColors.systemGrey,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: const Icon(
                                CupertinoIcons.person_fill,
                                color: CupertinoColors.white,
                                size: 24,
                              ),
                            ),
                          ),
                          leadingSize: 40,
                          trailing: const Icon(
                            CupertinoIcons.chevron_forward,
                            color: CupertinoColors.systemGrey2,
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Airplane Mode Toggle
                        CupertinoListTile(
                          title: Text('Airplane Mode'),
                          leading: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: CupertinoColors.systemOrange),
                              child: Icon(CupertinoIcons.airplane, color: CupertinoColors.white)
                          ),
                          leadingSize: 32,
                          trailing: CupertinoSwitch(
                              value: airplaneMode,
                              onChanged: (value) {
                                setState(() {
                                  airplaneMode = value;
                                });
                              }),
                        ),

                        // WiFi Navigation
                        CupertinoListTile(
                          title: Text('WiFi'),
                          leading: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: CupertinoColors.systemBlue),
                              child: Icon(CupertinoIcons.wifi, color: CupertinoColors.white)
                          ),
                          leadingSize: 32,
                          additionalInfo: Text('Kang Wifi'),
                          trailing: Icon(CupertinoIcons.chevron_forward, color: CupertinoColors.systemGrey2),
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(builder: (context) => WifiPage()),
                            );
                          },
                        ),

                        // Bluetooth Navigation with Dynamic Status
                        CupertinoListTile(
                          title: Text('Bluetooth'),
                          leading: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: CupertinoColors.systemBlue),
                              child: Icon(CupertinoIcons.bluetooth, color: CupertinoColors.white)
                          ),
                          leadingSize: 32,
                          additionalInfo: Text(isBluetoothOn ? 'On' : 'Off'),
                          trailing: Icon(CupertinoIcons.chevron_forward, color: CupertinoColors.systemGrey2),
                          onTap: navigateToBluetoothPage,
                        ),

                        // Cellular
                        CupertinoListTile(
                          title: Text('Cellular'),
                          leading: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: CupertinoColors.systemGreen),
                              child: Icon(CupertinoIcons.antenna_radiowaves_left_right, color: CupertinoColors.white)
                          ),
                          leadingSize: 32,
                          trailing: Icon(CupertinoIcons.chevron_forward, color: CupertinoColors.systemGrey2),
                        ),

                        // Personal Hotspot
                        CupertinoListTile(
                          title: Text('Personal Hotspot'),
                          leading: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: CupertinoColors.systemGreen),
                              child: Icon(CupertinoIcons.antenna_radiowaves_left_right, color: CupertinoColors.white)
                          ),
                          leadingSize: 32,
                          trailing: Icon(CupertinoIcons.chevron_forward, color: CupertinoColors.systemGrey2),
                        ),
                      ],
                    ))
              ],
            )));
  }
}