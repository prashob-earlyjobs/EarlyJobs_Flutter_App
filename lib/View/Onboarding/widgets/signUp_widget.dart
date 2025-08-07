import 'package:earlyjobs/Constants/constants.dart';
import 'package:earlyjobs/Controller/authcontroller.dart';
import 'package:earlyjobs/View/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpWidget extends StatelessWidget {
  final AuthController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kVeryLightOrangeBg,
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 8),
              const Text(
                'Create your account',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 8),
              const Text(
                'Join thousands of candidates advancing their careers',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
              ),
              const SizedBox(height: 25),
              // Name Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Full Name',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: controller.signupNameController,
                    decoration: InputDecoration(
                      hintText: 'Your full name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              // Email Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Email',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: controller.signupEmailController,
                    decoration: InputDecoration(
                      hintText: 'your@email.com',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              // Phone Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Mobile Number',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: controller.signupPhoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: '9876543210',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              // Referrer ID Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Referrer ID (optional)',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: controller.signupReferrerController,
                    decoration: InputDecoration(
                      hintText: 'Enter Referrer ID',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              // Password Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Password',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Obx(() => TextField(
                    controller: controller.signupPasswordController,
                    obscureText: !controller.signupPasswordVisible.value,
                    decoration: InputDecoration(
                      hintText: 'Create a strong password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 16,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.signupPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off_outlined,
                          color: Colors.grey,
                        ),
                        onPressed: controller.toggleSignupPasswordVisibility,
                      ),
                    ),
                  )
                  )
                ],
              ),
              const SizedBox(height: 15),
              // Confirm Password Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Confirm Password',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Obx(() => TextField(
                    controller: controller.signupConfirmPasswordController,
                    obscureText: !controller.signupConfirmPasswordVisible.value,
                    decoration: InputDecoration(
                      hintText: 'Confirm your password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 16,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.signupConfirmPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off_outlined,
                          color: Colors.grey,
                        ),
                        onPressed: controller.toggleSignupConfirmPasswordVisibility,
                      ),
                    ),
                  )),

                ],
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    final error = controller.validateSignupFields();
                    if (error != null && error.isNotEmpty) {
                      CustomSnackbarManager.showError(context, error); // show single error
                      return;
                    }
                    // Otherwise proceed with form submission / signup logic
                  },
                  child: const Text(
                    'Create Account',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}