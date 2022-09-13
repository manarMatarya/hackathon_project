import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon_project/get/transaction_getx_controller.dart';
import 'package:hackathon_project/utils/colors.dart';

class ShowTransactions extends StatefulWidget {
  const ShowTransactions({Key? key}) : super(key: key);

  @override
  State<ShowTransactions> createState() => _ShowTransactionsState();
}

class _ShowTransactionsState extends State<ShowTransactions> {
  final TransactionGetxController _transactionGetxController =
      Get.put(TransactionGetxController());
  @override
  void initState() {
    super.initState();
    _transactionGetxController.getTransaction(status: 'انتظار');
  }

  List statuses = ['انتظار', 'مراجعة', 'مقبول', 'مرفوض'];
  var currentStatus = 0;
  List subjects = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'معاملاتي',
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_active_outlined,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        children: [
          Container(
            height: 60.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                border: Border.all(color: greyColor)),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: statuses.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      _transactionGetxController.transactions.value = [];
                      currentStatus = index;
                      _transactionGetxController.getTransaction(
                        status: statuses[index],
                      );
                    });
                  },
                  child: mainCard(
                    name: statuses[index],
                    index: index,
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const VerticalDivider(
                  color: Color(0xFFE1E1EF),
                );
              },
            ),
          ),
          SizedBox(
            height: 40.h,
          ),
          GetX<TransactionGetxController>(
            builder: (controller) {
              return controller.isLoading.isTrue
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: mainColor,
                      ),
                    )
                  : controller.transactions.isEmpty
                      ? Center(
                          child: Text(
                            'لا يوجد معاملات بعد',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.sp,
                            ),
                          ),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.transactions.length,
                          itemBuilder: ((context, index) {
                            return ListTile(
                              iconColor: controller
                                          .transactions[index].status ==
                                      'انتظار'
                                  ? const Color(0xFFD2753F)
                                  : controller.transactions[index].status ==
                                          'مراجعة'
                                      ? const Color(0xFF3772FF)
                                      : controller.transactions[index].status ==
                                              'مقبول'
                                          ? const Color(0xFF28CA6A)
                                          : controller.transactions[index]
                                                      .status ==
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
                                    color: const Color(0xFF000000)
                                        .withOpacity(0.8)),
                              ),
                              trailing: Text(
                                controller.transactions[index].startDate,
                                style: GoogleFonts.poppins(
                                  fontSize: 14.sp,
                                  color:
                                      const Color(0xFF000000).withOpacity(0.8),
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
      ),
    );
  }

  Widget mainCard({name, index}) {
    return Container(
      width: 70.w,
      height: 60.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: currentStatus == index ? const Color(0xFFD9D9D9) : Colors.white,
      ),
      padding: const EdgeInsets.all(15),
      child: Center(
        child: Text(
          name,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: currentStatus == index && index == 0
                ? const Color(0xFFD2753F)
                : currentStatus == index && index == 1
                    ? const Color(0xFF3772FF)
                    : currentStatus == index && index == 2
                        ? const Color(0xFF28CA6A)
                        : currentStatus == index && index == 3
                            ? const Color(0xFFFF3737)
                            : Colors.black,
          ),
        ),
      ),
    );
  }
}
