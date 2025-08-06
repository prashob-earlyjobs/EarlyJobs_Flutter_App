import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

// const kprimarycolor = Color.fromARGB(255, 0, 0, 0);
const kprimarycolor = Color.fromARGB(255, 235, 106, 77);

const kprimarycolorwhiteshade = Color.fromARGB(255, 26, 51, 75);
const ksecondarycolor = Color.fromARGB(255, 250, 199, 131);
const kreddishcolor = Color.fromARGB(255, 255, 51, 0);
const ksecondarycolorwhiteshade = Color.fromARGB(255, 255, 237, 213);
const kChatbgColor = Color.fromARGB(255, 229, 249, 211);

// const mapApiKey = 'AIzaSyAUpBcAlr_-YkPuSB2yyhmi4JETpshuJdI'; //designMyhouse

const mapApiKey = 'AIzaSyB5KPXUc3hzw5qmNUhBre2RYY8UkulA6JI'; // bestBuyhub

// const razorpayApi = 'rzp_live_AtQd6lTECWHAcV'; // Sale@victman Live

const razorpayApi = 'rzp_live_PNPMTHxTD7OmWY'; // goformeet Live

// const razorpayApi = 'rzp_test_kDDo3HKL3pPe8n';

// const apiUrl = 'https://goformeet-backend.onrender.com';

const apiUrl =
    'https://apis.earlyjobs.in/api';

const placeholderimage =
    'https://firebasestorage.googleapis.com/v0/b/connectionapp-8dc63.appspot.com/o/StockImages%2Fplace_holder_User.png?alt=media&token=e2a0c339-f981-4824-b5fe-d395cf066ae4';

// const razorpayApi = 'rzp_test_oiUv8VeGpuduDv'; // Sale@victman test

// 'AIzaSyAUpBcAlr_-YkPuSB2yyhmi4JETpshuJdI'

const kwhitecolor = Colors.white;
const ksuccesscolor = Color.fromARGB(255, 32, 174, 0);
const kblackcolor = Colors.black;
const kyellowcolor = Color.fromARGB(255, 249, 179, 70);
const kgreycolor = Color.fromARGB(255, 158, 158, 158);
const kashcolor = Color.fromARGB(255, 240, 239, 239);
const kpinkcolor = Color.fromARGB(255, 247, 205, 205);
const kredcolor = Color.fromARGB(255, 255, 43, 43);
const kbluecolor = Color.fromARGB(255, 14, 12, 198);
const kverificationColor = Color.fromARGB(255, 23, 156, 240);

final heigh10 = SizedBox(height: 10.w);
final heigh15 = SizedBox(height: 15.w);
final heigh20 = SizedBox(height: 20.w);
final heigh25 = SizedBox(height: 25.w);

final heigh5 = SizedBox(height: 5.w);
final width20 = SizedBox(width: 20.w);
final width10 = SizedBox(width: 10.w);
final width15 = SizedBox(width: 15.w);
final width5 = SizedBox(width: 5.w);

final normalfont8 = TextStyle(fontSize: 8.sp);
final normalfont9 = TextStyle(fontSize: 9.sp);
final normalfont10 = TextStyle(fontSize: 10.sp);
final normalfont11 = TextStyle(fontSize: 11.sp);
final normalfont12 = TextStyle(fontSize: 12.sp);
final normalfont13 = TextStyle(fontSize: 13.sp);
final normalfont14 = TextStyle(fontSize: 14.sp);
final normalfont15 = TextStyle(fontSize: 15.sp);
final normalfont16 = TextStyle(fontSize: 16.sp);
final normalfont17 = TextStyle(fontSize: 17.sp);
final normalfont18 = TextStyle(fontSize: 18.sp);
final normalfont19 = TextStyle(fontSize: 19.sp);

final normalfont7white = TextStyle(fontSize: 7.sp, color: kwhitecolor);
final normalfont8white = TextStyle(fontSize: 8.sp, color: kwhitecolor);
final normalfont9white = TextStyle(fontSize: 9.sp, color: kwhitecolor);
final normalfont10white = TextStyle(fontSize: 10.sp, color: kwhitecolor);
final normalfont11white = TextStyle(fontSize: 11.sp, color: kwhitecolor);
final normalfont12white = TextStyle(fontSize: 12.sp, color: kwhitecolor);
final normalfont13white = TextStyle(fontSize: 13.sp, color: kwhitecolor);
final normalfont14white = TextStyle(fontSize: 14.sp, color: kwhitecolor);
final normalfont15white = TextStyle(fontSize: 15.sp, color: kwhitecolor);
final normalfont16white = TextStyle(fontSize: 16.sp, color: kwhitecolor);
final normalfont17white = TextStyle(fontSize: 17.sp, color: kwhitecolor);
final normalfont25white = TextStyle(fontSize: 25.sp, color: kwhitecolor);

final boldfont12white =
    TextStyle(fontSize: 12.sp, color: kwhitecolor, fontWeight: FontWeight.bold);
final boldfont13white =
    TextStyle(fontSize: 13.sp, color: kwhitecolor, fontWeight: FontWeight.bold);
final boldfont14white =
    TextStyle(fontSize: 14.sp, color: kwhitecolor, fontWeight: FontWeight.bold);
final boldfont15white =
    TextStyle(fontSize: 15.sp, color: kwhitecolor, fontWeight: FontWeight.bold);
final boldfont16white =
    TextStyle(fontSize: 16.sp, color: kwhitecolor, fontWeight: FontWeight.bold);
final boldfont17white =
    TextStyle(fontSize: 17.sp, color: kwhitecolor, fontWeight: FontWeight.bold);
final boldfont20white =
    TextStyle(fontSize: 20.sp, color: kwhitecolor, fontWeight: FontWeight.bold);
final boldfont22white =
    TextStyle(fontSize: 22.sp, color: kwhitecolor, fontWeight: FontWeight.bold);

final boldfont11 = TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold);
final boldfont12 = TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold);
final boldfont13 = TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold);
final boldfont14 = TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold);
final boldfont15 = TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold);
final boldfont16 = TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold);
final boldfont17 = TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold);
final boldfont19 = TextStyle(fontSize: 19.sp, fontWeight: FontWeight.bold);
final boldfont20 = TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold);
final boldfont22 = TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold);

final elevatebuttonstyle = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.w),
    ),
    backgroundColor: const Color.fromARGB(255, 250, 199, 131),
    foregroundColor: const Color.fromARGB(255, 17, 70, 60));

final elevatebuttonstyleRed = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.w),
    ),
    backgroundColor: kreddishcolor,
    foregroundColor: kwhitecolor);

final elevatebuttonstyleprimary = ElevatedButton.styleFrom(
    padding: const EdgeInsets.all(0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.w),
    ),
    backgroundColor: kprimarycolor,
    foregroundColor: kwhitecolor);

final elevatebuttonstyleprimaryprofile = ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.w),
    ),
    backgroundColor: kprimarycolor,
    foregroundColor: kwhitecolor);

const languages = [
  'English',
  'Hindi',
  'Kannada',
  'Malayalam',
  'Tamil',
  'Telugu',
  'Bengali',
  'Maithili',
  'Nepalese',
  'Sanskrit',
  'Urdu',
  'Assamese',
  'Dogri',
  'Gujarati',
  'Bodo',
  'Manipur',
  'Oriya',
  'Marathi',
  'Santali',
  'Punjabi',
  'Sindhi',
  'Konkani',
  'Kashmiri'
];

void openGoogleMapsApp(
    double destinationLatitude, double destinationLongitude) async {
  String googleMapsUrl =
      "https://www.google.com/maps/search/?api=1&query=$destinationLatitude,$destinationLongitude";

  if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
    await launchUrlString(googleMapsUrl, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not open Google Maps.';
  }
}

Future<String> getAddress(double latitude, double longitude) async {
  try {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    if (placemarks != null && placemarks.isNotEmpty) {
      Placemark placemark = placemarks.first;
      String address =
          '${placemark.street}, ${placemark.subLocality}, ${placemark.locality} ';
      return address;
    }
  } catch (e) {}
  return '';
}
