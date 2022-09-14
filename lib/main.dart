import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon_project/firebase_options.dart';
import 'package:hackathon_project/get/language_getx_controller.dart';
import 'package:hackathon_project/prefs/shared_pref_controller.dart';
import 'package:hackathon_project/view/admin/admin_bottom_nav_screen.dart';
import 'package:hackathon_project/view/admin/admin_complaint_screen.dart';
import 'package:hackathon_project/view/screens/app/bottom_navigation_screen.dart';
import 'package:hackathon_project/view/screens/app/complaint_screen.dart';
import 'package:hackathon_project/view/screens/app/home_screen.dart';
import 'package:hackathon_project/view/screens/app/loan_request_screen.dart';
import 'package:hackathon_project/view/screens/app/success_screen.dart';
import 'package:hackathon_project/view/screens/auth/login_screen.dart';
import 'package:hackathon_project/view/screens/auth/register_screen.dart';
import 'package:hackathon_project/view/screens/launch_screen.dart';
import 'package:hackathon_project/view/screens/on_boarding_screen.dart';
import 'package:hackathon_project/view/screens/user_type.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefController().initPreferences();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetX<LanguageGetxController>(
          init: LanguageGetxController(),
          global: true,
          builder: (controller) {
            return MaterialApp(
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('ar'),
                Locale('en'),
              ],
              locale: Locale(controller.language.value),
              theme: ThemeData(
                appBarTheme: AppBarTheme(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    iconTheme: const IconThemeData(color: Colors.grey),
                    titleTextStyle: GoogleFonts.cairo(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500)),
              ),
              debugShowCheckedModeBanner: false,
              initialRoute: '/launch_screen',
              routes: {
                '/launch_screen': (context) => const LaunchScreen(),
                '/home_screen': (context) => const HomeScreen(),
                '/login_screen': (context) => const LoginScreen(),
                '/register_screen': (context) => const RegisterScreen(),
                '/on_boarding_screen': (context) => const OnBoardingScreen(),
                '/bottom_nav_screen': (context) =>
                    const BottomNavigationScreen(),
                '/admin_bottom_nav_screen': (context) =>
                    const AdminBottomNavigationScreen(),
                '/loan_request_screen': (context) => const LoanScreen(),
                '/success_screen': (context) => const SuccessScreen(),
                '/complaint_screen': (context) => const ComplaintScreen(),
                '/admin_complaint_screen': (context) => const AdminComplaint(),
                '/user_type_screen': (context) => const UserType(),
              },
            );
          },
        );
      },
    );
  }
}
