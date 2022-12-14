import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon_project/get/user_getx_controller.dart';
import 'package:hackathon_project/models/bn_screen.dart';
import 'package:hackathon_project/utils/colors.dart';
import 'package:hackathon_project/view/screens/app/home_screen.dart';
import 'package:hackathon_project/view/screens/app/menu_screen.dart';
import 'package:hackathon_project/view/screens/app/show_transactions.dart';
import 'package:hackathon_project/view/screens/app/update_profile.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  final UserGetxController _userGetxController = Get.put(UserGetxController());

  int _selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<BnScreen> _screens = <BnScreen>[
      const BnScreen(title: 'الرئيسية', widget: HomeScreen()),
      const BnScreen(title: 'معاملاتي', widget: ShowTransactions()),
      BnScreen(
        title: 'حسابي',
        widget: UpdateProfile(
          userModel: _userGetxController.currentUser.value,
        ),
      ),
      const BnScreen(title: 'القائمة', widget: MenuScreen()),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: _screens[_selectedPageIndex].widget),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int selectedPageIndex) {
          setState(() => _selectedPageIndex = selectedPageIndex);
        },
        currentIndex: _selectedPageIndex,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: mainColor,
        selectedLabelStyle: GoogleFonts.montserrat(
          fontWeight: FontWeight.bold,
          fontSize: 10,
        ),
        selectedFontSize: 14,
        unselectedItemColor: const Color(0xFF979797),
        unselectedIconTheme: IconThemeData(
          color: Colors.grey.shade800,
          // size: 18,
        ),
        unselectedLabelStyle: GoogleFonts.cairo(
          fontSize: 14.sp,
        ),
        unselectedFontSize: 12,
        iconSize: 24,
        elevation: 10,
        items: const [
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.note_alt),
            icon: Icon(Icons.note_alt_outlined),
            label: 'خدماتي',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outlined),
            label: 'حسابي',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.menu),
            icon: Icon(Icons.menu_outlined),
            label: 'القائمة',
          )
        ],
      ),
    );
  }
}
