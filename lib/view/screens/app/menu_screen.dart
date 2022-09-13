import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon_project/utils/colors.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
      children: [
        const Divider(
          color: greyColor,
          thickness: 2,
        ),
        ListTile(
          onTap: () => Navigator.pushNamed(context, '/complaint_screen'),
          horizontalTitleGap: 0,
          minVerticalPadding: 0,
          leading: const Icon(
            Icons.help,
            color: mainColor,
          ),
          title: Text(
            'الشكاوي والمقترحات',
            style: GoogleFonts.poppins(fontSize: 16.sp),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: greyColor,
          ),
        ),
        ListTile(
          horizontalTitleGap: 0,
          minVerticalPadding: 0,
          leading: const Icon(
            Icons.info,
            color: mainColor,
          ),
          title: Text(
            'حول التطبيق',
            style: GoogleFonts.poppins(fontSize: 16.sp),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: greyColor,
          ),
        ),
        ListTile(
          horizontalTitleGap: 0,
          minVerticalPadding: 0,
          leading: const Icon(
            Icons.phone,
            color: mainColor,
          ),
          title: Text(
            'اتصل بنا',
            style: GoogleFonts.poppins(fontSize: 16.sp),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: greyColor,
          ),
        ),
        ListTile(
          horizontalTitleGap: 0,
          minVerticalPadding: 0,
          leading: const Icon(
            Icons.logout,
            color: mainColor,
          ),
          title: Text(
            'تسجيل الخروج',
            style: GoogleFonts.poppins(fontSize: 16.sp),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: greyColor,
          ),
        ),
      ],
    );
  }
}
