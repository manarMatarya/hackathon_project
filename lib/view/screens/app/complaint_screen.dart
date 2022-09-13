import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon_project/get/complaint_getx_controller.dart';
import 'package:hackathon_project/get/transaction_getx_controller.dart';
import 'package:hackathon_project/get/user_getx_controller.dart';
import 'package:hackathon_project/models/complaint.dart';
import 'package:hackathon_project/models/fb_response.dart';
import 'package:hackathon_project/utils/colors.dart';
import 'package:hackathon_project/utils/context_extenssion.dart';
import 'package:hackathon_project/view/widgets/main_button.dart';
import 'package:hackathon_project/view/widgets/text_field.dart';

class ComplaintScreen extends StatefulWidget {
  const ComplaintScreen({Key? key}) : super(key: key);

  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

var currentStatus = 0;

class _ComplaintScreenState extends State<ComplaintScreen> {
  ComplaintGetxController complaintGetxController =
      Get.put(ComplaintGetxController());
  final UserGetxController userGetxController = UserGetxController.to;

  late TextEditingController _titleController;
  late TextEditingController _contentController;
  bool _obsecure = true;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _contentController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  List statuses = ['الشكاوي', 'الاقتراحات'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'الشكاوي والمقترحات',
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
                      // _transactionGetxController.transactions.value = [];
                      currentStatus = index;
                      // _transactionGetxController.getTransaction(
                      //     status: statuses[index]);
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
            height: 20.h,
          ),
          Text(
            'العنوان',
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
            hint: 'ادخل عنوان مناسب',
            keyboardType: TextInputType.number,
            controller: _titleController,
          ),
          SizedBox(
            height: 25.h,
          ),
          Text(
            'الوصف',
            style: GoogleFonts.poppins(
              color: mainFontColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          TextField(
            keyboardType: TextInputType.multiline,
            style: GoogleFonts.poppins(),
            controller: _contentController,
            minLines: 10,
            maxLines: 15,
            decoration: InputDecoration(
              hintMaxLines: 1,
              suffixIconColor: mainColor,
              hintText: 'اكتب وصفا دقيقا',
              hintStyle: GoogleFonts.poppins(
                color: secondFontColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xFFE1E1EF)),
                borderRadius: BorderRadius.circular(8.r),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xFFE1E1EF)),
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: MainButton(
          text: 'ارسال الطلب',
          onPressed: () => _performSubmit(),
        ),
      ),
    );
  }

  _performSubmit() {
    if (_checkData()) {
      _submit();
    }
  }

  bool _checkData() {
    if (_titleController.text.isNotEmpty &&
        _contentController.text.isNotEmpty) {
      return true;
    } else {
      context.showSnackBar(message: 'Enter required data', error: true);
      return false;
    }
  }

  _submit() async {
    FbResponse fbResponse = await complaintGetxController.addComplaint(
      complaint: complaint,
    );

    if (fbResponse.success) {
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, '/success_screen');
    }
    // ignore: use_build_context_synchronously
    context.showSnackBar(
      message: fbResponse.message,
      error: !fbResponse.success,
    );
  }

  ComplaintModel get complaint {
    ComplaintModel complaint = ComplaintModel();
    complaint.userId = userGetxController.currentUser.value.id!;
    complaint.title = _titleController.text;
    complaint.content = _contentController.text;
    complaint.isComplaint = currentStatus == 0 ? true : false;

    return complaint;
  }
}

Widget mainCard({name, index}) {
  return Container(
    width: 180.w,
    height: 50.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: currentStatus == index ? mainColor : Colors.white,
    ),
    padding: const EdgeInsets.all(15),
    child: Center(
      child: Text(
        name,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: currentStatus == index ? Colors.white : Colors.black,
        ),
      ),
    ),
  );
}
