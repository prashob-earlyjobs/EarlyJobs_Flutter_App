import 'package:earlyjobs/Constants/constants.dart';
import 'package:earlyjobs/Controller/authcontroller.dart';
import 'package:earlyjobs/View/widgets/snackbar.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginWidget extends StatelessWidget {
  final AuthController controller = Get.find();

  LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kVeryLightOrangeBg,
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 8),
            const Text(
              'Sign in to your account',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24),
            ),
            const SizedBox(height: 10),
            const Text(
              'Enter your credentials to access your dashboard',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
            const SizedBox(height: 25),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Email or Mobile Number',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: controller.loginEmailOrPhoneController,
                  decoration: InputDecoration(
                    hintText: 'your@email.com or 9876543210',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16,
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ],
            ),
            const SizedBox(height: 25),
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
                Obx(
                      () => TextField(
                    controller: controller.loginPasswordController,
                    obscureText: !controller.loginPasswordVisible.value,
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 16,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.loginPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off_outlined,
                          color: Colors.grey,
                        ),
                        onPressed: controller.toggleLoginPasswordVisibility,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(color: Colors.deepOrange),
                ),
              ),
            ),
            const SizedBox(height: 10),
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
                  final value = controller.loginEmailOrPhoneController.text;
                  final password = controller.loginPasswordController.text;
                  final errMsg = controller.validateLoginCredentials(value,password);

                  if (errMsg != null) {
                    CustomSnackbarManager.showError(
                        context, errMsg); // using our custom snackbar
                    return;
                  }

                  // continue login logic...
                },
                child: const Text(
                  'Sign In',
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
    );
  }
}
