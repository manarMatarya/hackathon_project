import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon_project/utils/colors.dart';
import 'package:hackathon_project/view/widgets/main_button.dart';
import 'package:hackathon_project/view/widgets/on_boarding_content.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 120.h,
            ),
            Expanded(
              child: PageView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                onPageChanged: (int currentPage) {
                  setState(() => _currentPage = currentPage);
                },
                children: const [
                  OnBoardingContent(
                    image: 'image1',
                    title: 'تطبيق معاملتي',
                    content:
                        'من خلال تطبيق مصرفي تستطيه الحصول على كافة معاملاتك البنكية بكل سهولة ',
                  ),
                  OnBoardingContent(
                    image: 'image2',
                    title: 'تطبيق معاملتي',
                    content:
                        'من خلال تطبيق مصرفي تستطيه الحصول على كافة معاملاتك البنكية بكل سهولة ',
                  ),
                  OnBoardingContent(
                    image: 'image3',
                    title: 'تطبيق معاملتي',
                    content:
                        'من خلال تطبيق مصرفي تستطيه الحصول على كافة معاملاتك البنكية بكل سهولة ',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TabPageSelectorIndicator(
                  backgroundColor: _currentPage == 0 ? mainColor : greyColor,
                  borderColor: _currentPage == 0 ? mainColor : greyColor,
                  size: 5.h,
                ),
                TabPageSelectorIndicator(
                  backgroundColor: _currentPage == 1 ? mainColor : greyColor,
                  borderColor: _currentPage == 1 ? mainColor : greyColor,
                  size: 5.h,
                ),
                TabPageSelectorIndicator(
                  backgroundColor: _currentPage == 2 ? mainColor : greyColor,
                  borderColor: _currentPage == 2 ? mainColor : greyColor,
                  size: 5.h,
                ),
              ],
            ),
            SizedBox(height: 50.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: _currentPage == 2
                  ? MainButton(
                      text: 'تسجيل الدخول',
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, '/login_screen');
                      },
                    )
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: greyColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.r),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _currentPage = 2;
                        });
                      },
                      child: Text(
                        'تخطي',
                        style: GoogleFonts.poppins(
                          color: mainColor,
                        ),
                      ),
                    ),
            ),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }
}
