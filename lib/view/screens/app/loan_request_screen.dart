import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon_project/utils/colors.dart';
import 'package:hackathon_project/view/widgets/main_button.dart';
import 'package:hackathon_project/view/widgets/text_field.dart';

class LoanScreen extends StatefulWidget {
  const LoanScreen({Key? key}) : super(key: key);

  @override
  State<LoanScreen> createState() => _LoanScreenState();
}

class _LoanScreenState extends State<LoanScreen> {
  late TextEditingController _valueController;
  late TextEditingController _reasonController;
  bool _obsecure = true;
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
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
            hint: 'ادخل القيمة المالية',
            keyboardType: TextInputType.number,
            controller: _valueController,
          ),
          SizedBox(
            height: 25.h,
          ),
          Text(
            'سبب القرض',
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
            hint: 'السبب الذي تحتاج من اجله القرض',
            keyboardType: TextInputType.number,
            controller: _valueController,
            lines: 10,
          ),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 160.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          children: [
            MainButton(
              text: 'ارسال الطلب',
              onPressed: () {},
            ),
            SizedBox(
              height: 10.h,
            ),
            CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(
                  'بالنقر فوق زر ارسال الطلب ، فإنك توافق على الشروط والأحكام وسياسة الخصوصية الخاصة بنا',
                  style: GoogleFonts.poppins(
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
                })
          ],
        ),
      ),
    );
  }
}
