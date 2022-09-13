import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon_project/utils/colors.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    Key? key,
    required this.controller,
    required this.hint,
    required this.keyboardType,
    this.suffixIcon,
    this.obscureText = false,
    this.lines = 1,
  }) : super(key: key);

  final TextEditingController controller;
  final String hint;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final bool obscureText;
  final int? lines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      style: GoogleFonts.poppins(),
      controller: controller,
      minLines: lines,
      maxLines: suffixIcon != null ? 1 : 15,
      obscureText: obscureText,
      decoration: InputDecoration(
        constraints: BoxConstraints(minHeight: 60.h, maxHeight: 60.h),
        hintMaxLines: 1,
        suffixIcon: suffixIcon,
        suffixIconColor: mainColor,
        hintText: hint,
        hintStyle: GoogleFonts.poppins(
          color: secondFontColor,
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFE1E1EF)),
          borderRadius: BorderRadius.circular(8.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFE1E1EF)),
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    );
  }
}
