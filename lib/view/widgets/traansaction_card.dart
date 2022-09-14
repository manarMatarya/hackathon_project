import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    Key? key,
    required this.image,
    required this.title,
    required this.sub,
  }) : super(key: key);

  final String image;
  final String title;
  final String sub;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/$image.png'),
            Text(
              title,
              style: GoogleFonts.cairo(
                fontSize: 14.sp,
              ),
            ),
            Text(
              sub,
              style: GoogleFonts.cairo(
                height: 0.h,
                fontSize: 10.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
