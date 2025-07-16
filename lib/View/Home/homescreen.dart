import 'dart:developer';

import 'package:earlyjobs/Apiserives/jobsapi.dart';
import 'package:earlyjobs/Constants/constants.dart';

import 'package:earlyjobs/Model/jobsModel.dart';
import 'package:earlyjobs/View/Home/carouselwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(15.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.account_box_rounded,
                        size: 30.w,
                        color: kprimarycolor,
                      ),
                      width10,
                      Text(
                        'Hello, User!',
                        style: boldfont20,
                      ),
                      const Spacer(),
                      Icon(
                        Icons.notifications,
                        size: 25.w,
                        color: kprimarycolor,
                      )
                    ],
                  ),
                  // ListView.builder(itemBuilder: itemBuilder),
                  heigh10,
                  GestureDetector(
                    onTap: () {
                      context.push('/jobsScreen');
                    },
                    child: SizedBox(
                        height: 45.h,
                        child: Row(children: [
                          SizedBox(
                              width: screenWidth - 30.w,
                              child: TextFormField(
                                  enabled: false,
                                  controller: searchController,
                                  keyboardType: TextInputType.name,
                                  decoration: textInputDecoration(
                                      'Search by Jobs, Company, Place, Keywords',
                                      Icons.search),
                                  onChanged: (value) {
                                    // searchKey = value;
                                    // context.push('/jobsScreen');
                                  }))
                        ])),
                  ),
                  // heigh10,
                  // Text(
                  //   'Tips for you',
                  //   style: boldfont15,
                  // ),
                ],
              ),
            ),
            // FutureBuilder(
            //   future: stockApi.courosalImages(),
            //   builder: (context, snapshot) {
            //     if (snapshot.hasError || !snapshot.hasData) {
            //       return HomescreenCorouselsliderLoding();
            //     }

            //     List imageList = snapshot.data as List;

            //     if (imageList.isEmpty) {
            //       return HomescreenCorouselsliderLoding();
            //     }

            //     return HomescreenCorouselslider(imageList: imageList);
            //   },
            // ),

            HomescreenCorouselsliderAssets(imageList: [
              'lib/Assets/Courousal_1_2.png'
            ]), //to be uncommented
            Padding(
              padding: EdgeInsets.all(15.0.w),
              child: Column(
                children: [
                  SizedBox(
                    width: screenWidth - 30.w,
                    child: Row(
                      children: [
                        Text(
                          'Job Recomentation',
                          style: boldfont15,
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            context.push('/jobsScreen');
                          },
                          child: Text(
                            'See all',
                            style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                color: kprimarycolor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  heigh15,
                  //
                  FutureBuilder(
                      future: JobsApi.listjobs(1, ''),
                      builder: (context, snapshot) {
                        // print(getHostListController.allJobsList.length);

                        // print(data['jobs'].length);

                        if (snapshot.hasError) {
                          return Center(
                            child: HostShimmerLoading(count: 10),
                          );
                        }
                        if (!snapshot.hasData) {
                          return Center(
                            child: HostShimmerLoading(count: 10),
                          );
                        } // loading indicator while fetching data
                        Map data = snapshot.data as Map;
                        List joblist = [];
                        try {
                          joblist = data['jobs'];
                        } catch (e) {
                          print(e);
                          joblist = [];
                        }

                        return ListView.separated(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemBuilder: (context, index) {
                              // log(getHostListController.allJobsList[0].toString());

                              Map data = snapshot.data as Map;

                              JobsModel jobslist =
                                  JobsModel.fromJson(data['jobs'][index]);
                              // log(data['jobs']);
                              // print(jobslist.companyLogoUrl);
                              return GestureDetector(
                                onTap: () => context.push('/individualJobs',
                                    extra: jobslist),
                                child: Container(
                                  padding: EdgeInsets.all(10.w),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.w),
                                      color: kwhitecolor),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 60.w,
                                            width: 60.w,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.w),
                                                // color: kashcolor,
                                                image: DecorationImage(
                                                    image: jobslist
                                                                .companyLogoUrl ==
                                                            null
                                                        ? AssetImage(
                                                            'lib/Assets/logoplaceholder.png')
                                                        : NetworkImage(jobslist
                                                                .companyLogoUrl!, )
                                                            as ImageProvider)),
                                          ),
                                          width10,
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: screenWidth * 0.66,
                                                child: Text(
                                                  jobslist.title,
                                                  style: boldfont13,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              SizedBox(
                                                width: screenWidth * 0.66,
                                                child: Text(
                                                  jobslist.companyName,
                                                  style: normalfont11,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              SizedBox(
                                                width: screenWidth * 0.66,
                                                child: Text(
                                                  '${jobslist.area}, ${jobslist.city}',
                                                  style: normalfont11,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                      heigh10,
                                      SizedBox(
                                        // alignment: Alignment.center,
                                        height: 25
                                            .w, // Height of the horizontal ListView
                                        child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5.w,
                                                  vertical: 2.w),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.5),
                                                  color: kashcolor),
                                              child: Text(
                                                jobslist.employmentType,
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: kprimarycolor),
                                              ),
                                            ),
                                            width10,
                                            Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5.w,
                                                  vertical: 2.w),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.5),
                                                  color: kashcolor),
                                              child: Text(
                                                '${jobslist.minSalary} - ${jobslist.maxSalary} LPA',
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: kprimarycolor),
                                              ),
                                            ),
                                            width10,
                                            Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5.w,
                                                  vertical: 2.w),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.5),
                                                  color: kashcolor),
                                              child: Text(
                                                jobslist.category,
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: kprimarycolor),
                                              ),
                                            ),
                                            width10,
                                            Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5.w,
                                                  vertical: 2.w),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.5),
                                                  color: kashcolor),
                                              child: Text(
                                                jobslist.workType,
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: kprimarycolor),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return heigh15;
                            },
                            itemCount: joblist.length);
                      })
                  //
                  // FutureBuilder(
                  //     future: null,
                  //     builder: (context, snapshot) {
                  //       return ListView.separated(
                  //           shrinkWrap: true,
                  //           physics: ScrollPhysics(),
                  //           itemBuilder: (context, index) {
                  //             return Container(
                  //               padding: EdgeInsets.all(10.w),
                  //               decoration: BoxDecoration(
                  //                   borderRadius: BorderRadius.circular(10.w),
                  //                   color: kwhitecolor),
                  //               child: Row(
                  //                 children: [
                  //                   Container(
                  //                     height: 60.w,
                  //                     width: 60.w,
                  //                     decoration: BoxDecoration(
                  //                         borderRadius:
                  //                             BorderRadius.circular(10.w),
                  //                         color: kashcolor),
                  //                   ),
                  //                   width10,
                  //                   Column(
                  //                     crossAxisAlignment:
                  //                         CrossAxisAlignment.start,
                  //                     children: [
                  //                       Text(
                  //                         'Social Media Manager',
                  //                         style: boldfont13,
                  //                       ),
                  //                       Text(
                  //                         'Goformeet',
                  //                         style: normalfont11,
                  //                       ),
                  //                       Text(
                  //                         'Banglore, Karnataka',
                  //                         style: normalfont11,
                  //                       )
                  //                     ],
                  //                   ),
                  //                   Spacer(),
                  //                   Column(
                  //                     mainAxisAlignment:
                  //                         MainAxisAlignment.spaceBetween,
                  //                     crossAxisAlignment:
                  //                         CrossAxisAlignment.end,
                  //                     children: [
                  //                       Text(''),
                  //                       Text(
                  //                         '3-5 LPA',
                  //                         style: TextStyle(
                  //                             fontSize: 14.sp,
                  //                             fontWeight: FontWeight.bold,
                  //                             color: kprimarycolor),
                  //                       ),
                  //                     ],
                  //                   )
                  //                 ],
                  //               ),
                  //             );
                  //           },
                  //           separatorBuilder: (context, index) {
                  //             return heigh15;
                  //           },
                  //           itemCount: 5);
                  //     }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  InputDecoration textInputDecoration(String hinttext, IconData? prefixIcon) {
    return InputDecoration(
      filled: true,
      fillColor: kwhitecolor,
      // contentPadding:
      //     EdgeInsets.symmetric(vertical: 13.0.w, horizontal: 10.0.w),
      suffixIcon: Icon(prefixIcon, color: kblackcolor, size: 27.w),
      disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              style: BorderStyle.solid, width: 1.w, color: kwhitecolor),
          borderRadius: BorderRadius.circular(10.w)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              style: BorderStyle.solid, width: 1.w, color: kwhitecolor),
          borderRadius: BorderRadius.circular(10.w)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              style: BorderStyle.solid, width: 1.w, color: kwhitecolor),
          borderRadius: BorderRadius.circular(5)),
      hintText: hinttext,
      hintStyle: TextStyle(fontSize: 13.sp, color: kgreycolor.withOpacity(0.8)),
    );
  }
}

class HostShimmerLoading extends StatelessWidget {
  int count;
  HostShimmerLoading({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            // padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.w), color: kwhitecolor),
            height: 110.w,
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              enabled: true,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.w), color: kashcolor),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => heigh15,
        itemCount: count);
  }
}


// class HostShimmerLoading extends StatelessWidget {
//   int count;
//   HostShimmerLoading({super.key, required this.count});

//   @override
//   Widget build(BuildContext context) {
//     return GridView.count(
//       padding: EdgeInsets.symmetric(horizontal: 0.w),
//       physics: const ScrollPhysics(),
//       shrinkWrap: true,
//       childAspectRatio: 0.75.w,
//       crossAxisSpacing: 15.w,
//       mainAxisSpacing: 15.w,
//       crossAxisCount: 2,
//       children: List.generate(
//         count,
//         (index) {
//           // final hostData = HostDataModel.fromJson(snapshot.data!.docs[index].data());

//           return Shimmer.fromColors(
//             baseColor: Colors.grey.shade300,
//             highlightColor: Colors.grey.shade100,
//             enabled: true,
//             child: Container(
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(5.w), color: kashcolor),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }