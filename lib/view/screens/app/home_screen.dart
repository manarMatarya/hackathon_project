import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon_project/get/transaction_getx_controller.dart';
import 'package:hackathon_project/get/user_getx_controller.dart';
import 'package:hackathon_project/utils/colors.dart';
import 'package:hackathon_project/view/screens/app/update_profile.dart';
import 'package:hackathon_project/view/widgets/traansaction_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  final TransactionGetxController _transactionGetxController =
      Get.put(TransactionGetxController());
  @override
  void initState() {
    super.initState();
    _transactionGetxController.getLatestTransaction();
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
        GetX<UserGetxController>(
          builder: (controller) {
            return controller.isLoading.isTrue
                ? const Center(
                    child: CircularProgressIndicator(
                      color: mainColor,
                    ),
                  )
                : ListTile(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateProfile(
                          userModel: controller.currentUser.value,
                        ),
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
                    leading: CircleAvatar(
                      radius: 50.r,
                      backgroundColor: Colors.transparent,
                      backgroundImage:
                          NetworkImage(controller.currentUser.value.image!),
                    ),
                    title: Text(
                      'مرحبا ${controller.currentUser.value.name}',
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        height: 0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    minVerticalPadding: 0,
                    subtitle: Text(
                      'أهلا بعودتك',
                      style: GoogleFonts.poppins(
                        height: 0,
                        fontSize: 16.sp,
                        color: secondFontColor,
                      ),
                    ),
                    horizontalTitleGap: 0,
                    trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.notifications_active_outlined,
                        color: Colors.black,
                      ),
                    ),
                  );
          },
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
          padding: EdgeInsets.symmetric(horizontal: 20.w),
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
          padding: EdgeInsets.symmetric(horizontal: 20.w),
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
        GetX<TransactionGetxController>(
          builder: (controller) {
            return controller.isLoading.isTrue
                ? const Center(
                    child: CircularProgressIndicator(
                      color: mainColor,
                    ),
                  )
                : controller.transactions.isEmpty
                    ? Column(
                        children: [
                          Image.asset('images/paper.png'),
                          SizedBox(
                            height: 12.h,
                          ),
                          Text(
                            'لا يوجد عمليات',
                            style: GoogleFonts.poppins(
                              color: const Color(0xFFB9B9B9),
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                    : ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.transactions.length,
                        itemBuilder: ((context, index) {
                          return ListTile(
                            iconColor: controller.transactions[index].status ==
                                    'انتظار'
                                ? const Color(0xFF3772FF)
                                : controller.transactions[index].status ==
                                        'مقبول'
                                    ? const Color(0xFF28CA6A)
                                    : controller.transactions[index].status ==
                                            'مرفوض'
                                        ? const Color(0xFFFF3737)
                                        : Colors.black,
                            tileColor: const Color(0xFFF2F2F2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            leading: const Icon(
                              Icons.attach_money_sharp,
                            ),
                            title: Text(
                              '${controller.transactions[index].value} \$',
                              style: GoogleFonts.poppins(fontSize: 14.sp),
                            ),
                            subtitle: Text(
                              controller.transactions[index].reason,
                              style: GoogleFonts.poppins(
                                  fontSize: 14.sp,
                                  color:
                                      const Color(0xFF000000).withOpacity(0.8)),
                            ),
                            trailing: Text(
                              controller.transactions[index].startDate,
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                color: const Color(0xFF000000).withOpacity(0.8),
                              ),
                              textAlign: TextAlign.end,
                            ),
                          );
                        }),
                        separatorBuilder: (context, index) {
                          return (SizedBox(
                            height: 15.h,
                          ));
                        });
          },
        ),
      ],
    );
  }
}
