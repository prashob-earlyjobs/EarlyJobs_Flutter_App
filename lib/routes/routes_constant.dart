class RouteName {
  const RouteName({required this.name, required this.path});

  final String name;
  final String path;
}

class Routes {
  // Main App Routes
  static const RouteName splashScreen =
  RouteName(name: "splash_screen", path: "/");

  static const RouteName homeScreen =
  RouteName(name: "home_screen", path: "/homeScreen");

  static const RouteName jobsScreen =
  RouteName(name: "jobs_screen", path: "/jobsScreen");

  static const RouteName individualJobScreen = RouteName(
      name: "individual_job_screen",
      path: "/individualJobs"
  );

  // Job Application Routes
  static const RouteName jobApplicationScreen = RouteName(
      name: "job_application_screen",
      path: "/jobApplication/:jobId"
  );
}