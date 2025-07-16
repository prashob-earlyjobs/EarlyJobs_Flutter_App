class JobsModel {
  final String id;
  final String companyName;

  final String? companyLogoUrl;

  final String title;
  final String category;
  final String description;
  final String location;
  final int minSalary;
  final int maxSalary;
  final String skills;
  final String employmentType;
  final String workType;
  // final int commissionFee;
  // final String commissionType;
  final int noOfOpenings;
  final String status;
  final String hiringNeed;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String postedBy;
  final String? assignedTo;
  final String shiftTimings;
  final String language;
  var minExperience;
  final int minAge;
  var qualification;
  final int maxExperience;
  final int maxAge;
  final String locationLink;
  final int tenureInDays;
  final String street;
  final String area;
  final String city;
  final String pincode;
  final String keywords;
  final String companyId;
  final String? salary_mode;

  JobsModel(
      {required this.id,
      this.companyLogoUrl,
      required this.companyName,
      required this.title,
      required this.category,
      required this.description,
      required this.location,
      required this.minSalary,
      required this.maxSalary,
      required this.skills,
      required this.employmentType,
      required this.workType,
      // required this.commissionFee,
      // required this.commissionType,
      required this.noOfOpenings,
      required this.status,
      required this.hiringNeed,
      required this.createdAt,
      required this.updatedAt,
      required this.postedBy,
      this.assignedTo,
      required this.shiftTimings,
      required this.language,
      required this.minExperience,
      required this.minAge,
      required this.qualification,
      required this.maxExperience,
      required this.maxAge,
      required this.locationLink,
      required this.tenureInDays,
      required this.street,
      required this.area,
      required this.city,
      required this.pincode,
      required this.keywords,
      required this.companyId,
      required this.salary_mode});

  factory JobsModel.fromJson(Map<String, dynamic> json) {
    return JobsModel(
        id: json['id'],
        companyName: json['company_name'],
        companyLogoUrl: json['company_logo_url'],
        title: json['title'],
        category: json['category'],
        description: json['description'],
        location: json['location'],
        minSalary: json['min_salary'],
        maxSalary: json['max_salary'],
        skills: json['skills'],
        employmentType: json['employment_type'],
        workType: json['work_type'],
        // commissionFee: json['commission_fee'],
        // commissionType: json['commission_type'],
        noOfOpenings: json['no_of_openings'],
        status: json['status'],
        hiringNeed: json['hiring_need'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
        postedBy: json['posted_by'],
        assignedTo: json['assigned_to'],
        shiftTimings: json['shift_timings'],
        language: json['language'],
        minExperience: json['min_experience'],
        minAge: json['min_age'],
        qualification: json['qualification'],
        maxExperience: json['max_experience'],
        maxAge: json['max_age'],
        locationLink: json['location_link'],
        tenureInDays: json['tenure_in_days'],
        street: json['street'],
        area: json['area'],
        city: json['city'],
        pincode: json['pincode'],
        keywords: json['keywords'],
        companyId: json['company_id'],
        salary_mode: json['salary_mode'] ?? "");
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company_name': companyName,
      'title': title,
      'category': category,
      'description': description,
      'location': location,
      'min_salary': minSalary,
      'max_salary': maxSalary,
      'skills': skills,
      'employment_type': employmentType,
      'work_type': workType,
      // 'commission_fee': commissionFee,
      // 'commission_type': commissionType,
      'no_of_openings': noOfOpenings,
      'status': status,
      'hiring_need': hiringNeed,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'posted_by': postedBy,
      'assigned_to': assignedTo,
      'shift_timings': shiftTimings,
      'language': language,
      'min_experience': minExperience,
      'min_age': minAge,
      'qualification': qualification,
      'max_experience': maxExperience,
      'max_age': maxAge,
      'location_link': locationLink,
      'tenure_in_days': tenureInDays,
      'street': street,
      'area': area,
      'city': city,
      'pincode': pincode,
      'keywords': keywords,
      'company_id': companyId,
    };
  }
}
