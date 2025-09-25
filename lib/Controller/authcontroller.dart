import 'dart:async';
import 'dart:developer' as dev;
import 'package:earlyjobs/Apiserives/authServices.dart';
import 'package:earlyjobs/Constants/accessToken.dart';
import 'package:earlyjobs/View/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AuthController extends GetxController {
  // For switching between Login & Signup
  var isLogin = true.obs;

  // Login controllers & state
  final loginEmailOrPhoneController = TextEditingController();
  final loginPasswordController = TextEditingController();
  var loginPasswordVisible = false.obs;
  var signupPasswordVisible = false.obs;
  var signupConfirmPasswordVisible = false.obs;
  final isOtpPopupVisible = false.obs;
  final resendSeconds = 0.obs; // starts at zero
  Timer? _resendTimer;

  // Signup controllers (unchanged for now)
  final signupNameController = TextEditingController();
  final signupEmailController = TextEditingController();
  final signupPhoneController = TextEditingController();
  final signupReferrerController = TextEditingController();
  final signupPasswordController = TextEditingController();
  final signupConfirmPasswordController = TextEditingController();
  final otpController = TextEditingController();

  void switchToLogin() => isLogin.value = true;
  void switchToSignup() => isLogin.value = false;

  // Toggle password visibility
  void toggleLoginPasswordVisibility() {
    loginPasswordVisible.value = !loginPasswordVisible.value;
  }
  void toggleSignupPasswordVisibility() {
    signupPasswordVisible.value = !signupPasswordVisible.value;
  }

  void toggleSignupConfirmPasswordVisibility() {
    signupConfirmPasswordVisible.value = !signupConfirmPasswordVisible.value;
  }
  void startResendCountdown() {
    _resendTimer?.cancel(); // cancel previous if any
    resendSeconds.value = 60; // reset to 60 seconds
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendSeconds.value == 0) {
        timer.cancel();
      } else {
        resendSeconds.value = resendSeconds.value - 1;
      }
    });
  }

  // Validation helpers
  bool _isValidEmail(String value) {
    return GetUtils.isEmail(value.trim());
  }

  bool _isValidPhone(String value) {
    final phone = value.trim();
    return RegExp(r'^[6-9]\d{9}$').hasMatch(phone);
  }

  /// Validate either a valid email or a valid 10-digit phone number
  String? validateLoginCredentials(String emailOrPhone, String password) {
    // Validate email or phone first
    if (!_isValidEmail(emailOrPhone) && !_isValidPhone(emailOrPhone)) {
      return "Please enter a valid mobile number or email address!";
    }

    // Then validate password presence
    if (password.isEmpty) {
      return "Invalid credentials"; // password empty error
    }

    // All good
    return null;
  }
  Future<bool> login(BuildContext context) async {
    final loginId = loginEmailOrPhoneController.text.trim();
    final password = loginPasswordController.text;

    dev.log('[LOGIN] Attempt: loginId="$loginId" password="${'*' * password.length}"');
    try {
      final response = await AuthService().login(
        emailOrMobile: loginId,
        password: password,
      );

      dev.log('[LOGIN] Response: $response');
      CustomSnackbarManager.to.showError(context, response.message);

      if (response.success && response.data != null) {
        dev.log('[LOGIN] SUCCESS: Saving access token: ${response.data!.accessToken}');
        await TokenStorage.saveToken(response.data!.accessToken);
        // Optionally log user info:
        dev.log('[LOGIN] User info: ${response.data!.user}');
        return true;
      } else {
        dev.log('[LOGIN] FAILURE: success=${response.success} data=${response.data}');
        return false;
      }
    } catch (e, st) {
      dev.log('[LOGIN] ERROR: $e', stackTrace: st);
      CustomSnackbarManager.to.showError(context, 'Login failed. Please try again.');
      return false;
    }
  }  String? validateSignupFields() {
    // 1. Validate phone first
    final phone = signupPhoneController.text.trim();
    if (phone.isEmpty) {
      return "Mobile number is required.";
    } else if (!_isValidPhone(phone)) {
      return "Please enter a valid 10-digit mobile number.";
    }

    // 2. Password validity checks
    final password = signupPasswordController.text;
    if (password.isEmpty) {
      return "Password is required.";
    } else if (password.length < 6) {
      return "Password should be at least 6 characters.";
    }
    // Additional password complexity check
    else if (!RegExp(r'(?=.*[A-Z])').hasMatch(password)) {
      return "Password should contain at least one uppercase letter.";
    } else if (!RegExp(r'(?=.*\d)').hasMatch(password)) {
      return "Password should contain at least one number.";
    } else if (!RegExp(r'(?=.*[!@#$%^&*(),.?":{}|<>])').hasMatch(password)) {
      return "Password should contain at least one special character.";
    }

    // 3. Confirm password check
    final confirmPassword = signupConfirmPasswordController.text;
    if (confirmPassword.isEmpty) {
      return "Confirm Password is required.";
    } else if (password != confirmPassword) {
      return "Password and Confirm Password do not match.";
    }

    // 4. Email validation
    final email = signupEmailController.text.trim();
    if (email.isEmpty) {
      return "Email is required.";
    } else if (!_isValidEmail(email)) {
      return "Please enter a valid email address.";
    }

    // 5. Full name validation
    final name = signupNameController.text.trim();
    if (name.isEmpty) {
      return "Full Name is required.";
    }

    // All validations passed
    return null;
  }
  Future<bool> sendOtp(BuildContext context) async {
    final phone = signupPhoneController.text.trim();
    final email = signupEmailController.text.trim();

    try {
      final response = await AuthService().sendOtp(
        phoneNumber: phone,
        email: email,
        toChangePassword: false,
      );

      if (response.success) {
        startResendCountdown(); // <-- Start 60s timer!
        return true;
      } else {
        CustomSnackbarManager.to.showError(context, response.message);
        return false;
      }
    } catch (e) {
      CustomSnackbarManager.to.showError(context, "Failed to send OTP. Please try again.");
      return false;
    }
  }
  Future<bool> verifyOtp(BuildContext context) async {
    final phone = signupPhoneController.text.trim();
    final email = signupEmailController.text.trim();
    final otp = otpController.text.trim();

    try {
      final response = await AuthService().verifyOtp(
        phoneNumber: phone,
        email: email,
        otp: otp,
      );

      if (response.success) {
        // OTP verified, proceed next (e.g., navigate to dashboard)
        return true;
      } else {
        CustomSnackbarManager.to.showError(context, response.message);
        return false;
      }
    } catch (e) {
      CustomSnackbarManager.to.showError(context, "OTP verification failed. Please try again.");
      return false;
    }
  }
  Future<bool> handleOtpVerificationAndSignup(BuildContext context) async {
    final isOtpVerified = await verifyOtp(context);
    if (isOtpVerified) {
      final signupSuccess = await signup(context);
      return signupSuccess; // Only true if signup succeeded
    }
    return false;
  }

  Future<bool> signup(BuildContext context) async {
    try {
      final response = await AuthService().signup(
        name: signupNameController.text.trim(),
        email: signupEmailController.text.trim(),
        mobile: signupPhoneController.text.trim(),
        password: signupPasswordController.text,
        refererId: signupReferrerController.text.trim().isEmpty
            ? null
            : signupReferrerController.text.trim(),
      );
      CustomSnackbarManager.to.showError(context, response.message);
      if (response.success && response.accessToken != null) {
        await TokenStorage.saveToken(response.accessToken!);
      }
      return response.success;
    } catch (e) {
      CustomSnackbarManager.to.showError(context, "Signup failed. Please try again.");
      return false;
    }
  }



  // Optionally: Function to close/hide OTP popup
  void hideOtpPopup() {
    isOtpPopupVisible.value = false;
    otpController.clear();
  }


  @override
  void onClose() {
    loginEmailOrPhoneController.dispose();
    loginPasswordController.dispose();
    signupNameController.dispose();
    signupEmailController.dispose();
    signupPhoneController.dispose();
    signupReferrerController.dispose();
    signupPasswordController.dispose();
    signupConfirmPasswordController.dispose();
    otpController.dispose();
    _resendTimer?.cancel();
    super.onClose();
  }
}
