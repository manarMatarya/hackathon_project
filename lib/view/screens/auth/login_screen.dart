import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon_project/firebase/fb_auth_controller.dart';
import 'package:hackathon_project/models/fb_response.dart';
import 'package:hackathon_project/utils/colors.dart';
import 'package:hackathon_project/utils/context_extenssion.dart';
import 'package:hackathon_project/view/widgets/main_button.dart';
import 'package:hackathon_project/view/widgets/text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool _obsecure = true;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'تسجيل الدخول',
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_circle_right_sharp,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        children: [
          Align(
              alignment: Alignment.center,
              child: Image.asset('images/logo.png')),
          SizedBox(
            height: 20.h,
          ),
          Text(
            'رقم الهوية ',
            style: GoogleFonts.poppins(
              color: mainFontColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          AppTextField(
            hint: 'ادخل رقم الهوية',
            keyboardType: TextInputType.number,
            controller: _emailController,
          ),
          SizedBox(
            height: 25.h,
          ),
          Text(
            'كلمة المرور',
            style: GoogleFonts.poppins(
              color: mainFontColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          AppTextField(
            hint: 'ادخل كلمة المرور',
            keyboardType: TextInputType.text,
            controller: _passwordController,
            obscureText: _obsecure,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _obsecure = !_obsecure;
                });
              },
              icon: Icon(_obsecure ? Icons.visibility : Icons.visibility_off),
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          SizedBox(
            width: double.infinity,
            child: InkWell(
              onTap: () =>
                  Navigator.pushNamed(context, '/forgot_password_screen'),
              child: Text(
                'نسيت كلمة المرور؟',
                style: GoogleFonts.poppins(
                  color: mainColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          MainButton(
            text: 'تسجيل الدخول',
            onPressed: () => _performLogin(),
          ),
          SizedBox(
            height: 12.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'ليس لديك حساب؟',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF6A6D7C),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/register_screen');
                },
                child: Text(
                  'سجل الأن',
                  style: GoogleFonts.poppins(
                    color: mainColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                    decorationColor: mainColor
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _performLogin() {
    if (_checkData()) {
      _login();
    }
  }

  bool _checkData() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      return true;
    }
    context.showSnackBar(message: 'Enter required data', error: true);
    return false;
  }

  void _login() async {
    FbResponse fbResponse = await FbAuthController().signIn(
      email: _emailController.text,
      password: _passwordController.text,
    );
    if (fbResponse.success) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/home_screen');
    }
    // ignore: use_build_context_synchronously
    context.showSnackBar(
      message: fbResponse.message,
      error: !fbResponse.success,
    );
  }
}
