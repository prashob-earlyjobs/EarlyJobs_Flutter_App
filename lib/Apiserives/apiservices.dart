// api_service.dart
import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';

import 'package:earlyjobs/Constants/constants.dart';
import 'package:http/http.dart' as http;
class Job {
  Job.fromJson(Map<String, dynamic> json) : data = json;
  final Map<String, dynamic> data;
}

class JobResponse {
  JobResponse.fromJson(Map<String, dynamic> json)
      : jobs        = (json['jobs'] as List).map((e) => Job.fromJson(e)).toList(),
        totalCount  = json['count'] as int;

  final List<Job> jobs;
  final int       totalCount;
}

class ApiService {
  ApiService([http.Client? client]) : _client = client ?? http.Client();

  // ───────────────────────────────────────────────────────── fetch ONE page
  Future<JobResponse> fetchPage({
    required int page,
    required String query,
  }) async {
    final url = Uri.parse('$baseUrl/public/jobs?search=$query&page=$page');
    dev.log('➡️  Requesting page=$page | query="$query"', name: 'ApiService');

    final res = await _client
        .get(url)
        .timeout(const Duration(seconds: 10));

    dev.log('⬅️  Status=${res.statusCode}', name: 'ApiService');

    if (res.statusCode == 200) {
      return JobResponse.fromJson(jsonDecode(res.body));
    }
    throw HttpException('Failed to load jobs | code=${res.statusCode}');
  }

  // ─────────────────────────────────────────────────────── fetch ALL pages
  Future<List<Job>> fetchAll({
    required String query,
    int startPage = 1,
    int pageSize  = 20,     // API default page size
    int maxPages  = 50,     // safety valve
  }) async {
    final List<Job> allJobs = [];
    var currentPage = startPage;

    while (currentPage <= maxPages) {
      final pageResult = await fetchPage(page: currentPage, query: query);

      allJobs.addAll(pageResult.jobs);
      dev.log(
        '📄  Page $currentPage fetched: '
            '${pageResult.jobs.length} jobs '
            '(total so far: ${allJobs.length}/${pageResult.totalCount})',
        name: 'ApiService',
      );

      final gotEverything = allJobs.length >= pageResult.totalCount;
      final lastPage      = pageResult.jobs.length < pageSize;

      if (gotEverything || lastPage) {
        dev.log('✅  Finished pagination – ${allJobs.length} jobs retrieved',
            name: 'ApiService');
        break;
      }
      currentPage++;
    }
    return allJobs;
  }

  // ────────────────────────────────────────────────────────────── clean-up
  void dispose() => _client.close();

  final http.Client _client;
}




// static listjobs(int page, String searchkey) async {
//     String apiendpoint = '$apiUrl/public/jobs?search=$searchkey&page=$page';

//     // Construct the request body
//     // Map<String, dynamic> body = {
//     //   "page": 1,
//     // };

//     // Convert the request body to a JSON String
//     // String requestBody = json.encode(body);

//     try {
//       // Make the POST request
//       http.Response response = await http.get(
//         Uri.parse(apiendpoint),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//       );

//       Map hostMap = jsonDecode(response.body); //responce

//       // print(response.body);

//       // Check if the request was successful (status code 200)
//       if (response.statusCode == 200) {
//         // Request was successful, handle the response here
//         // Fluttertoast.showToast(msg: 'Data sent successfully');
//         return hostMap;
//       } else {
//         // Request failed with an error status code, handle the error here
//         Fluttertoast.showToast(msg: 'Failed to fetch');

//         return {};
//       }
//     } catch (e) {
//       // An error occurred while making the request
//       Fluttertoast.showToast(msg: 'Failed to fetch');
//       return {};
//     }
//   }