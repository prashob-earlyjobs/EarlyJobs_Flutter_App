import 'package:earlyjobs/Constants/constants.dart';
import 'package:earlyjobs/routes/routes_constant.dart';
import 'package:flutter/material.dart';
import 'package:earlyjobs/Controller/authcontroller.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:go_router/go_router.dart';

void showOtpDialog(BuildContext context, AuthController controller) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text(
        "Verify OTP",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Enter the 6-digit OTP sent to your mobile and email.",
          ),
          const SizedBox(height: 16),
          TextField(
            controller: controller.otpController,
            maxLength: 6,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Enter 6-digit OTP",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ],
      ),
      actionsPadding: const EdgeInsets.only(left: 12, right: 12, bottom: 10, top: 0),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Verify OTP Button
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kprimarycolor,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  final success = await controller.handleOtpVerificationAndSignup(context);

                  if (success) {
                    // Close the dialog first
                    Navigator.of(context).pop();
                    controller.hideOtpPopup();

                    // Navigate to Home screen with GoRouter
                    context.go(Routes.homeScreen.path);
                  }
                },
                child: const Text(
                  "Verify OTP",
                  style: TextStyle(fontWeight: FontWeight.w900, color: kwhitecolor),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Resend OTP Button with Timer (Obx)
            Expanded(
              child: Obx(() {
                final int seconds = controller.resendSeconds.value;
                final bool isWaiting = seconds > 0;
                return OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey.shade400),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: isWaiting
                      ? null
                      : () async {
                    await controller.sendOtp(context);
                  },
                  child: isWaiting
                      ? Text(
                    "Resend OTP (${seconds}s)",
                    style: const TextStyle(
                        fontWeight: FontWeight.w900, color: Colors.grey),
                  )
                      : const Text(
                    "Resend OTP",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Colors.black
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ],
    ),
  );
}
