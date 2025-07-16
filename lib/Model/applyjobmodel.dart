class ApplyjobData {
  final String jobId;
  final String fullName;
  final String email;
  final String phone;
  final String fatherName;
  final String offerStatus;
  final String dateOfBirth;
  final String gender;
  final String aadharNumber;
  final String highestQualification;
  final String currentLocation;
  final List<String> spokenLanguages;
  final int experienceInYears;
  final int experienceInMonths;
  final List<String> skills;
  final String jobCategory;
  final String shiftTimings;
  final String employmentType;

  ApplyjobData({
    required this.jobId,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.fatherName,
    required this.offerStatus,
    required this.dateOfBirth,
    required this.gender,
    required this.aadharNumber,
    required this.highestQualification,
    required this.currentLocation,
    required this.spokenLanguages,
    required this.experienceInYears,
    required this.experienceInMonths,
    required this.skills,
    required this.jobCategory,
    required this.shiftTimings,
    required this.employmentType,
  });

  factory ApplyjobData.fromJson(Map<String, dynamic> json) {
    return ApplyjobData(
      jobId: json['jobId'],
      fullName: json['fullName'],
      email: json['email'],
      phone: json['phone'],
      fatherName: json['fatherName'],
      offerStatus: json['offerStatus'],
      dateOfBirth: json['dateOfBirth'],
      gender: json['gender'],
      aadharNumber: json['aadharNumber'],
      highestQualification: json['highestQualification'],
      currentLocation: json['currentLocation'],
      spokenLanguages: List<String>.from(json['spokenLanguages']),
      experienceInYears: json['experienceInYears'],
      experienceInMonths: json['experienceInMonths'],
      skills: List<String>.from(json['skills']),
      jobCategory: json['jobCategory'],
      shiftTimings: json['shiftTimings'],
      employmentType: json['employmentType'],
    );
  }
}
