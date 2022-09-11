import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon_project/prefs/shared_pref_controller.dart';
import 'package:hackathon_project/view/screens/app/bottom_navigation_screen.dart';
import 'package:hackathon_project/view/screens/app/home_screen.dart';
import 'package:hackathon_project/view/screens/app/loan_request_screen.dart';
import 'package:hackathon_project/view/screens/auth/login_screen.dart';
import 'package:hackathon_project/view/screens/auth/register_screen.dart';
import 'package:hackathon_project/view/screens/launch_screen.dart';
import 'package:hackathon_project/view/screens/on_boarding_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedPrefController().initPreferences();
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
        return MaterialApp(
          localizationsDelegates: const [
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('ar'),
            Locale('en'),
          ],
          locale: const Locale('ar'),
          theme: ThemeData(
            appBarTheme: AppBarTheme(
                backgroundColor: Colors.transparent,
                elevation: 0,
                iconTheme: const IconThemeData(color: Colors.grey),
                titleTextStyle:
                    GoogleFonts.poppins(color: Colors.black, fontSize: 20.sp)),
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: '/bottom_nav_screen',
          routes: {
            '/launch_screen': (context) => const LaunchScreen(),
            '/home_screen': (context) => const HomeScreen(),
            '/login_screen': (context) => const LoginScreen(),
            '/register_screen': (context) => const RegisterScreen(),
            '/on_boarding_screen': (context) => const OnBoardingScreen(),
            '/bottom_nav_screen': (context) => const BottomNavigationScreen(),
            '/loan_request_screen': (context) => const LoanScreen(),
          },
        );
      },
    );
  }
}
