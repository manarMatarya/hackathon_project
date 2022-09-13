import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon_project/firebase/fb_auth_controller.dart';
import 'package:hackathon_project/models/fb_response.dart';
import 'package:hackathon_project/models/user.dart';
import 'package:hackathon_project/utils/colors.dart';
import 'package:hackathon_project/utils/context_extenssion.dart';
import 'package:hackathon_project/view/widgets/main_button.dart';
import 'package:hackathon_project/view/widgets/text_field.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController _idController;

  late TextEditingController _phoneController;
  late TextEditingController _passwordController;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _accountNumberController;
  late ImagePicker _imagePicker;

  bool _obsecure = true;
  String? _gender;
  String? _branch;
  File? _photo;

  List<String> genders = <String>['Male', 'Female'];
  List<String> branches = <String>['Gaza', 'Rafah', 'Khanyounis'];

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _idController = TextEditingController();
    _accountNumberController = TextEditingController();
    _imagePicker = ImagePicker();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _idController.dispose();
    _accountNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String countryCode = 'PS';
    String flag = countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'تسجيل جديد',
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_circle_right_sharp,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        children: [
          InkWell(
            onTap: () => _pickImage(),
            child: _photo == null
                ? Image.asset(
                    'images/addimage.png',
                    height: 90.h,
                  )
                : CircleAvatar(
                    radius: 45,
                    backgroundImage: FileImage(
                      File(_photo!.path),
                    ),
                  ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Text(
            'رقم الهوية ',
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
            hint: 'ادخل رقم الهوية',
            keyboardType: TextInputType.number,
            controller: _idController,
          ),
          SizedBox(
            height: 12.h,
          ),
          Text(
            'الاسم كاملا',
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
            hint: 'ادخل اسمك هنا',
            keyboardType: TextInputType.name,
            controller: _nameController,
          ),
          SizedBox(
            height: 12.h,
          ),
          Text(
            'البريد الالكتروني',
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
            hint: 'ادخل عنوان بريدك الالكتروني',
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
          ),
          SizedBox(
            height: 12.h,
          ),
          Text(
            'الجنس',
            style: GoogleFonts.poppins(
              color: mainFontColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          DropdownButtonFormField<String>(
              decoration: InputDecoration(
                constraints: BoxConstraints(minHeight: 60.h, maxHeight: 60.h),
                hintMaxLines: 1,
                hintText: 'الجنس',
                hintStyle: GoogleFonts.poppins(
                  color: const Color(0xFF8992A3),
                  fontSize: 16.sp,
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
              items: genders.map((String gender) {
                return DropdownMenuItem<String>(
                  value: gender,
                  child: Text(
                    gender,
                    style: const TextStyle(color: Colors.black),
                  ),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  _gender = value;
                });
              }),
          SizedBox(
            height: 12.h,
          ),
          Text(
            'رقم الجوال',
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
            hint: '598576933',
            suffixIcon: SizedBox(
              width: 100.w,
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Text(
                  '790',
                  style: GoogleFonts.poppins(
                    color: mainFontColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(flag),
                SizedBox(
                  width: 10.w,
                ),
              ]),
            ),
            keyboardType: TextInputType.number,
            controller: _phoneController,
          ),
          SizedBox(
            height: 12.h,
          ),
          Text(
            'كلمة المرور',
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
            hint: 'ادخل كلمة المرور',
            keyboardType: TextInputType.text,
            controller: _passwordController,
            lines: 1,
            obscureText: _obsecure,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _obsecure = !_obsecure;
                });
              },
              icon: Icon(_obsecure ? Icons.visibility : Icons.visibility_off),
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'الفرع المصرفي',
                      style: GoogleFonts.poppins(
                        color: mainFontColor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          constraints:
                              BoxConstraints(minHeight: 60.h, maxHeight: 60.h),
                          hintMaxLines: 1,
                          hintText: 'الفرع',
                          hintStyle: GoogleFonts.poppins(
                            color: const Color(0xFF8992A3),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xFFE1E1EF)),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xFFE1E1EF)),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        items: branches.map((String branch) {
                          return DropdownMenuItem<String>(
                            value: branch,
                            child: Text(
                              branch,
                              style: const TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            _branch = value;
                          });
                        }),
                  ],
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'رقم الحساب',
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
                      hint: 'ادخل رقم الحساب',
                      keyboardType: TextInputType.number,
                      controller: _accountNumberController,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 25.h,
          ),
          MainButton(
            text: 'انشاء الحساب',
            onPressed: () {
              _performRegister();
            },
          ),
          SizedBox(
            height: 12.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'لديك حساب بالفعل؟',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF6A6D7C),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/login_screen');
                },
                child: Text(
                  'سجل دخول الأن',
                  style: GoogleFonts.poppins(
                      color: mainColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                      decorationColor: mainColor),
                ),
              ),
            ],
          ),
          Divider(
            color: greyColor,
            height: 12.h,
          ),
        ],
      ),
    );
  }

  void _performRegister() async {
    if (_checkData()) {
      await _register();
    }
  }

  bool _checkData() {
    if (_nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty &&
        _idController.text.isNotEmpty &&
        _accountNumberController.text.isNotEmpty &&
        _gender != null &&
        _branch != null &&
        _photo != null &&
        _passwordController.text.isNotEmpty) {
      return true;
    }
    context.showSnackBar(message: 'Enter required data', error: true);
    return false;
  }

  _register() async {
    String imageUrl = await (uploadFile(_photo));
    FbResponse fbResponse =
        await FbAuthController().createAccount(user: user, image: imageUrl);

    if (fbResponse.success) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
    // ignore: use_build_context_synchronously
    return context.showSnackBar(
      message: fbResponse.message,
      error: !fbResponse.success,
    );
  }

  UserModel get user {
    UserModel user = UserModel();
    user.id = _idController.text;
    user.name = _nameController.text;
    user.email = _emailController.text;
    user.mobile = _phoneController.text;
    user.gender = _gender!;
    user.password = _passwordController.text;
    user.branchId = _branch!;
    user.accountNumber = _accountNumberController.text;

    return user;
  }

  void _pickImage() async {
    XFile? imageFile = await _imagePicker.pickImage(source: ImageSource.camera);
    if (imageFile != null) {
      setState(() {
        _photo = File(imageFile.path);
      });
    }
  }

  Future<String> uploadFile(File? image) async {
    Reference storageReference =
        FirebaseStorage.instance.ref('files/${image!.path}');
    UploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.then((p0) => null);

    return await storageReference.getDownloadURL();
  }

  // void uploadFiles() async {

  // }
}
