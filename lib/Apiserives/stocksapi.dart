import 'dart:convert';
import 'package:http/http.dart' as http;

class stockApi {
  static courosalImages() async {
    // String requestBody = json.encode(body);
    String apiendpoint =
        'http://goformeet.ap-south-1.elasticbeanstalk.com/stockImages/guestCarousel';
    Map responceParsed = {};
    List userNameList = [];
    try {
      // print('object');
      http.Response response = await http.get(
        Uri.parse(apiendpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      responceParsed = json.decode(response.body);

      userNameList = responceParsed['images'];
    } catch (e) {
      //
    }
    return userNameList;
  }
}
