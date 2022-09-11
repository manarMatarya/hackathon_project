import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon_project/utils/colors.dart';
import 'package:hackathon_project/view/widgets/traansaction_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.9, initialPage: 1);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: 10.h,
        ),
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
          leading: CircleAvatar(
            radius: 40.r,
            backgroundColor: Colors.transparent,
            backgroundImage: const AssetImage('images/slider.png'),
          ),
          title: Text(
            'مرحبا دينا',
            style: GoogleFonts.poppins(
              fontSize: 16.sp,
              height: 0,
              fontWeight: FontWeight.bold,
            ),
          ),
          minLeadingWidth: 24.w,
          subtitle: Text(
            'أهلا بعودتك',
            style: GoogleFonts.poppins(
              height: 0,
              fontSize: 16.sp,
              color: secondFontColor,
            ),
          ),
          trailing: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_active_outlined,
                color: Colors.black,
              )),
        ),
        Divider(
          height: 20.h,
        ),
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 180.h),
          child: PageView.builder(
            controller: _pageController,
            itemCount: 3,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Image.asset(
                'images/slider.png',
                fit: BoxFit.cover,
              );
            },
          ),
        ),
        SizedBox(
          height: 25.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Text(
            'اطلب خدمتك',
            style: GoogleFonts.poppins(
              color: mainFontColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          height: 12.h,
        ),
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 130.h),
          child: GridView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            scrollDirection: Axis.horizontal,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 10.w,
              childAspectRatio: 120.h / 95.w,
            ),
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/loan_request_screen');
                },
                child: const TransactionCard(
                  image: 'loan',
                  title: 'القروض',
                  sub: 'بأمكانك من خلال التطبيق سحب القرض ',
                ),
              ),
              const TransactionCard(
                image: 'transfer',
                title: 'التحويل',
                sub: 'بأمكانك من خلال التطبيق تحويل مبلغ',
              ),
              const TransactionCard(
                image: 'account',
                title: 'تعبئة رصيد',
                sub: 'بأمكانك من خلال التطبيق تعبئة رصيد ',
              ),
            ],
          ),
        ),
        SizedBox(height: 25.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Text(
            'العمليات الأخيرة',
            style: GoogleFonts.poppins(
              color: mainFontColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: 20.h),
        Column(
          children: [
            Image.asset('images/paper.png'),
            SizedBox(
              height: 12.h,
            ),
            Text(
              'لا يوجد عمليات',
              style: GoogleFonts.poppins(
                color: Color(0xFFB9B9B9),
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
