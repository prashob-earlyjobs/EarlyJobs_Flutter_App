import 'package:earlyjobs/Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JobsApply extends StatelessWidget {
  const JobsApply({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(15.w),
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back,
                    size: 30.w,
                    color: kprimarycolor,
                  ),
                ),
                width10,
                Text(
                  'Apply for job',
                  style: boldfont20,
                ),
              ],
            ),
            heigh15,
            Text('Full Name', style: normalfont14),
            TextFormField()
          ],
        ),
      ),
    );
  }
}
