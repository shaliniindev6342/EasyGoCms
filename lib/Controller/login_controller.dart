import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:phone_state_example/Screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();


  Future<void> checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var url = Uri.parse(
        'https://easygocms.com/autodialerapp/logincheck.php?userid=${userController.text}&password=${passController.text}');

    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        String success = jsonResponse['success'];
        String message = jsonResponse['message'];

        print('Message: $message');

        if (success == "1") {
          await prefs.setString('username', userController.text);
          await prefs.setString('password', passController.text);
          await prefs.setBool('isLoggedIn', true);
          Get.offAll(() => const HomeScreen());
        } else {
          print('Login failed: $message');
          showToast(Get.context!, message, Colors.red);
        }
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  void showToast(BuildContext context, String message, Color color) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 50.0,
        left: MediaQuery.of(context).size.width * 0.1,
        right: MediaQuery.of(context).size.width * 0.1,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          ),
        ),
      ),
    );

    // Show the toast
    overlay.insert(overlayEntry);

    // Remove the toast after a duration
    Future.delayed(Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }
}
