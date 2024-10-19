import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:phone_state_example/Controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController loginController = Get.put(LoginController());

  void _callNumber() async {
    String phoneNumber = loginController.userController.text.trim();
    if (phoneNumber.isNotEmpty) {
      debugPrint('phone:===$phoneNumber');
      bool? res = await FlutterPhoneDirectCaller.callNumber(phoneNumber);
      if (res == null || !res) {
        debugPrint('Failed to make the call.');
      } else {
        debugPrint('Call initiated successfully.');
      }
    } else {
      debugPrint('Phone number is empty.');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _callNumber();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFCC0001),
          title: const Text('Login',
              style: TextStyle(color: Colors.white, fontSize: 13)),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/logoeasygocms2.jpeg'),
            // child: Image.asset('assets/logoeasygocms2-removebg-preview.png'),
          ),
        ),
        body: Form(
          key: loginController.formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                      color: Colors.white,
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  _callNumber();
                                },
                                child: Text('click')),
                            TextFormField(
                              controller: loginController.userController,
                              decoration: const InputDecoration(
                                labelText: 'User Name',
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Color(0xFFCC0001),
                                ),
                                prefixIconConstraints: BoxConstraints(
                                  minWidth: 0,
                                  minHeight: 0,
                                ),
                                contentPadding: EdgeInsets.zero,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter user name';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: loginController.passController,
                              decoration: const InputDecoration(
                                // hintText: 'Password',
                                labelText: 'Password',
                                prefixIcon: Icon(Icons.lock_outline,
                                    color: Color(0xFFCC0001)),
                                prefixIconConstraints: BoxConstraints(
                                  minWidth: 0,
                                  minHeight: 0,
                                ),
                                contentPadding: EdgeInsets.zero,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter password';
                                }
                                return null;
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.all(25),
                              child: InkWell(
                                onTap: () {
                                  if (loginController.formKey.currentState!
                                      .validate()) {
                                    loginController.checkLogin();
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFCC0001),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                  ),
                                  child: const Text(
                                    'Sign in',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: const Color(0xFFCC0001),
          child: const Text(
            'By : Manthan IT Solutions',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
