import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get_core/src/smart_management.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phone_state_example/Screen/splash_screen.dart';
import 'package:workmanager/workmanager.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

// FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Map<Permission, PermissionStatus> statuses = await [
    Permission.phone,
    // Permission.storage,
    // Permission.camera,
    // Permission.notification,
  ].request();

  if (statuses[Permission.phone]?.isGranted == true) {
    debugPrint("Phone permission granted");
  } else {
    debugPrint("Phone permission not granted");
    return;
  }

  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

  Workmanager().registerPeriodicTask(
    "apiCallTask",
    "simplePeriodicTask",
    frequency: const Duration(minutes: 15),
  );

  runApp(const MyApp());
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case "simplePeriodicTask":
        var request = http.MultipartRequest(
          'POST',
          Uri.parse('https://easy2join.com/app/appcallrequest.php'),
        );

        request.fields['Admin_Id'] = '123';
        request.fields['Imei_No'] = 'b7c5d204142ef23f';

        var response = await request.send();
        final responseBody = await response.stream.bytesToString();

        if (response.statusCode == 200) {
          debugPrint('Response body: $responseBody');
          final parsedResponse = jsonDecode(responseBody);

          if (parsedResponse is List && parsedResponse.isNotEmpty) {
            String mobile = parsedResponse[0]['Mobile'];
            debugPrint('Mobile: $mobile');

            String phoneNumber = mobile.trim();
            if (phoneNumber.isNotEmpty) {
              debugPrint('Initiating call to: $phoneNumber');
              bool? res = await FlutterPhoneDirectCaller.callNumber(phoneNumber);

              if (res == null || !res) {
                debugPrint('Failed to make the call.');
              } else {
                debugPrint('Call initiated successfully.');
              }
            } else {
              debugPrint('Phone number is empty.');
            }
          } else {
            debugPrint('No data found in the response.');
          }
        } else {
          debugPrint('Failed to fetch data. Status code: ${response.statusCode}');
        }
        break;

      default:
        debugPrint('Unknown task: $task');
        break;
    }
    return Future.value(true);
  });
}

void _callNumber(String mobile) async {
  String phoneNumber = mobile.trim();
  if (phoneNumber.isNotEmpty) {
    debugPrint('phone:===$phoneNumber');
    bool? res = await FlutterPhoneDirectCaller.callNumber('8303664238');
    if (res == null || !res) {
      debugPrint('Failed to make the call.');
    } else {
      debugPrint('Call initiated successfully.');
    }
  } else {
    debugPrint('Phone number is empty.');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      builder: (context, child) {
        return GetMaterialApp(
          smartManagement: SmartManagement.keepFactory,
          debugShowCheckedModeBanner: false,
          title: 'help',
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: const Color(0xff018577)),
            useMaterial3: true,
          ),
          builder: FlutterSmartDialog.init(),
          home: const SplashScreen(),
        );
      },
    );
  }
}

// Callback function for background task
// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     try {
//       WidgetsFlutterBinding.ensureInitialized();
//       const AndroidInitializationSettings initializationSettingsAndroid =
//           AndroidInitializationSettings('@mipmap/ic_launcher');
//       const InitializationSettings initializationSettings =
//           InitializationSettings(android: initializationSettingsAndroid);
//       await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//       debugPrint('Periodic task executed: $task');
//       final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));
//       if (response.statusCode == 200) {
//         _showNotification();
//       } else {
//         debugPrint('Failed to fetch products. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       debugPrint('Error executing task: $e');
//     }
//     return Future.value(true);
//   });
// }
// Future<void> _showNotification() async {
//   const AndroidNotificationDetails androidPlatformChannelSpecifics =
//       AndroidNotificationDetails(
//     'your_channel_id',
//     'your_channel_name',
//     channelDescription: 'your_channel_description',
//     importance: Importance.max,
//     priority: Priority.high,
//     showWhen: false,
//   );

//   const NotificationDetails platformChannelSpecifics =
//       NotificationDetails(android: androidPlatformChannelSpecifics);
//   await flutterLocalNotificationsPlugin.show(
//     0,
//     'Notification Task',
//     'API call executed successfully!',
//     platformChannelSpecifics,
//     payload: 'data',
//   );
// }
