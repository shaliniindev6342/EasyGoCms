
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_state_example/Screen/home_screen.dart';
import 'package:phone_state_example/Screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
    // _navigateToLogin();
  }

  void _navigateToLogin() {
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    await Future.delayed(const Duration(seconds: 3));
    if (isLoggedIn) {
      Get.offAll(() => const HomeScreen());
    } else {
      Get.offAll(() => const LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    // color: Colors.yellow,
                    // height: 200,
                    child: Image.asset('assets/logo_easygocms.png')),
                // Text(
                //   'EasyGoCms',
                //   style: TextStyle(
                //       color: Color(0xFFCC0001),
                //       fontWeight: FontWeight.bold,
                //       fontSize: 30),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
