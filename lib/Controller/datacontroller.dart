// data_controller.dart
import 'package:earlyjobs/Apiserives/apiservices.dart';
import 'package:get/get.dart';

class DataController extends GetxController {
  var dataList = <dynamic>[].obs;
  var isLoading = false.obs;
  var page = 1.obs;
  var searchQuery = ''.obs;

  final ApiService apiService;

  DataController(this.apiService);

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    try {
      isLoading(true);
      // print(page.value);
      var data =
          await apiService.fetchData(page.value, searchQuery.value) as Map;

      print(data);

      if (data.isNotEmpty) {
        dataList.addAll(data['jobs']);
      }
    } finally {
      isLoading(false);
    }
  }

  void search(String query) {
    searchQuery.value = query;
    dataList.clear();
    page.value = 1;
    fetchData();
  }

  void loadMore() {
    if (!isLoading.value) {
      page.value++;
      fetchData();
    }
  }
}
