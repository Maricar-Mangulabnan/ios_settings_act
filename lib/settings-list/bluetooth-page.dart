import 'package:flutter/cupertino.dart';
import 'dart:async';

class BluetoothPage extends StatefulWidget {
  final bool isBluetoothOn; // Initial state from main.dart

  BluetoothPage({required this.isBluetoothOn});

  @override
  _BluetoothPageState createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  bool isBluetoothEnabled = false;
  bool isLoading = false;
  bool showPairedDevices = false;
  bool showOtherDevices = false;
  bool showOtherDevicesSpinner = false;

  @override
  void initState() {
    super.initState();
    // Set initial state based on the value passed from main.dart.
    isBluetoothEnabled = widget.isBluetoothOn;
    if (isBluetoothEnabled) {
      // If Bluetooth is on when the page is created, show both sections.
      showPairedDevices = true;
      showOtherDevices = true;
      showOtherDevicesSpinner = false; // No spinner when simply reopening
    }
  }

  void toggleBluetooth(bool value) {
    setState(() {
      isLoading = true;
    });

    // Simulate 1-second delay for toggle spinner
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
        isBluetoothEnabled = value;
      });
      if (value) {
        // When turning ON, show the sections and spinner beside "Other Devices"
        setState(() {
          showPairedDevices = true;
          showOtherDevices = true;
          showOtherDevicesSpinner = true;
        });
        // Remove spinner next to "Other Devices" after an additional 1 second
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            showOtherDevicesSpinner = false;
          });
        });
      } else {
        // When turning OFF, hide the sections after the toggle spinner finishes
        setState(() {
          showPairedDevices = false;
          showOtherDevices = false;
          showOtherDevicesSpinner = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Bluetooth"),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.back),
          onPressed: () {
            // Return the updated Bluetooth state to main.dart
            Navigator.pop(context, isBluetoothEnabled);
          },
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // First Component – Bluetooth Toggle (always visible)
            BluetoothToggle(
              isBluetoothEnabled: isBluetoothEnabled,
              isLoading: isLoading,
              onToggle: toggleBluetooth,
            ),

            // Text Description (always visible)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Text(
                isBluetoothEnabled
                    ? "Your device is now visible to nearby Bluetooth devices."
                    : "Turn on Bluetooth to connect to other devices.",
                style: TextStyle(fontSize: 16, color: CupertinoColors.systemGrey),
              ),
            ),

            // When Bluetooth is ON, show Paired and Other Devices sections
            if (isBluetoothEnabled) ...[
              // Second Component – Paired Devices section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Text(
                  "Paired Devices",
                  style: TextStyle(fontSize: 16, color: CupertinoColors.systemGrey),
                ),
              ),
              Expanded(child: PairedDevices()),

              // Third Component – Other Devices section with spinner beside text
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  children: [
                    Text(
                      "Other Devices",
                      style: TextStyle(fontSize: 16, color: CupertinoColors.systemGrey),
                    ),
                    if (showOtherDevicesSpinner) ...[
                      SizedBox(width: 10),
                      CupertinoActivityIndicator(),
                    ],
                  ],
                ),
              ),
              Expanded(child: BluetoothDevices()),
            ],
          ],
        ),
      ),
    );
  }
}

// Bluetooth Toggle Component
class BluetoothToggle extends StatelessWidget {
  final bool isBluetoothEnabled;
  final bool isLoading;
  final ValueChanged<bool> onToggle;

  BluetoothToggle({required this.isBluetoothEnabled, required this.isLoading, required this.onToggle});

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
                child: Icon(CupertinoIcons.bluetooth, color: CupertinoColors.white),
              ),
              SizedBox(width: 10),
              Text(
                "Bluetooth",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          isLoading
              ? CupertinoActivityIndicator()
              : CupertinoSwitch(
            value: isBluetoothEnabled,
            onChanged: onToggle,
          ),
        ],
      ),
    );
  }
}

// Second Component – Paired Devices
class PairedDevices extends StatelessWidget {
  final List<String> devices = [
    "Janzen Pro",
    "Riane Buds",
    "Jenes Audio",
    "Marikang Audio",
    "Jhoncarlo Audio",
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 10),
      itemCount: devices.length,
      itemBuilder: (context, index) {
        return CupertinoListTile(
          title: Text(devices[index]),
          // Here we wrap the trailing widgets in a Row to add a text before the info icon.
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Not Connected",
                style: TextStyle(fontSize: 14, color: CupertinoColors.systemGrey),
              ),
              SizedBox(width: 4),
              Icon(CupertinoIcons.info, color: CupertinoColors.systemBlue),
            ],
          ),
        );
      },
    );
  }
}

// Third Component – Bluetooth Devices
class BluetoothDevices extends StatelessWidget {
  final List<String> devices = [
    "Aero Speaker",
    "Laptop",
    "Samsung TV",
    "Gaming Console",
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 10),
      itemCount: devices.length,
      itemBuilder: (context, index) {
        return CupertinoListTile(
          title: Text(devices[index]),
        );
      },
    );
  }
}
