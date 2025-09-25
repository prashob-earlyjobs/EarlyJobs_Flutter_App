import 'package:earlyjobs/View/Onboarding/welcomeScreen.dart';
import 'package:earlyjobs/View/Onboarding/widgets/otpPopUp.dart';
import 'package:earlyjobs/routes/routes_constant.dart' show Routes;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:earlyjobs/Model/jobsModel.dart';
import 'package:earlyjobs/View/Home/homescreen.dart';
import 'package:earlyjobs/View/Jobs/individualjob.dart';
import 'package:earlyjobs/View/Jobs/jobs.dart';
import 'package:earlyjobs/View/Jobs/applyjobs_2.dart';
import 'package:earlyjobs/View/splashscreen.dart';

class EarlyJobsAppRoutes {
  static final RouteObserver<ModalRoute> routeObserver =
  RouteObserver<ModalRoute>();

  static final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: Routes.splashScreen.path,
    observers: [routeObserver],

    // Global redirect logic (optional)
    redirect: (BuildContext context, GoRouterState state) {
      // Add any global navigation logic here
      // For example, check authentication status, onboarding completion, etc.
      return null; // Allow navigation to proceed
    },

    errorBuilder: (BuildContext context, GoRouterState state) =>
    const Scaffold(
      body: Center(
        child: Text("Page Not Found"),
      ),
    ),

    routes: [
      // Splash Screen Route
      GoRoute(
        path: Routes.splashScreen.path,
        name: Routes.splashScreen.name,
        builder: (BuildContext context, GoRouterState state) =>
            SplashScreen(),
      ),

      // Home Screen Route
      GoRoute(
        path: Routes.homeScreen.path,
        name: Routes.homeScreen.name,
        builder: (BuildContext context, GoRouterState state) =>
            HomeScreen(),
      ),

      // Jobs Listing Screen Route
      GoRoute(
        path: Routes.jobsScreen.path,
        name: Routes.jobsScreen.name,
        builder: (BuildContext context, GoRouterState state) =>
            JobsScreen(),
      ),

      // Individual Job Details Route
      GoRoute(
        path: Routes.individualJobScreen.path,
        name: Routes.individualJobScreen.name,
        builder: (BuildContext context, GoRouterState state) {
          final JobsModel jobData = state.extra as JobsModel;
          return IndividualJob(jobData: jobData);
        },
      ),

      // Job Application Route with Parameter
      GoRoute(
        path: Routes.jobApplicationScreen.path,
        name: Routes.jobApplicationScreen.name,
        builder: (BuildContext context, GoRouterState state) {
          final JobsModel jobData = state.extra as JobsModel;
          return PersonalInformationForm(passinngJobData: jobData);
        },
      ),
      GoRoute(
        path: Routes.welcomeScreen.path,
        name: Routes.welcomeScreen.name,
        builder: (BuildContext context, GoRouterState state) => WelcomeScreen(),
      ),
    ],
  );
}
