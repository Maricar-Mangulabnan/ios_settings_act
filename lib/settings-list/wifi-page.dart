import 'package:flutter/cupertino.dart';

class WifiPage extends StatefulWidget {
  @override
  _WifiPageState createState() => _WifiPageState();
}

class _WifiPageState extends State<WifiPage> {
  bool isWifiEnabled = false; // Controls WiFi toggle
  bool isLoading = false; // Shows loading spinner
  bool showOtherNetworks = false; // Shows "Other Networks" text after loading
  bool showNetworks = false; // Controls visibility of available networks

  void toggleWifi(bool value) {
    setState(() {
      isWifiEnabled = value;
      isLoading = value;
      showOtherNetworks = false;
      showNetworks = false; // Hide networks initially when toggling ON
    });

    if (value) {
      // Step 1: Show "Network..." for 1 second
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          isLoading = false; // Hide spinner
          showOtherNetworks = true; // Change text to "Other Networks"
        });

        // Step 2: Show the networks list after another short delay
        Future.delayed(Duration(milliseconds: 300), () {
          setState(() {
            showNetworks = true; // Show WiFi networks
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("WiFi"),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // First Component - WiFi Toggle (Always Visible)
            WifiToggle(
              isWifiEnabled: isWifiEnabled,
              onToggle: toggleWifi,
            ),

            // Loading Spinner with "Network..." Text (Changes to "Other Networks")
            if (isWifiEnabled)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  children: [
                    if (isLoading) CupertinoActivityIndicator(), // Spinner only during loading
                    SizedBox(width: isLoading ? 10 : 0),
                    Text(
                      isLoading ? "Network..." : "Other Networks",
                      style: TextStyle(fontSize: 16, color: CupertinoColors.systemGrey),
                    ),
                  ],
                ),
              ),

            // Second Component - Available Networks (Only Appears After Loading)
            if (showNetworks)
              Expanded(
                child: WifiNetworks(),
              ),
          ],
        ),
      ),
    );
  }
}

// WiFi Toggle Component (Always Visible)
class WifiToggle extends StatelessWidget {
  final bool isWifiEnabled;
  final ValueChanged<bool> onToggle;

  WifiToggle({required this.isWifiEnabled, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: CupertinoColors.systemBlue,
                ),
                child: Icon(CupertinoIcons.wifi, color: CupertinoColors.white),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "WiFi",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          CupertinoSwitch(
            value: isWifiEnabled,
            onChanged: onToggle,
          ),
        ],
      ),
    );
  }
}

// Available Networks Component (Appears After Delay)
class WifiNetworks extends StatelessWidget {
  final List<String> networks = [
    "Jenes WiFi",
    "Cafe Network",
    "DU30 Network",
    "Public WiFi",
    "Kang WiFi"
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 10),
      itemCount: networks.length,
      itemBuilder: (context, index) {
        return CupertinoListTile(
          title: Text(networks[index]),
          leading: Icon(CupertinoIcons.wifi, color: CupertinoColors.systemBlue),
          trailing: Icon(CupertinoIcons.info, color: CupertinoColors.systemBlue),
        );
      },
    );
  }
}
