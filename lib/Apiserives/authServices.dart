import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';
import 'package:earlyjobs/Model/logInmodel.dart';
import 'package:earlyjobs/Model/sendOtpmodel.dart';
import 'package:earlyjobs/Model/signUpResponsemodel.dart';
import 'package:http/http.dart' as http;
import 'package:earlyjobs/constants/constants.dart';

class AuthService {
  AuthService([http.Client? client]) : _client = client ?? http.Client();

  Future<SendOtpResponse> sendOtp({
    required String phoneNumber,
    required String email,
    required bool toChangePassword,
    String? transhislid,
  }) async {
    final url = Uri.parse('$apiUrl/auth/send-otp');
    final Map<String, dynamic> body = {
      "phoneNumber": phoneNumber,
      "email": email,
      "transhislid": transhislid ?? "",
      "tochangePassword": toChangePassword,
    };

    dev.log('➡️ Sending OTP | $body', name: 'AuthService');
    final res = await _client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    ).timeout(const Duration(seconds: 10));

    dev.log('⬅️ Status=${res.statusCode} | Body=${res.body}', name: 'AuthService');

    if (res.statusCode == 200) {
      return SendOtpResponse.fromJson(jsonDecode(res.body));
    }
    throw HttpException('Failed to send OTP | code=${res.statusCode}');
  }
  Future<SendOtpResponse> verifyOtp({
    required String phoneNumber,
    required String email,
    required String otp,
  }) async {
    final url = Uri.parse('$apiUrl/auth/verify-otp');
    final Map<String, dynamic> body = {
      "phoneNumber": phoneNumber,
      "email": email,
      "otp": otp,
    };

    final res = await _client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    ).timeout(const Duration(seconds: 10));

    if (res.statusCode == 200) {
      return SendOtpResponse.fromJson(jsonDecode(res.body));
    }
    throw HttpException('Failed to verify OTP | code=${res.statusCode}');
  }
  Future<SignupResponse> signup({
    required String name,
    required String email,
    required String mobile,
    required String password,
    String? refererId,
  }) async {
    final url = Uri.parse('$apiUrl/auth/register');
    final Map<String, dynamic> body = {
      "name": name,
      "email": email,
      "mobile": mobile,
      "password": password,
      "refererId": refererId ?? "",
    };

    final res = await _client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    ).timeout(const Duration(seconds: 10));

    if (res.statusCode == 200 || res.statusCode == 201) {
      return SignupResponse.fromJson(jsonDecode(res.body));
    }
    throw HttpException('Failed to sign up | code=${res.statusCode}');
  }
  Future<LoginResponse> login({
    required String emailOrMobile,
    required String password,
  }) async {
    final url = Uri.parse('$apiUrl/auth/login');
    final Map<String, dynamic> body = {
      "emailormobile": emailOrMobile,
      "password": password,
    };

    final res = await _client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    ).timeout(const Duration(seconds: 10));

    if (res.statusCode == 200) {
      return LoginResponse.fromJson(jsonDecode(res.body));
    }
    throw HttpException('Failed to login | code=${res.statusCode}');
  }
  void dispose() => _client.close();
  final http.Client _client;
}

