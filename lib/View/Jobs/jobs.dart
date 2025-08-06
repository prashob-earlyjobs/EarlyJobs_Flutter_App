import 'package:earlyjobs/Apiserives/apiservices.dart';
import 'package:earlyjobs/Constants/constants.dart';
import 'package:earlyjobs/Controller/datacontroller.dart';
import 'package:earlyjobs/Model/jobsModel.dart';
import 'package:earlyjobs/View/Home/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'dart:developer' as dev;

class JobsScreen extends StatefulWidget {
  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  final DataController dataController = Get.put(DataController(ApiService()));
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.hasClients) {
      final currentScroll = _scrollController.offset;
      final maxScroll = _scrollController.position.maxScrollExtent;
      final scrollPercentage = (currentScroll / maxScroll * 100).round();

      dev.log('📱 Scroll: $scrollPercentage% | Current: ${currentScroll.round()}px / Max: ${maxScroll.round()}px',
          name: 'ScrollDetector');

      // Trigger loadMore when 90% scrolled
      if (currentScroll >= (maxScroll * 0.9)) {
        if (!dataController.hasReachedMax.value &&
            !dataController.isLoadingMore.value) {
          dev.log('🔄 Triggering loadMore() - reached 90% scroll', name: 'ScrollDetector');
          dataController.loadMore();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.0.w),
          child: Column(
            children: [
              // Header with back button and title
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
                ],
              ),
              heigh10,

              // Search field
              SizedBox(
                height: 45.h,
                child: Row(
                  children: [
                    SizedBox(
                      width: screenWidth - 30.w,
                      child: TextField(
                        keyboardType: TextInputType.name,
                        decoration: textInputDecoration(
                            'Search by Jobs, Company, Place, Keywords',
                            Icons.search),
                        onChanged: (value) {
                          dataController.search(value);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              heigh10,

              // Pagination status display
              Obx(() => dataController.dataList.isNotEmpty
                  ? Padding(
                padding: EdgeInsets.symmetric(vertical: 5.h),
                child: Text(
                  dataController.paginationStatus,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: kgreycolor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
                  : SizedBox.shrink()),

              // Main content area
              Expanded(
                child: Obx(() {
                  // Show loading shimmer for initial load
                  if (dataController.isLoading.value &&
                      dataController.dataList.isEmpty) {
                    return Center(child: HostShimmerLoading(count: 8));
                  }

                  // Show empty state
                  if (!dataController.isLoading.value &&
                      dataController.dataList.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off, size: 60.w, color: kgreycolor),
                          SizedBox(height: 16.h),
                          Text(
                            'No jobs found',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: kgreycolor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          if (dataController.searchQuery.value.isNotEmpty)
                            Text(
                              'Try different keywords',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: kgreycolor,
                              ),
                            ),
                        ],
                      ),
                    );
                  }

                  // Main job list with pagination
                  return ListView.separated(
                    controller: _scrollController,
                    itemCount: dataController.dataList.length +
                        (dataController.hasReachedMax.value ? 0 : 1),
                    itemBuilder: (context, index) {
                      // Show loading indicator at bottom
                      if (index >= dataController.dataList.length) {
                        return Container(
                          padding: EdgeInsets.all(20.w),
                          child: Column(
                            children: [
                              if (dataController.isLoadingMore.value) ...[
                                CircularProgressIndicator(color: kprimarycolor),
                                SizedBox(height: 10.h),
                                Text(
                                  'Loading more jobs...',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: kgreycolor,
                                  ),
                                ),
                              ] else if (!dataController.hasReachedMax.value) ...[
                                Text(
                                  'Scroll down for more jobs',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: kgreycolor,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        );
                      }

                      // Job item
                      final jobData = dataController.dataList[index].data;
                      final JobsModel jobslist = JobsModel.fromJson(jobData);

                      return GestureDetector(
                        onTap: () =>
                            context.push('/individualJobs', extra: jobslist),
                        child: Container(
                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.w),
                            color: kwhitecolor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 60.w,
                                    width: 60.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.w),
                                      image: DecorationImage(
                                        image: jobslist.companyLogoUrl == null
                                            ? const AssetImage('lib/Assets/logoplaceholder.png')
                                            : NetworkImage(jobslist.companyLogoUrl!) as ImageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  width10,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          jobslist.title,
                                          style: boldfont13,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                        SizedBox(height: 4.h),
                                        Text(
                                          jobslist.companyName,
                                          style: normalfont11,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          '${jobslist.area}, ${jobslist.city}',
                                          style: normalfont11,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              heigh10,
                              SizedBox(
                                height: 25.w,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    _buildJobTag(jobslist.employmentType),
                                    width10,
                                    _buildJobTag(
                                        '${jobslist.minSalary} - ${jobslist.maxSalary} LPA'),
                                    width10,
                                    _buildJobTag(jobslist.category),
                                    width10,
                                    _buildJobTag(jobslist.workType),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => heigh15,
                  );
                }),
              ),
            ],
          ),
        ),
      ),

      // Floating action button for manual testing
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          dev.log('🧪 Manual loadMore test - Current: ${dataController.dataList.length}/${dataController.totalCount.value}',
              name: 'TestButton');
          dataController.loadMore();
        },
        backgroundColor: kprimarycolor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildJobTag(String text) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.5),
        color: kashcolor,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
          color: kprimarycolor,
        ),
      ),
    );
  }

  InputDecoration textInputDecoration(String hinttext, IconData? prefixIcon) {
    return InputDecoration(
      filled: true,
      fillColor: kwhitecolor,
      suffixIcon: Icon(prefixIcon, color: kblackcolor, size: 27.w),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          style: BorderStyle.solid,
          width: 1.w,
          color: kwhitecolor,
        ),
        borderRadius: BorderRadius.circular(10.w),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          style: BorderStyle.solid,
          width: 1.w,
          color: kwhitecolor,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      hintText: hinttext,
      hintStyle: TextStyle(
        fontSize: 13.sp,
        color: kgreycolor.withOpacity(0.8),
      ),
    );
  }
}
