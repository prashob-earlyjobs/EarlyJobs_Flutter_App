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

  // Signup controllers (unchanged for now)
  final signupNameController = TextEditingController();
  final signupEmailController = TextEditingController();
  final signupPhoneController = TextEditingController();
  final signupReferrerController = TextEditingController();
  final signupPasswordController = TextEditingController();
  final signupConfirmPasswordController = TextEditingController();

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

  // Inside your AuthController

// Add this method to validate signup form, return a list of error messages (empty if no errors)
  String? validateSignupFields() {
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
    super.onClose();
  }
}
