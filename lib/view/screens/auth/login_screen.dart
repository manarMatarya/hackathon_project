import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon_project/firebase/fb_auth_controller.dart';
import 'package:hackathon_project/get/user_getx_controller.dart';
import 'package:hackathon_project/models/fb_response.dart';
import 'package:hackathon_project/prefs/shared_pref_controller.dart';
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
  late TextEditingController _idController;
  late TextEditingController _passwordController;

  bool _obsecure = true;
  String userType = SharedPrefController().getValueFor(PrefKeys.type.name);

  @override
  void initState() {
    super.initState();
    _idController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:  Text(
          context.localizations.login,
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_circle_right_sharp,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        children: [
          Align(
              alignment: Alignment.center,
              child: Image.asset(
                'images/logo.png',
                height: 200.h,
                width: 250.w,
              )),
          Text(
            userType == 'admin' ? 'البريد الالكتروني' : 'رقم الهوية ',
            style: GoogleFonts.cairo(
              color: mainFontColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          AppTextField(
            hint: userType == 'admin'
                ? ' ادخل البريد الالكتروني'
                : 'ادخل رقم الهوية',
            keyboardType: userType == 'admin'
                ? TextInputType.emailAddress
                : TextInputType.number,
            controller: _idController,
          ),
          SizedBox(
            height: 25.h,
          ),
          Text(
            'كلمة المرور',
            style: GoogleFonts.cairo(
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
            lines: 1,
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
                style: GoogleFonts.cairo(
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
                style: GoogleFonts.cairo(
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
                  style: GoogleFonts.cairo(
                      color: mainColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                      decorationColor: mainColor),
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
    if (_idController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      return true;
    }
    context.showSnackBar(message: 'Enter required data', error: true);
    return false;
  }

  void _login() async {
    Future.delayed(const Duration(seconds: 1), () async {
      FbResponse fbResponse = await FbAuthController().adminSignIn(
        id: _idController.text,
        password: _passwordController.text,
      );
      if (fbResponse.success) {
        // ignore: use_build_context_synchronously
        userType == 'admin'
            ? Navigator.pushReplacementNamed(context, '/admin_bottom_nav_screen')
            : Navigator.pushReplacementNamed(context, '/bottom_nav_screen');
      }
      // ignore: use_build_context_synchronously
      context.showSnackBar(
        message: fbResponse.message,
        error: !fbResponse.success,
      );
    });
  }
}
