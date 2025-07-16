// import 'package:connection_guest_app/Controller/locationcontroller.dart';
// import 'package:connection_guest_app/Model/deviceDetails.dart';
// import 'package:connection_guest_app/Model/logindetails.dart';
// import 'package:connection_guest_app/Model/wifiDetails.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
// import 'package:network_info_plus/network_info_plus.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/constants.dart';
// import 'package:http/http.dart' as http;

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();

  List DeviceInterfaceList = [];
}

class SplashScreenState extends State<SplashScreen> {
  static const String KEYLOGIN = 'login';
  static const String KEYCRED = 'cred';
  static const String KEYUSER = 'user';
  static const String KEYJWT = 'jwt';
  // static const String KEYUSERNAME = 'username';

  @override
  void initState() {
    checkInternet(); // checking internet is on or not

    super.initState();
  }

  checkInternet() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 5),
        content: Text("Check Internet Connection"),
      ));
    } else {
      gotoLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhitecolor,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            const Spacer(),
            Center(
              child: SizedBox(
                height: 250.w,
                child: const Image(
                    image: AssetImage('lib/Assets/2024-02-09 (2).png')),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 15.w,
                  child: const Image(
                      image: AssetImage('lib/Assets/india_flag.png')),
                ),
                width5,
                Text(
                  'Made In Bharath',
                  style: normalfont13,
                ),
              ],
            ),
            SizedBox(
              height: 10.w,
            )
          ],
        ),
      ),
    );
  }

  Future<void> gotoLogin() async {
    // print('objectlogin');
   await Future.delayed(const Duration(seconds: 2));
    context.go('/homeScreen');
  }
}
