import 'package:earlyjobs/Constants/constants.dart';
import 'package:earlyjobs/Model/jobsModel.dart';
import 'package:earlyjobs/View/Jobs/applyjobs_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_html/flutter_html.dart';

class IndividualJob extends StatelessWidget {
  JobsModel jobData;
  IndividualJob({super.key, required this.jobData});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
          child: ListView(
        padding: EdgeInsets.all(15.w),
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
                'Job Details',
                style: boldfont20,
              ),
            ],
          ),
          heigh15,
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.w), color: kwhitecolor),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 60.w,
                      width: 60.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.w),
                          // color: kashcolor,
                          image: DecorationImage(
                              image: jobData.companyLogoUrl == null
                                  ? const AssetImage(
                                      'lib/Assets/logoplaceholder.png')
                                  : NetworkImage(jobData.companyLogoUrl!)
                                      as ImageProvider)),
                    ),
                    width10,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: screenWidth * 0.66,
                          child: Text(
                            jobData.title,
                            style: boldfont15,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.66,
                          child: Text(
                            jobData.companyName,
                            style: normalfont13,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    // Spacer(),
                    // Column(
                    //   mainAxisAlignment:
                    //       MainAxisAlignment.spaceBetween,
                    //   crossAxisAlignment: CrossAxisAlignment.end,
                    //   children: [
                    //     Text(''),

                    //   ],
                    // )
                  ],
                ),
              ],
            ),
          ),
          heigh15,

          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.w), color: kwhitecolor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Status',
                          style: boldfont15,
                        ),
                        const Spacer(),
                        Text(
                          jobData.status,
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: kprimarycolor),
                        )
                      ],
                    ),
                    heigh15,
                    Row(
                      children: [
                        Text(
                          'Salary',
                          style: boldfont15,
                        ),
                        const Spacer(),
                        Text(
                          '${jobData.minSalary} - ${jobData.maxSalary} ${jobData.salary_mode}',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: kprimarycolor),
                        )
                      ],
                    ),
                    heigh15,
                    // Row(
                    //   children: [
                    //     Text(
                    //       'Notice Period',
                    //       style: boldfont15,
                    //     ),
                    //     const Spacer(),
                    //     Text(
                    //       jobData.,
                    //       style: TextStyle(
                    //           fontSize: 15.sp,
                    //           fontWeight: FontWeight.bold,
                    //           color: kprimarycolor),
                    //     )
                    //   ],
                    // ),
                    // heigh15,
                    Row(
                      children: [
                        Text(
                          'Shift Timings',
                          style: boldfont15,
                        ),
                        const Spacer(),
                        Text(
                          jobData.shiftTimings,
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: kprimarycolor),
                        )
                      ],
                    ),
                    heigh15,
                    Row(
                      children: [
                        Text(
                          'No of Openings',
                          style: boldfont15,
                        ),
                        const Spacer(),
                        Text(
                          jobData.noOfOpenings.toString(),
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: kprimarycolor),
                        )
                      ],
                    ),
                    heigh15,
                    Row(
                      children: [
                        Text(
                          'Experience',
                          style: boldfont15,
                        ),
                        const Spacer(),
                        Text(
                          '${jobData.minExperience} - ${jobData.maxExperience} Yrs',
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: kprimarycolor),
                        )
                      ],
                    ),
                    heigh15,
                    Row(
                      children: [
                        Text(
                          'Qualification',
                          style: boldfont15,
                        ),
                        const Spacer(),
                        Text(
                          jobData.qualification,
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: kprimarycolor),
                        )
                      ],
                    ),
                    heigh15,
                    Row(
                      children: [
                        Text(
                          'Type',
                          style: boldfont15,
                        ),
                        const Spacer(),
                        Text(
                          '${jobData.employmentType}',
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: kprimarycolor),
                        )
                      ],
                    ),
                    heigh15,
                    Row(
                      children: [
                        Text(
                          'Location',
                          style: boldfont15,
                        ),
                        const Spacer(),
                        SizedBox(
                          width: screenWidth * 0.6,
                          child: Text(
                            '${jobData.area}, ${jobData.city}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: kprimarycolor),
                          ),
                        )
                      ],
                    ),
                    heigh15,
                    Row(
                      children: [
                        Text(
                          'Work Mode',
                          style: boldfont15,
                        ),
                        const Spacer(),
                        Text(
                          jobData.workType,
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: kprimarycolor),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          heigh15,

          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.w), color: kwhitecolor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10.0.w),
                  child: Text(
                    'Job Description',
                    style: boldfont15,
                  ),
                ),
                Html(
                  data: jobData.description,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 60.w,
          )

          // Text(jobData.description),
        ],
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: screenWidth - 30.w,
        height: 45.w,
        child: ElevatedButton(
          style: elevatebuttonstyleprimary,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  PersonalInformationForm(passinngJobData: jobData),
            ));
          },
          child: Text(
            'Apply Now',
            style: normalfont14,
          ),
        ),
      ),
    );
  }
}
