import 'package:earlyjobs/routes/router.config.dart' show EarlyJobsAppRoutes;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Constants/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(384.7, 816.0),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Earlyjobs',
          theme: ThemeData(
            scaffoldBackgroundColor: kashcolor,
            fontFamily: GoogleFonts.poppins().fontFamily,
            useMaterial3: true,
          ),
          routerConfig: EarlyJobsAppRoutes.router,
        );
      },
    );
  }
}
