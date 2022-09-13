import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon_project/view/widgets/main_button.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset(
              'images/success.png',
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              'تم ارسال طلبك بنجاح',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: MainButton(
                text: 'الرئيسية',
                onPressed: () {
                  Navigator.pushNamed(context, '/bottom_nav_screen');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
