import 'package:earlyjobs/Model/jobsModel.dart';
import 'package:earlyjobs/View/Home/homescreen.dart';
import 'package:earlyjobs/View/Jobs/individualjob.dart';
import 'package:earlyjobs/View/Jobs/jobs.dart';
import 'package:earlyjobs/View/Jobs/jobsscreen.dart';
import 'package:earlyjobs/View/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Constants/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
          routerConfig: _router,
        );
      },
    );
  }
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return SplashScreen();
      },
    ),
    GoRoute(
      path: '/homeScreen',
      builder: (BuildContext context, GoRouterState state) {
        return HomeScreen();
      },
    ),
    GoRoute(
      path: '/jobsScreen',
      builder: (BuildContext context, GoRouterState state) {
        return JobsScreen();
      },
    ),
    GoRoute(
      path: '/individualJobs',
      builder: (BuildContext context, GoRouterState state) {
        JobsModel jobData = state.extra as JobsModel;
        return IndividualJob(
          jobData: jobData,
        );
      },
    ),
  ],
  // errorPageBuilder: (context, state) {
  //   return const MaterialPage(child: ErrorPage());
  // },
);
