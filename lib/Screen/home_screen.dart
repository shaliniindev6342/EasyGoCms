
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_state_example/Screen/data_alloting.dart';
import 'package:phone_state_example/Screen/data_export.dart';
import 'package:phone_state_example/Screen/delete_data.dart';
import 'package:phone_state_example/Screen/login_screen.dart';
import 'package:phone_state_example/Screen/lost_customer.dart';
import 'package:phone_state_example/Screen/psf.dart';
import 'package:phone_state_example/Screen/sales_enquiry.dart';
import 'package:phone_state_example/Screen/service_reminder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFCC0001),
          title: const Text(
            'EasyGoCms',
            style: TextStyle(color: Colors.white, fontSize: 13),
          ),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/logoeasygocms2.jpeg'),
          ),
          actions: [
            Row(
              children: [
                const Icon(
                  Icons.help_outline,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 7,
                ),
                PopupMenuButton<int>(
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 1,
                      child: Text("Logout"),
                    ),
                  ],
                  onSelected: (value) async {
                    if (value == 1) {
                      final prefs = await SharedPreferences.getInstance();
                      prefs.clear();
                      Get.offAll(() => const LoginScreen());
                    }
                  },
                  child: const Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                )
              ],
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              const Text(
                'DATA CONTROL',
              ),
              const Divider(),
              Container(
                padding: const EdgeInsets.all(9),
                color: Colors.white,
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  // crossAxisSpacing: 15,
                  mainAxisSpacing: 0,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const DataAlloting(), 
                          ),
                        );
                      },
                      child: const TabWidget(
                        icon: Icons.cloud_sync_sharp,
                        color: Color(0xff0099D9),
                        text: 'Data \nAllot',
        
                      ),
                    ),
                    InkWell(
                      onTap: (){
                         Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const DataExport(),
                          ),
                        );
                      },
                      child: const TabWidget(
                        icon: Icons.open_in_browser_rounded,
                        color: Color(0xffED7C00),
                        text: 'Data \nExport',
                      ),
                    ),
                    InkWell(
                      onTap: (){
                         Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const DeleteData(),
                          ),
                        );
                      },
                      child: const TabWidget(
                        icon: Icons.delete_rounded,
                        color: Color(0xffF74D4D),
                        text: 'Data \nDelete',
                      ),
                    ),
                    const TabWidget(
                      icon: Icons.notifications_on,
                      color: Color(0xffCA1212),
                      text: 'Notification',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'DATA CALLING',
              ),
              const Divider(),
              Container(
                padding: const EdgeInsets.all(9),
                color: Colors.white,
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  // crossAxisSpacing: 15,
                  mainAxisSpacing: 0,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const ServiceReminder(),
                          ),
                        );
                      },
                      child: const TabWidget(
                        icon: Icons.data_exploration_outlined,
                        color: Color(0xff138CFF),
                        text: 'Service \nReminder',
                      ),
                    ),
                    InkWell(
                      onTap: (){
                         Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const Psf(), 
                          ),
                        );
                      },
                      child: const TabWidget(
                        icon: Icons.data_exploration_outlined,
                        color: Color(0xffB0161E),
                        text: 'PSF',
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const LostCustomer(),
                          ),
                        );
                      },
                      child: const TabWidget(
                        assetImage: 'assets/lost_customer.png',
                        // icon: Icons.data_exploration_outlined,
                        color: Color(0xffD08C2B),
                        text: 'Lost \nCustomer',
                      ),
                    ),
                    InkWell(
                      onTap: (){
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const SalesEnquiry(), 
                          ),
                        );
                      },
                      child: const TabWidget(
                        icon: Icons.content_paste_search,
                        color: Color(0xffDC3C7A),
                        text: 'Sales \nEnquiry',
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Container(
                padding: const EdgeInsets.all(9),
                color: Colors.white,
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  // crossAxisSpacing: 15,
                  mainAxisSpacing: 0,
                  children: const [
                    TabWidget(
                      icon: Icons.wifi_calling_3_sharp,
                      color: Color(0xff5CC8B0),
                      text: 'Call \nReminder',
                    ),
                    TabWidget(
                      assetImage: 'assets/booking.png',
                      icon: Icons.data_exploration_outlined,
                      color: Color(0xff1AA1BE),
                      text: 'Call \nBooking',
                    ),
                    TabWidget(
                      icon: Icons.contact_phone_rounded,
                      color: Color(0xff4E739D),
                      text: 'Service \nBooking',
                    ),
                    TabWidget(
                      icon: Icons.phone,
                      color: Color(0xff08BF43),
                      text: 'Call \nRinging',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'CALLING REPORT',
              ),
              const Divider(),
              Container(
                padding: const EdgeInsets.all(9),
                color: Colors.white,
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  // crossAxisSpacing: 15,
                  mainAxisSpacing: 0,
                  children: const [
                    TabWidget(
                      icon: Icons.description_sharp,
                      color: Color(0xffFF9221),
                      text: 'Summary \nReport',
                    ),
                    TabWidget(
                      icon: Icons.data_exploration_outlined,
                      color: Color(0xffB3181E),
                      text: 'Dissatisfied \nPSF',
                    ),
                    TabWidget(
                      icon: Icons.library_books,
                      color: Color(0xff009BDB),
                      text: 'PSF \nSummary',
                    ),
                    TabWidget(
                      icon: Icons.call,
                      color: Color.fromRGBO(236, 117, 1, 1),
                      text: 'Ringing',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TabWidget extends StatelessWidget {
  final IconData? icon;
  final Color color;
  final String text;
  final String? assetImage;
  final VoidCallback? onTap;

  const TabWidget({
    Key? key,
    this.icon,
    required this.color,
    required this.text,
    this.assetImage,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: assetImage != null
                  ? Image.asset(
                      assetImage!,
                      width: 35,
                      height: 35,
                      fit: BoxFit.cover,
                    )
                  : Icon(
                      icon,
                      size: 35,
                      color: Colors.white,
                    ),
            ),
          ),
          // const SizedBox(height: 5),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11),
          ),
        ],
      ),
    );
  }
}
