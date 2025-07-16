// api_service.dart
import 'package:earlyjobs/Constants/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  fetchData(int page, String query) async {
    final response = await http
        .get(Uri.parse('$apiUrl/public/jobs?search=$query&page=$page'));

    // print(response.body);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
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