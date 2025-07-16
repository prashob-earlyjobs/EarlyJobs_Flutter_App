import 'package:earlyjobs/Apiserives/jobsapi.dart';
import 'package:earlyjobs/Constants/constants.dart';
import 'package:earlyjobs/Model/applyjobmodel.dart';
import 'package:earlyjobs/Model/jobsModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class PersonalInformationForm extends StatefulWidget {
  JobsModel passinngJobData;

  PersonalInformationForm({super.key, required this.passinngJobData});
  @override
  _PersonalInformationFormState createState() =>
      _PersonalInformationFormState();
}

class _PersonalInformationFormState extends State<PersonalInformationForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _dobController = TextEditingController();

  String? _gender;
  List<String> _genders = ['Male', 'Female', 'Other'];

  String? _qualification;

  List<String> _qualifications = [
    '10th',
    '12th',
    'ITI',
    'Diploma',
    'Graduation (10 + 2 + 3)',
    'Graduation (10 + 2 + 4)',
    'Post Graduation',
    'PHD'
  ];

  List<String> _selectedSkills = [];
  List<String> _selectedLanguages = [];

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _aadharController = TextEditingController();
  // final TextEditingController _qualificationController =
  //     TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();

  final List<String> _languages = [
    'English',
    'Hindi',
    'Tamil',
    'Kannada',
    'Malayalam',
    'Telugu',
    'Marathi',
    'Gujarati',
    'Bengali',
    'Punjabi',
    'Odia',
  ];

  final List<String> _skills = [
    'Basic Computer Knowledge',
    'MS Office',
    'Tally',
    'Accounting',
    'Customer Support',
    'Sales',
    'Marketing',
    'Digital Marketing',
    'Social Media Marketing',
    'Content Writing',
    'SEO',
    'Graphic Designing',
    'Communication',
  ];

  void _onSkillSelected(String skill) {
    setState(() {
      if (_selectedSkills.contains(skill)) {
        _selectedSkills.remove(skill);
      } else {
        _selectedSkills.add(skill);
      }
    });
  }

  void _onLanguageSelected(String language) {
    setState(() {
      if (_selectedLanguages.contains(language)) {
        _selectedLanguages.remove(language);
      } else {
        _selectedLanguages.add(language);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.arrow_back,
                          size: 30.w,
                          color: kprimarycolor,
                        ),
                      ),
                      width10,
                      Text(
                        'Apply for job',
                        style: boldfont20,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTextFormField(
                            'Full Name *',
                            'Please enter your full name',
                            Icons.person,
                            TextInputType.name,
                            _fullNameController),
                        SizedBox(height: 13.w),
                        _buildTextFormField(
                            'Father Name *',
                            'Please enter your father\'s name',
                            Icons.person_outline,
                            TextInputType.name,
                            _fatherNameController),
                        SizedBox(height: 13.w),
                        _buildTextFormField(
                            'Email ID *',
                            'Please enter your email ID',
                            Icons.email,
                            TextInputType.emailAddress,
                            _emailController),
                        SizedBox(height: 13.w),
                        _buildTextFormField(
                            'Phone Number *',
                            'Please enter your phone number',
                            Icons.phone,
                            TextInputType.phone,
                            _phoneController),
                        SizedBox(height: 13.w),
                        SizedBox(
                          height: 55.w,
                          child: TextFormField(
                            controller: _dobController,
                            decoration: InputDecoration(
                              hintText: 'Date of Birth *',
                              prefixIcon: const Icon(
                                Icons.calendar_today,
                                color: kprimarycolor,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              filled: true,
                              errorStyle: const TextStyle(height: 0),
                              fillColor: kwhitecolor,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      style: BorderStyle.solid,
                                      width: 1.w,
                                      color: kashcolor),
                                  borderRadius: BorderRadius.circular(10.w)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      style: BorderStyle.solid,
                                      width: 1.w,
                                      color: kgreycolor),
                                  borderRadius: BorderRadius.circular(5)),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      style: BorderStyle.solid,
                                      width: 2.w,
                                      color: kredcolor),
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            readOnly: true,
                            onTap: () async {
                              var pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2101),
                              );
                              if (pickedDate != null) {
                                setState(() {
                                  _dobController.text =
                                      pickedDate.toString().split(' ')[0];
                                });
                              }
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return '';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 13.w),
                        SizedBox(
                          height: 55.w,
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  left: 10.0.w, bottom: 10.0.w, top: 10.0.w),
                              hintText: 'Gender',
                              // prefixIcon: Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),

                              filled: true,
                              fillColor: kwhitecolor,

                              prefixIcon: const Icon(
                                Icons.person,
                                color: kprimarycolor,
                              ),
                              errorStyle: const TextStyle(height: 0),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      style: BorderStyle.solid,
                                      width: 1.w,
                                      color: kashcolor),
                                  borderRadius: BorderRadius.circular(10.w)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      style: BorderStyle.solid,
                                      width: 1.w,
                                      color: kgreycolor),
                                  borderRadius: BorderRadius.circular(5)),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      style: BorderStyle.solid,
                                      width: 2.w,
                                      color: kredcolor),
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            value: _gender,
                            items: _genders.map((String gender) {
                              return DropdownMenuItem(
                                value: gender,
                                child: Text(gender),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                _gender = newValue;
                              });
                            },
                            validator: (value) {
                              if (value == null) {
                                return '';
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 13.w),
                        _buildTextFormField(
                            'Aadhar Number',
                            'Please enter your Aadhar number',
                            Icons.credit_card,
                            TextInputType.number,
                            _aadharController),
                        SizedBox(height: 13.w),
                        // _buildTextFormField(
                        //     'Highest Qualification *',
                        //     'Please enter your highest qualification',
                        //     Icons.school,
                        //     TextInputType.name),
                        // SizedBox(height: 13.w),
                        _buildTextFormField(
                            'Current Location *',
                            'Please enter your current location',
                            Icons.location_on,
                            TextInputType.name,
                            _locationController),
                        SizedBox(height: 13.w),
                        //

                        SizedBox(
                          height: 55.w,
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  left: 10.0.w, bottom: 10.0.w, top: 10.0.w),
                              hintText: 'Qualification',
                              // prefixIcon: Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),

                              filled: true,
                              fillColor: kwhitecolor,

                              prefixIcon: const Icon(
                                Icons.person,
                                color: kprimarycolor,
                              ),
                              errorStyle: const TextStyle(height: 0),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      style: BorderStyle.solid,
                                      width: 1.w,
                                      color: kashcolor),
                                  borderRadius: BorderRadius.circular(10.w)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      style: BorderStyle.solid,
                                      width: 1.w,
                                      color: kgreycolor),
                                  borderRadius: BorderRadius.circular(5)),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      style: BorderStyle.solid,
                                      width: 2.w,
                                      color: kredcolor),
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            value: _qualification,
                            items: _qualifications.map((String qualification) {
                              return DropdownMenuItem(
                                value: qualification,
                                child: Text(qualification),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                _qualification = newValue;
                              });
                            },
                            validator: (value) {
                              if (value == null) {
                                return '';
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 13.w),

                        //
                        _buildTextFormField(
                            'Experience In Years*',
                            'Please enter your experience',
                            Icons.work,
                            TextInputType.number,
                            _experienceController),
                        SizedBox(height: 13.w),
                        // _buildTextFormField('Skills *',
                        //     'Please enter your skills', Icons.build),
                        // SizedBox(height: 13.w),

                        _buildDropdownFormField(
                          'Skills *',
                          'Please select your skills',
                          Icons.build,
                          _selectedSkills,
                          _skills,
                          _onSkillSelected,
                        ),

                        _buildChipsDisplay('Selected Skills:', _selectedSkills,
                            _onSkillSelected),

                        //
                        SizedBox(height: 13.h),
                        SizedBox(
                          // height: 55.w,

                          child: _buildDropdownFormField(
                            'Spoken Languages *',
                            'Please select the languages you speak',
                            Icons.language,
                            _selectedLanguages,
                            _languages,
                            _onLanguageSelected,
                          ),
                        ),
                        // SizedBox(height: 13.h),
                        _buildChipsDisplay('Selected Languages:',
                            _selectedLanguages, _onLanguageSelected),
                        SizedBox(height: 13.h),
                        SizedBox(
                          width: screenWidth - 30.w,
                          height: 45.w,
                          child: ElevatedButton(
                            style: elevatebuttonstyleprimary,
                            onPressed: () {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //   builder: (context) => PersonalInformationForm(),
                              // ));

                              if (_formKey.currentState!.validate()) {
                                logoutcofirmationPopup(context);
                              }
                            },
                            child: Text(
                              'Submit',
                              style: normalfont14,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(
      String labelText,
      String validatorText,
      IconData icon,
      TextInputType keyboardType,
      TextEditingController controller) {
    return SizedBox(
      height: 55.w,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          filled: true,
          fillColor: kwhitecolor,
          // labelText: labelText,
          hintText: labelText,
          prefixIcon: Icon(
            icon,
            color: kprimarycolor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
          errorStyle: const TextStyle(height: 0),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  style: BorderStyle.solid, width: 1.w, color: kashcolor),
              borderRadius: BorderRadius.circular(10.w)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  style: BorderStyle.solid, width: 1.w, color: kgreycolor),
              borderRadius: BorderRadius.circular(5)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  style: BorderStyle.solid, width: 2.w, color: kredcolor),
              borderRadius: BorderRadius.circular(5)),
        ),
        validator: (value) {
          Pattern pattern = r'(^[0-9]{10}$)';
          RegExp regex = RegExp(pattern.toString());

          Pattern emailpattern =
              r'^[a-zA-Z0-9]+([._%+-]?[a-zA-Z0-9]+)*@[a-zA-Z0-9]+([.-]?[a-zA-Z0-9]+)*(\.[a-zA-Z]{2,4})+$';
          RegExp emailregex = RegExp(emailpattern.toString());

          if (value!.isEmpty) {
            return '';
          }
          if (labelText == 'Phone Number *') {
            if (!regex.hasMatch(value)) {
              Fluttertoast.showToast(msg: 'Enter a valid phone number');
              return '';
            }
          }
          if (labelText == 'Email ID *') {
            if (!emailregex.hasMatch(value)) {
              Fluttertoast.showToast(msg: 'Enter a valid email adress');
              return '';
            }
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDropdownFormField(
    String labelText,
    String validatorText,
    IconData icon,
    List<String> selectedList,
    List<String> itemList,
    Function(String) onItemSelected,
  ) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 55,
            child: DropdownButtonFormField(
              padding: const EdgeInsets.all(0),
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.only(left: 10.0.w, bottom: 10.0.w, top: 10.0.w),
                hintText: labelText,
                filled: true,
                fillColor: Colors.white, // Change this to your desired color
                prefixIcon: Icon(
                  icon,
                  color: kprimarycolor, // Change this to your desired color
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                errorStyle: const TextStyle(height: 0),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        style: BorderStyle.solid, width: 1.w, color: kashcolor),
                    borderRadius: BorderRadius.circular(10.w)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        style: BorderStyle.solid,
                        width: 1.w,
                        color: kgreycolor),
                    borderRadius: BorderRadius.circular(5)),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        style: BorderStyle.solid, width: 2.w, color: kredcolor),
                    borderRadius: BorderRadius.circular(5)),
              ),
              value: selectedList.isEmpty ? null : selectedList.first,
              items: itemList.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (newValue) => onItemSelected(newValue as String),
              validator: (value) {
                if (value == null) {
                  return '';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChipsDisplay(
    String label,
    List<String> selectedList,
    Function(String) onChipDeleted,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.h),
        Wrap(
          spacing: 8.w,
          children: selectedList.map((item) {
            return Chip(
              label: Text(
                item,
                style: normalfont12,
              ),
              onDeleted: () => onChipDeleted(item),
            );
          }).toList(),
        ),
      ],
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String fullName = _fullNameController.text;
      String fatherName = _fatherNameController.text;
      String email = _emailController.text;
      String phone = _phoneController.text;
      String dob = _dobController.text;
      String gender = _gender ?? '';
      String aadharNumber = _aadharController.text;
      String qualification = _qualification ?? '';
      String location = _locationController.text;
      String experience = (_experienceController.text);
      List<String> skills = _selectedSkills;
      List languages = _selectedLanguages;
      // Form is valid, proceed with submission
      // Example: Submit _selectedSkills and other form data
      // print('Selected Skills: $_selectedSkills');
      // Further logic here for submitting data

      // print(
      //     '$fullName $fatherName $email  $phone $dob $gender $aadharNumber $qualification $qualification $location $experience $skills $languages');
      ApplyjobData jobData = ApplyjobData(
          jobId: widget.passinngJobData.id,
          fullName: fullName,
          email: email,
          phone: phone,
          fatherName: fatherName,
          offerStatus: 'Ongoing',
          dateOfBirth: dob,
          gender: gender,
          aadharNumber: aadharNumber,
          highestQualification: qualification,
          currentLocation: location,
          spokenLanguages: _selectedLanguages,
          experienceInYears: 0,
          experienceInMonths: 0,
          skills: skills,
          jobCategory: widget.passinngJobData.category,
          shiftTimings: widget.passinngJobData.shiftTimings,
          employmentType: widget.passinngJobData.employmentType);

      JobsApi.postJob(jobData);
      context.go('/homeScreen');
    } else {
      // Fluttertoast.showToast(msg: 'Please fill all fields');
    }
  }

  //

  Future<void> logoutcofirmationPopup(
    BuildContext context,
  ) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: EdgeInsets.all(0.w),
          title: SizedBox(
            height: 114.w,
            width: 282.w,
            child: Column(
              children: [
                Container(
                    alignment: Alignment.center,
                    height: 84.w,
                    child: Text(
                      'You want to Submit?',
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: kblackcolor,
                          fontWeight: FontWeight.bold),
                    )),
                const Spacer(),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        // Navigator.pop(context);
                        // context.go('/countrySelectionScreen');

                        // var sharedPref = await SharedPreferences.getInstance();

                        // sharedPref.setBool(SplashScreenState.KEYLOGIN, false);

                        // if (_formKey.currentState!.validate()) {
                        _submitForm();
                        // }
                      },
                      child: Container(
                        height: 30.w,
                        width: 141.w,
                        decoration: const BoxDecoration(color: kprimarycolor),
                        child: Center(
                            child: Text(
                          'Yes',
                          style: TextStyle(fontSize: 14.sp, color: kwhitecolor),
                        )),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: 30.w,
                        width: 141.w,
                        decoration: BoxDecoration(
                            color: kwhitecolor,
                            border: Border.all(color: kprimarycolor)),
                        child: Center(
                            child: Text(
                          'Cancel',
                          style:
                              TextStyle(fontSize: 14.sp, color: kprimarycolor),
                        )),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
