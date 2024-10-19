import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class AutoCallExample extends StatefulWidget {
  const AutoCallExample({super.key});

  @override
  State<AutoCallExample> createState() => _AutoCallExampleState();
}

class _AutoCallExampleState extends State<AutoCallExample> {
  final TextEditingController _numberCtrl = TextEditingController();
  String? imeiNumber;

  @override
  void initState() {
    super.initState();
    _numberCtrl.text = '08303664238'; // Default number
    _getImeiNumber(); // Fetch IMEI on init
  }

  Future<void> _getImeiNumber() async {
    // Request permission to read phone state
    if (await Permission.phone.request().isGranted) {
      // Retrieve device info
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

      setState(() {
        // IMEI can only be accessed in Android 9 or below
        imeiNumber = androidInfo.id; // IMEI restricted in Android 10+
      });
    } else {
      // Handle permission denied
      setState(() {
        imeiNumber = "Permission denied";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Auto Call Example'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: _numberCtrl,
                decoration: const InputDecoration(labelText: "Phone Number"),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text("Test Call"),
                onPressed: () async {
                  _callNumber();
                },
              ),
              const SizedBox(height: 20),
              // Display the IMEI Number in the UI
              Text(
                imeiNumber != null
                    ? 'IMEI Number: $imeiNumber'
                    : 'Fetching IMEI...',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to call the number
  void _callNumber() async {
    String phoneNumber = _numberCtrl.text.trim();
    if (phoneNumber.isNotEmpty) {
      bool? res = await FlutterPhoneDirectCaller.callNumber(phoneNumber);
      if (res == null || !res) {
        // You can handle the error if the call fails
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to make the call')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid phone number')),
      );
    }
  }
}
