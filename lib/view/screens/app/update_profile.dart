import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon_project/firebase/fb_auth_controller.dart';
import 'package:hackathon_project/get/user_getx_controller.dart';
import 'package:hackathon_project/models/fb_response.dart';
import 'package:hackathon_project/models/user.dart';
import 'package:hackathon_project/utils/colors.dart';
import 'package:hackathon_project/utils/context_extenssion.dart';
import 'package:hackathon_project/view/widgets/main_button.dart';
import 'package:hackathon_project/view/widgets/text_field.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key, required this.userModel}) : super(key: key);
  final UserModel userModel;

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final UserGetxController _userGetxController = Get.put(UserGetxController());

  late TextEditingController _idController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _accountNumberController;
  late TextEditingController _bdController;
  late TextEditingController _nationalityController;
  late TextEditingController _addressController;
  late TextEditingController _cityController;
  late TextEditingController _statusController;
  late TextEditingController _educationController;

  late ImagePicker _imagePicker;

  bool _obsecure = true;
  String? _gender;
  String? _branch;
  File? _photo;
  bool isFree = true;

  List<String> genders = <String>['Male', 'Female'];
  List<String> branches = <String>['Gaza', 'Rafah', 'Khanyounis'];

  @override
  void initState() {
    //  _userGetxController.getCurrentUser();
    super.initState();
    _phoneController = TextEditingController(text: widget.userModel.mobile);
    _passwordController =
        TextEditingController(text: widget.userModel.password);
    _nameController = TextEditingController(text: widget.userModel.name);
    _emailController = TextEditingController(text: widget.userModel.email);
    _idController = TextEditingController(text: widget.userModel.id);
    _accountNumberController =
        TextEditingController(text: widget.userModel.accountNumber);
    _bdController = TextEditingController(text: widget.userModel.birthday);
    _nationalityController =
        TextEditingController(text: widget.userModel.nationality);
    _addressController = TextEditingController(text: widget.userModel.address);
    _cityController = TextEditingController(text: widget.userModel.city);
    _statusController = TextEditingController(text: widget.userModel.status);
    _educationController =
        TextEditingController(text: widget.userModel.education);
    _gender = widget.userModel.gender;
    _branch = widget.userModel.branchId;
    //_photo = File(widget.userModel.image!);
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
    _bdController.dispose();
    _nationalityController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _statusController.dispose();
    _educationController.dispose();
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
        centerTitle: true,
        title: const Text(
          'حسابي',
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_active_outlined,
                color: Colors.black,
              )),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        children: [
          InkWell(
            onTap: () => _pickImage(),
            child: isFree
                ? CircleAvatar(
                    radius: 45,
                    backgroundImage: NetworkImage(
                      widget.userModel.image!,
                    ))
                : CircleAvatar(
                    radius: 45,
                    backgroundImage: FileImage(
                      _photo!,
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
                hintText: _gender,
                hintStyle: GoogleFonts.poppins(
                  color: Colors.black,
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
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                    ),
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
                          hintText: _branch,
                          hintStyle: GoogleFonts.poppins(
                            color: Colors.black,
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
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                              ),
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
            height: 12.h,
          ),
          Text(
            'تاريخ الميلاد',
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
            hint: 'ادخل تاريخ ميلادك',
            keyboardType: TextInputType.name,
            controller: _bdController,
          ),
          SizedBox(
            height: 12.h,
          ),
          Text(
            'الجنسية',
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
            hint: 'ما جنسيتك',
            keyboardType: TextInputType.name,
            controller: _nationalityController,
          ),
          SizedBox(
            height: 12.h,
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
            hint: 'العنوان',
            keyboardType: TextInputType.name,
            controller: _addressController,
          ),
          SizedBox(
            height: 12.h,
          ),
          Text(
            'المدينة',
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
            hint: 'ادخل مدينتك',
            keyboardType: TextInputType.name,
            controller: _cityController,
          ),
          SizedBox(
            height: 12.h,
          ),
          Text(
            'الحالة الاجتماعية',
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
            hint: 'ما الحالة الاجتماعية',
            keyboardType: TextInputType.name,
            controller: _statusController,
          ),
          SizedBox(
            height: 12.h,
          ),
          Text(
            'المستوى التعليمي',
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
            hint: 'ما هو المستوى التعليمي',
            keyboardType: TextInputType.name,
            controller: _educationController,
          ),
          SizedBox(
            height: 25.h,
          ),
          MainButton(
            text: 'تحديث البيانات',
            onPressed: () {
              _update();
            },
          ),
        ],
      ),
    );
  }

  _update() async {
    late String imageUrl;
    if (_photo != null) {
      imageUrl = await (uploadFile(_photo));
    } else {
      imageUrl = widget.userModel.image!;
    }

    FbResponse fbResponse =
        await FbAuthController().saveUserData(user, image: imageUrl);

    if (fbResponse.success) {
      // ignore: use_build_context_synchronously
      _userGetxController.getCurrentUser();
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
    user.birthday = _bdController.text;
    user.nationality = _nationalityController.text;
    user.address = _addressController.text;
    user.city = _cityController.text;
    user.status = _statusController.text;
    user.education = _educationController.text;

    return user;
  }

  void _pickImage() async {
    XFile? imageFile = await _imagePicker.pickImage(source: ImageSource.camera);
    if (imageFile != null) {
      setState(() {
        _photo = File(imageFile.path);
        isFree = false;
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
}
