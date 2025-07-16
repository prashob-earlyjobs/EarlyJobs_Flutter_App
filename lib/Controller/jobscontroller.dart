import 'dart:developer';

import 'package:earlyjobs/Apiserives/jobsapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HostListController extends GetxController {
  int selectedProfession = 0;

  String selectedProfessionString = 'All';

  String searchKey = '';

  bool isMoreData = true;

  bool isLoading = false;

  int page = 1;

  var currentUid = '';

  // List<Map<String, dynamic>> hostList = [];

  List allJobsList = [];

  ScrollController scrollController = ScrollController();
  // var distanceBetween = Geolocator.distanceBetween(source.latitude,
  //     source.longitude, destination.latitude, destination.longitude);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    page = 1;

    fetchHostList();

    scrollController.addListener(addscrollController);
  }

  @override
  void onClose() {
    // Place your cleanup code here

    allJobsList.clear();

    page = 1;

    super.onClose();
  }

  changesearchkey(key) {
    searchKey = key;
    fetchHostList();
    refresh();
  }

  changeSearchkeyValue(searchKey) {
    allJobsList.clear();

    this.searchKey = searchKey;
    isMoreData = true;
    // fetchHostListSearch();
    refresh();
  }

  addscrollController() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      isLoading = true;

      if (isMoreData) {
        page = page + 1;
      }

      fetchHostList();

      isLoading = false;
    }
    refresh();
  }

  fetchHostList() async {
    // print(isMoreData);
    if (isMoreData) {
      isLoading = true;

      Map hostMap = await JobsApi.listjobs(page, searchKey);

      allJobsList.addAll(hostMap['jobs']);

      if (hostMap['jobs'].length < 20) {
        isMoreData = false;
      }

      log(' Controller ${allJobsList.length}');

      isLoading = false;
      refresh();

      return allJobsList;
    }
  }

  // fetchHostListSearch() async {
  //   if (isMoreData) {
  //     isLoading = true;

  //     Map hostMap = await profileApi.searchHosts(
  //         latitude: HomeScreen.latitude,
  //         longitude: HomeScreen.longitude,
  //         searchQuery: searchKey,
  //         profession: selectedProfessionString,
  //         page: page);
  //     // allJobsList.addAll(hostMap['hosts']);

  //     List hostList = hostMap['hosts'];
  //     // log(allJobsList.length.toString());
  //     print('${allJobsList.length} $selectedProfessionString $page');

  //     if (hostMap['hosts'].length < 20) {
  //       isMoreData = false;
  //     }
  //     isLoading = false;
  //     refresh();

  //     return hostList;
  //   }
  // }

  changeSelectedProfession(
      int index, double longitude, double latitude, String profession) {
    selectedProfession = index;
    selectedProfessionString = profession;
    fetchHostList();
    refresh();
  }

  // changeSelectedProfessionsearch(
  //     int index, double longitude, double latitude, String profession) {
  //   selectedProfession = index;
  //   selectedProfessionString = profession;

  //   fetchHostListSearch();
  //   refresh();
  // }
}
