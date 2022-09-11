import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension ContextHelper on BuildContext {
  void showSnackBar({required String message, bool error = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.montserrat(),
        ),
        backgroundColor: error ? Colors.red.shade500 : Colors.green.shade300,
        duration: const Duration(seconds: 3),
        dismissDirection: DismissDirection.horizontal,
      ),
    );
  }
}
