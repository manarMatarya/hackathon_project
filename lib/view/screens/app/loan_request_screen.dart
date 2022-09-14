import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon_project/get/transaction_getx_controller.dart';
import 'package:hackathon_project/get/user_getx_controller.dart';
import 'package:hackathon_project/models/fb_response.dart';
import 'package:hackathon_project/models/transaction.dart';
import 'package:hackathon_project/utils/colors.dart';
import 'package:hackathon_project/utils/context_extenssion.dart';
import 'package:hackathon_project/view/widgets/main_button.dart';
import 'package:hackathon_project/view/widgets/text_field.dart';
import 'package:intl/intl.dart';

class LoanScreen extends StatefulWidget {
  const LoanScreen({Key? key}) : super(key: key);

  @override
  State<LoanScreen> createState() => _LoanScreenState();
}

class _LoanScreenState extends State<LoanScreen> {
  final UserGetxController userGetxController = UserGetxController.to;
  TransactionGetxController transactionGetxController =
      Get.put(TransactionGetxController());

  late TextEditingController _valueController;
  late TextEditingController _reasonController;
  bool _obsecure = true;
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      userGetxController.getCurrentUser();
    });
    _valueController = TextEditingController();
    _reasonController = TextEditingController();
  }

  @override
  void dispose() {
    _valueController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'طلب قرض',
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
          Text(
            'القيمة المالية المطلوب اقتراضها',
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
            hint: 'ادخل القيمة المالية',
            keyboardType: TextInputType.number,
            controller: _valueController,
          ),
          SizedBox(
            height: 25.h,
          ),
          Text(
            'سبب القرض',
            style: GoogleFonts.cairo(
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
            style: GoogleFonts.cairo(),
            controller: _reasonController,
            minLines: 10,
            maxLines: 15,
            decoration: InputDecoration(
              hintMaxLines: 1,
              suffixIconColor: mainColor,
              hintText: 'السبب لتقديم طلب القرض',
              hintStyle: GoogleFonts.cairo(
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MainButton(
              text: 'ارسال الطلب',
              onPressed: () => _performSubmit(),
            ),
            SizedBox(
              height: 10.h,
            ),
            CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(
                  'بالنقر فوق زر ارسال الطلب ، فإنك توافق على الشروط والأحكام وسياسة الخصوصية الخاصة بنا',
                  style: GoogleFonts.cairo(
                    fontSize: 14.sp,
                    color: secondFontColor,
                  ),
                ),
                activeColor: mainColor,
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    isChecked = value!;
                  });
                }),
          ],
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
    if (_valueController.text.isNotEmpty &&
        _reasonController.text.isNotEmpty &&
        isChecked == true) {
      return true;
    } else {
      context.showSnackBar(message: 'Enter required data', error: true);
      return false;
    }
  }

  _submit() async {
    FbResponse fbResponse = await transactionGetxController.addTransaction(
      transaction: transaction,
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

  TransactionModel get transaction {
    TransactionModel transaction = TransactionModel();
    transaction.userId = userGetxController.currentUser.value.id!;
    transaction.transactionName = 'قرض';
    transaction.reason = _reasonController.text;
    transaction.value1 = double.parse(_valueController.text);
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    transaction.startDate = formattedDate;
    transaction.status = 'انتظار';
    transaction.userBranch = userGetxController.currentUser.value.branchId!;

    return transaction;
  }
}
