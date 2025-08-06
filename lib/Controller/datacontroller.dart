// data_controller.dart
import 'dart:developer' as dev;
import 'package:earlyjobs/Apiserives/apiservices.dart';
import 'package:get/get.dart';

class DataController extends GetxController {
  var dataList = <Job>[].obs;
  var isLoading = false.obs;
  var isLoadingMore = false.obs;
  var hasReachedMax = false.obs;
  var page = 1.obs;
  var searchQuery = ''.obs;
  var totalCount = 0.obs;
  var lastFetchedCount = 0.obs;

  final ApiService apiService;

  DataController(this.apiService);

  @override
  void onInit() {
    super.onInit();
    dev.log('🚀 DataController initialized', name: 'DataController');
    fetchData();
  }

  /// Fetch data for current page with detailed logging
  void fetchData() async {
    if (isLoading.value || isLoadingMore.value) {
      dev.log('⚠️  Already loading, skipping request', name: 'DataController');
      return;
    }

    try {
      // Set loading state based on whether it's first page or load more
      if (page.value == 1) {
        isLoading(true);
        dev.log('📱 Loading first page...', name: 'DataController');
      } else {
        isLoadingMore(true);
        dev.log('📄 Loading more data (page ${page.value})...', name: 'DataController');
      }

      // Fetch page data using the updated API service
      final pageResult = await apiService.fetchPage(
        page: page.value,
        query: searchQuery.value,
      );

      dev.log(
        '✅ Page ${page.value} fetched: ${pageResult.jobs.length} jobs | '
            'Total available: ${pageResult.totalCount}',
        name: 'DataController',
      );

      // Update total count
      totalCount.value = pageResult.totalCount;
      lastFetchedCount.value = pageResult.jobs.length;

      // Add new jobs to the list
      if (pageResult.jobs.isNotEmpty) {
        dataList.addAll(pageResult.jobs);

        dev.log(
          '📊 Updated dataList: ${dataList.length}/${totalCount.value} jobs loaded',
          name: 'DataController',
        );

        // Check if we've reached the maximum
        if (dataList.length >= totalCount.value || pageResult.jobs.length < 20) {
          hasReachedMax(true);
          dev.log('🏁 Reached maximum data. No more pages to load.', name: 'DataController');
        }
      } else {
        hasReachedMax(true);
        dev.log('🔚 No more data available', name: 'DataController');
      }

    } catch (e) {
      dev.log('❌ Error fetching data: $e', name: 'DataController');
      Get.snackbar('Error', 'Failed to load data: $e');
    } finally {
      isLoading(false);
      isLoadingMore(false);
      dev.log('⏹️  Loading completed', name: 'DataController');
    }
  }

  /// Search with new query and reset pagination
  void search(String query) {
    dev.log('🔍 Starting search with query: "$query"', name: 'DataController');

    searchQuery.value = query;
    dataList.clear();
    page.value = 1;
    hasReachedMax(false);
    totalCount.value = 0;

    dev.log('🔄 Reset pagination state for new search', name: 'DataController');
    fetchData();
  }

  /// Load more data (next page)
  void loadMore() {
    if (hasReachedMax.value) {
      dev.log('⛔ Cannot load more - already at maximum', name: 'DataController');
      return;
    }

    if (isLoading.value || isLoadingMore.value) {
      dev.log('⚠️  Already loading, cannot load more', name: 'DataController');
      return;
    }

    dev.log('➡️  Loading next page (${page.value + 1})...', name: 'DataController');
    page.value++;
    fetchData();
  }

  /// Fetch all pages at once (for testing/debugging)
  void fetchAllPages() async {
    if (isLoading.value) return;

    dev.log('🔄 Starting to fetch all pages...', name: 'DataController');

    try {
      isLoading(true);
      dataList.clear();

      final allJobs = await apiService.fetchAll(
        query: searchQuery.value,
        startPage: 1,
      );

      dataList.addAll(allJobs);
      totalCount.value = allJobs.length;
      hasReachedMax(true);

      dev.log('✅ All pages fetched: ${allJobs.length} total jobs', name: 'DataController');

    } catch (e) {
      dev.log('❌ Error fetching all pages: $e', name: 'DataController');
      Get.snackbar('Error', 'Failed to fetch all data: $e');
    } finally {
      isLoading(false);
    }
  }

  /// Refresh data (pull to refresh)
  void refreshData() {
    dev.log('🔄 Refreshing data...', name: 'DataController');

    dataList.clear();
    page.value = 1;
    hasReachedMax(false);
    totalCount.value = 0;

    fetchData();
  }

  /// Get pagination status for UI
  String get paginationStatus {
    if (hasReachedMax.value) {
      return 'Showing all ${dataList.length} jobs';
    } else {
      return 'Showing ${dataList.length} of ${totalCount.value} jobs';
    }
  }

  @override
  void onClose() {
    dev.log('🔚 DataController disposed', name: 'DataController');
    apiService.dispose();
    super.onClose();
  }
}
