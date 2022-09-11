import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

mixin ApiHelpers {
  void showSnackBar(BuildContext context,
      {required String message, bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.cairo(),
        ),
        backgroundColor: error ? Colors.red.shade700 : Colors.blue.shade300,
        duration: const Duration(seconds: 3),
        dismissDirection: DismissDirection.horizontal,
      ),
    );
  }
}
