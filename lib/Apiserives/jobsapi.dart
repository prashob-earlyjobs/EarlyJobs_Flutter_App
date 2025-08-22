import 'package:earlyjobs/Constants/constants.dart';
import 'package:earlyjobs/Model/applyjobmodel.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

class JobsApi {
  static listjobs(int page, String searchkey) async {
    String apiendpoint = '$baseUrl/public/jobs?search=$searchkey&page=$page';

    // Construct the request body
    // Map<String, dynamic> body = {
    //   "page": 1,
    // };

    // Convert the request body to a JSON String
    // String requestBody = json.encode(body);

    try {
      // Make the POST request
      http.Response response = await http.get(
        Uri.parse(apiendpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      Map hostMap = jsonDecode(response.body); //responce

      // log(response.body);

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        // Request was successful, handle the response here
        // Fluttertoast.showToast(msg: 'Data sent successfully');
        return hostMap;
      } else {
        // Request failed with an error status code, handle the error here
        Fluttertoast.showToast(msg: 'Failed to fetch');

        return {};
      }
    } catch (e) {
      // An error occurred while making the request
      Fluttertoast.showToast(msg: 'Failed to fetch');
      return {};
    }
  }

  static postJob(ApplyjobData jobData) async {
    const String apiendpoint =
        '$baseUrl/public/jobs'; // Replace with your actual API endpoint

    Map<String, dynamic> applicationData = {
      'jobId': jobData.jobId,
      'fullName': jobData.fullName,
      'email': jobData.email,
      'phone': jobData.phone,
      'fatherName': jobData.fatherName,
      'offerStatus': jobData.offerStatus,
      'dateOfBirth': jobData.dateOfBirth,
      'gender': jobData.gender,
      'aadharNumber': jobData.aadharNumber,
      'highestQualification': jobData.highestQualification,
      'currentLocation': jobData.currentLocation,
      'spokenLanguages': jobData.spokenLanguages,
      'experienceInYears': jobData.experienceInYears,
      'experienceInMonths': jobData.experienceInMonths,
      'skills': jobData.skills,
      'jobCategory': jobData.jobCategory,
      'shiftTimings': jobData.shiftTimings,
      'employmentType': jobData.employmentType,
    };

    try {
      var response = await http.post(
        Uri.parse(apiendpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(applicationData),
      );

      log('Response: ${response.body}');

      if (response.statusCode == 200) {
        // print('POST request successful');
        // print('Response: ${response.body}');
        // Handle successful response here
      } else {
        // print('POST request failed with status: ${response.statusCode}');
        // Handle error response here
      }
    } catch (e) {
      // print('Exception during POST request: $e');
      // Handle exception here
    }
  }
}
