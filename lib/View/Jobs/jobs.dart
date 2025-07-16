import 'package:earlyjobs/Apiserives/apiservices.dart';
import 'package:earlyjobs/Constants/constants.dart';
import 'package:earlyjobs/Controller/datacontroller.dart';
import 'package:earlyjobs/Model/jobsModel.dart';
import 'package:earlyjobs/View/Home/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class JobsScreen extends StatelessWidget {
  final DataController dataController = Get.put(DataController(ApiService()));

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.0.w),
          child: ListView(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      dataController.searchQuery.value = '';
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: 30.w,
                      color: kprimarycolor,
                    ),
                  ),
                  width10,
                  Text(
                    'Job Openings',
                    style: boldfont20,
                  ),
                  // const Spacer(),
                  // Icon(
                  //   Icons.notifications,
                  //   size: 30.w,
                  //   color: kprimarycolor,
                  // )
                ],
              ),
              heigh10,
              SizedBox(
                  height: 45.h,
                  child: Row(children: [
                    SizedBox(
                        width: screenWidth - 30.w,
                        child: TextField(
                            keyboardType: TextInputType.name,
                            decoration: textInputDecoration(
                                'Search by Jobs, Company, Place, Keywords',
                                Icons.search),
                            onChanged: (value) {
                              dataController.search(value);
                            }))
                  ])),
              heigh10,
              Obx(() {
                if (dataController.isLoading.value &&
                    dataController.dataList.isEmpty) {
                  return Center(child: HostShimmerLoading(count: 8));
                }

                // print(dataController.dataList.length);

                return NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                      dataController.loadMore();
                    }
                    return true;
                  },
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: dataController.dataList.length +
                        (dataController.isLoading.value ? 1 : 0),
                    itemBuilder: (context, index) {
                      JobsModel jobslist =
                          JobsModel.fromJson(dataController.dataList[index]);
                      if (index == dataController.dataList.length) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      return GestureDetector(
                        onTap: () =>
                            context.push('/individualJobs', extra: jobslist),
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
                                            image: jobslist.companyLogoUrl ==
                                                    null
                                                ? const AssetImage(
                                                    'lib/Assets/logoplaceholder.png')
                                                : NetworkImage(jobslist
                                                        .companyLogoUrl!)
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
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(
                                        width: screenWidth * 0.66,
                                        child: Text(
                                          jobslist.companyName,
                                          style: normalfont11,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(
                                        width: screenWidth * 0.66,
                                        child: Text(
                                          '${jobslist.area}, ${jobslist.city}',
                                          style: normalfont11,
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
                              heigh10,
                              SizedBox(
                                // alignment: Alignment.center,
                                height:
                                    25.w, // Height of the horizontal ListView
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5.w, vertical: 2.w),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.5),
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
                                          horizontal: 5.w, vertical: 2.w),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.5),
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
                                          horizontal: 5.w, vertical: 2.w),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.5),
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
                                          horizontal: 5.w, vertical: 2.w),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.5),
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
                  ),
                );
              }),
            ],
          ),
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
