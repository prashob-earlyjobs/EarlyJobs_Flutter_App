// import 'package:earlyjobs/Constants/constants.dart';
// import 'package:earlyjobs/Controller/jobscontroller.dart';
// import 'package:earlyjobs/Model/jobsModel.dart';
// import 'package:earlyjobs/View/Home/homescreen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:go_router/go_router.dart';

// class JobsScreen extends StatelessWidget {
//   JobsScreen({super.key});
//   final searchController = TextEditingController();

//   final getHostListController = Get.put(HostListController());

//   @override
//   Widget build(BuildContext context) {
//     // getHostListController.fetchHostList();

//     final screenWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//         body: SafeArea(
//       child: Padding(
//         padding: EdgeInsets.all(15.0.w),
//         child: ListView(
//           controller: getHostListController.scrollController,
//           children: [
//             Row(
//               children: [
//                 GestureDetector(
//                   onTap: () => Navigator.pop(context),
//                   child: Icon(
//                     Icons.arrow_back,
//                     size: 30.w,
//                     color: kprimarycolor,
//                   ),
//                 ),
//                 width10,
//                 Text(
//                   'Job Openings',
//                   style: boldfont20,
//                 ),
//                 // const Spacer(),
//                 // Icon(
//                 //   Icons.notifications,
//                 //   size: 30.w,
//                 //   color: kprimarycolor,
//                 // )
//               ],
//             ),
//             heigh10,
//             SizedBox(
//                 height: 45.h,
//                 child: Row(children: [
//                   SizedBox(
//                       width: screenWidth - 30.w,
//                       child: TextFormField(
//                           controller: searchController,
//                           keyboardType: TextInputType.name,
//                           decoration: textInputDecoration(
//                               'Search by Jobs, Company, Place, Keywords',
//                               Icons.search),
//                           onChanged: (value) {
//                             // getHostListController.searchKey = value;

//                             getHostListController.changesearchkey(value);
//                           }))
//                 ])),
//             heigh10,
//             GetBuilder<HostListController>(builder: (getData) {
//               if (getData.isLoading) {
//                 return HostShimmerLoading(count: 8);
//               } else {
//                 return Column(
//                   children: [
//                     ListView.separated(
//                         shrinkWrap: true,
//                         physics: const ScrollPhysics(),
//                         itemBuilder: (context, index) {
//                           JobsModel jobslist = JobsModel.fromJson(
//                               getHostListController.allJobsList[index]);
//                           return GestureDetector(
//                             onTap: () => context.push('/individualJobs',
//                                 extra: jobslist),
//                             child: Container(
//                               padding: EdgeInsets.all(10.w),
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10.w),
//                                   color: kwhitecolor),
//                               child: Column(
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Container(
//                                         height: 60.w,
//                                         width: 60.w,
//                                         decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(10.w),
//                                             color: kashcolor,
//                                             image: DecorationImage(
//                                                 image: jobslist
//                                                             .companyLogoUrl ==
//                                                         null
//                                                     ? const AssetImage(
//                                                         'lib/Assets/logoplaceholder.png')
//                                                     : NetworkImage(jobslist
//                                                             .companyLogoUrl!)
//                                                         as ImageProvider)),
//                                       ),
//                                       width10,
//                                       Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           SizedBox(
//                                             width: screenWidth * 0.66,
//                                             child: Text(
//                                               jobslist.title,
//                                               style: boldfont13,
//                                               overflow: TextOverflow.ellipsis,
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             width: screenWidth * 0.66,
//                                             child: Text(
//                                               jobslist.companyName,
//                                               style: normalfont11,
//                                               overflow: TextOverflow.ellipsis,
//                                             ),
//                                           ),
//                                           Row(
//                                             children: [
//                                               Text(
//                                                 '${jobslist.area}, ${jobslist.city}',
//                                                 style: normalfont11,
//                                               ),
//                                               // Spacer(),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                       // Spacer(),
//                                       // Column(
//                                       //   mainAxisAlignment:
//                                       //       MainAxisAlignment.spaceBetween,
//                                       //   crossAxisAlignment: CrossAxisAlignment.end,
//                                       //   children: [
//                                       //     Text(''),

//                                       //   ],
//                                       // )
//                                     ],
//                                   ),
//                                   heigh10,
//                                   Row(
//                                     children: [
//                                       Container(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 5.w, vertical: 2.w),
//                                         decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(5.5),
//                                             color: kashcolor),
//                                         child: Text(
//                                           jobslist.employmentType,
//                                           style: TextStyle(
//                                               fontSize: 12.sp,
//                                               fontWeight: FontWeight.bold,
//                                               color: kprimarycolor),
//                                         ),
//                                       ),
//                                       width10,
//                                       Container(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 5.w, vertical: 2.w),
//                                         decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(5.5),
//                                             color: kashcolor),
//                                         child: Text(
//                                           '${jobslist.minSalary} - ${jobslist.maxSalary} LPA',
//                                           style: TextStyle(
//                                               fontSize: 12.sp,
//                                               fontWeight: FontWeight.bold,
//                                               color: kprimarycolor),
//                                         ),
//                                       ),
//                                       width10,
//                                       Container(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 5.w, vertical: 2.w),
//                                         decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(5.5),
//                                             color: kashcolor),
//                                         child: Text(
//                                           jobslist.category,
//                                           style: TextStyle(
//                                               fontSize: 12.sp,
//                                               fontWeight: FontWeight.bold,
//                                               color: kprimarycolor),
//                                         ),
//                                       ),
//                                       width10,
//                                       Container(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 5.w, vertical: 2.w),
//                                         decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(5.5),
//                                             color: kashcolor),
//                                         child: Text(
//                                           jobslist.workType,
//                                           style: TextStyle(
//                                               fontSize: 12.sp,
//                                               fontWeight: FontWeight.bold,
//                                               color: kprimarycolor),
//                                         ),
//                                       )
//                                     ],
//                                   )
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                         separatorBuilder: (context, index) {
//                           return heigh15;
//                         },
//                         itemCount: getHostListController.allJobsList.length),
//                     heigh10,
//                     getHostListController.isMoreData
//                         ? HostShimmerLoading(count: 1)
//                         : const SizedBox(),
//                   ],
//                 );
//               }
//             }),
//           ],
//         ),
//       ),
//     ));
//   }

//   InputDecoration textInputDecoration(String hinttext, IconData? prefixIcon) {
//     return InputDecoration(
//       filled: true,
//       fillColor: kwhitecolor,
//       // contentPadding:
//       //     EdgeInsets.symmetric(vertical: 13.0.w, horizontal: 10.0.w),
//       suffixIcon: Icon(prefixIcon, color: kblackcolor, size: 27.w),
//       enabledBorder: OutlineInputBorder(
//           borderSide: BorderSide(
//               style: BorderStyle.solid, width: 1.w, color: kwhitecolor),
//           borderRadius: BorderRadius.circular(10.w)),
//       focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(
//               style: BorderStyle.solid, width: 1.w, color: kwhitecolor),
//           borderRadius: BorderRadius.circular(5)),
//       hintText: hinttext,
//       hintStyle: TextStyle(fontSize: 13.sp, color: kgreycolor.withOpacity(0.8)),
//     );
//   }
// }
