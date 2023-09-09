// ignore_for_file: non_constant_identifier_names, camel_case_types, prefer_typing_uninitialized_variables, file_names

import 'dart:io';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Buttons/PrimaryButton.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Container/Container_widget.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Custom%20Shape/CustomShape.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Text%20Field/TextField_widget.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/subtitleStyle.dart';
import 'package:early_shuttle/User%20Interface/Screens/Drawer_Menu/Profile/Map_For_Address.dart';
import 'package:early_shuttle/Utils/message_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../../../Constant/color.dart';
import '../../../../API/Auth/SendEmailVerificationCode.dart';
import '../../../../API/Profile_Section/EditProfile_Api.dart';
import '../../../../Constant/SharedPreference.dart';
import '../../../../Constant/assets.dart';
import '../../../../Models/Profile_Model/ViewProfile_Model.dart';
import '../../../Constant Widgets/Calender/Calender.dart';
import '../../../Constant Widgets/TextStyling/smallTextStyle.dart';

class editProfile extends StatefulWidget {
  final UserData? ProfileData;
  const editProfile({Key? key, this.ProfileData}) : super(key: key);

  @override
  State<editProfile> createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  TextEditingController Name = TextEditingController();
  TextEditingController DateOfBirth = TextEditingController();
  TextEditingController homeAddress = TextEditingController();
  TextEditingController officeAddress = TextEditingController();
  TextEditingController corporateEmail = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController companyName = TextEditingController();
  TextEditingController email = TextEditingController();

// Calender for DOB select...............
  DateTime selectedDate = DateTime.now();
  var formattedDate;
  void _handleDateSelected(DateTime date) {
    setState(() {
      selectedDate = date;
      formattedDate = DateFormat("dd/MM/yyyy").format(selectedDate);
      DateOfBirth.text = formattedDate;
    });
  }

  // Image picker for profile........
  File? _image;
  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        if (kDebugMode) {
          print('No image selected.');
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  String? selectedGender;
  List<String> genders = [
    'Male',
    'Female',
  ];

  @override
  Widget build(BuildContext context) {
    bool isCorporateEnabled = SharedPreferencesUtil.checkCorporateProfile();
    final heights = MediaQuery.of(context).size.height;
    final widths = MediaQuery.of(context).size.width;
    return Scaffold(
      body: CustomContainer(
        gradient: LinearGradient(
          tileMode: TileMode.mirror,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            ColorConstant.gradientLightGreen,
            ColorConstant.gradientLightblue
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  CustomContainer(
                    height: heights / 4,
                    child: ClipPath(
                      clipper: CustomShapeprofile(),
                      child: CustomContainer(
                        color: ColorConstant.primaryColor,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ),
                  Positioned(
                    top: heights / 11,
                    child: const CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage("assets/male3.png"),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 15,
                    child: CustomContainer(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        borderRadius: BorderRadius.circular(50),
                        width: 40,
                        height: 35,
                        // color: Colors.black.withOpacity(0.3),
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 25,
                          color: ColorConstant.whiteColor,
                        )),
                  ),
                ],
              ),
              CustomContainer(
                margin: const EdgeInsets.only(left: 10, right: 10, top: 0),
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                height: heights / 1.4,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomTextField(
                          controller: Name,
                          borderRadius: BorderRadius.circular(10),
                          fieldRadius: BorderRadius.circular(10),
                          fillColor: ColorConstant.whiteColor,
                          hintColor: widget.ProfileData!.name
                              .toString() ==
                              "null" || widget.ProfileData!.name
                              .toString() ==
                              ""
                              ?ColorConstant.greyColor :ColorConstant.darkBlackColor,
                          border: Border.all(
                              width: 1, color: ColorConstant.greyColor),
                          prefix: const Icon(Icons.person),
                          label: widget.ProfileData!.name.toString() == "null"
                              ||  widget.ProfileData!.name
                                  .toString() ==
                                  ""
                              ? "Name"
                              : widget.ProfileData!.name.toString()),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomTextField(
                        controller: DateOfBirth,
                        borderRadius: BorderRadius.circular(10),
                        fieldRadius: BorderRadius.circular(10),
                        fillColor: ColorConstant.whiteColor,
                        hintColor: widget.ProfileData!.dob
                            .toString() ==
                            "null" || widget.ProfileData!.dob
                            .toString() ==
                            ""
                            ?ColorConstant.greyColor :ColorConstant.darkBlackColor,
                        border: Border.all(
                            width: 1, color: ColorConstant.greyColor),
                        prefix: DatePickerWidget(
                          initialDate: selectedDate,
                          onDateSelected: _handleDateSelected,
                        ),
                        label: widget.ProfileData!.dob.toString() == "null" || widget.ProfileData!.dob==''
                            ? "Date of Birth"
                            : widget.ProfileData!.dob.toString(),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                     email.text.isNotEmpty? isEmailValid ?
                      SizedBox():
                      Small_Text(
                        textColor: Colors.red,
                        Title:'Enter a valid email' ,
                      ):SizedBox(),
                      CustomTextField(
                        controller: email,
                        borderRadius: BorderRadius.circular(10),
                        fieldRadius: BorderRadius.circular(10),
                        fillColor: ColorConstant.whiteColor,
                        hintColor:widget.ProfileData!.email
                            .toString() ==
                            "null" || widget.ProfileData!.email
                            .toString() ==
                            ""
                            ?ColorConstant.greyColor :ColorConstant.darkBlackColor,
                        border: Border.all(
                            width: 1, color: ColorConstant.greyColor),
                        prefix: const Icon(Icons.email),
                        label: widget.ProfileData!.email.toString() == "null"
                            ||  widget.ProfileData!.email
                                .toString() ==
                                ""
                            ? "Email"
                            : widget.ProfileData!.email.toString(),
                        onChanged: (v){
                          validateEmail(email);
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomContainer(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorConstant.whiteColor,
                        border: Border.all(
                            width: 1, color: ColorConstant.greyColor),
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            const ImageIcon(
                              AssetImage(Graphics.genderIcon),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            DropdownButton<String>(
                              underline: const SizedBox(),
                              value: selectedGender,
                              hint: SubTitle_Text(
                                alignment: Alignment.centerLeft,
                                width: widths / 1.6,
                                Title: widget.ProfileData!.gender.toString() == "null" || widget.ProfileData!.gender==''
                                    ? "Select Gender"
                                    : widget.ProfileData!.gender,
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedGender = newValue!;
                                });
                              },
                              items: genders.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomTextField(
                        controller: homeAddress,
                        borderRadius: BorderRadius.circular(10),
                        fieldRadius: BorderRadius.circular(10),
                        fillColor: ColorConstant.whiteColor,
                        hintColor:widget.ProfileData!.homeAddress
                            .toString() ==
                            "null" || widget.ProfileData!.homeAddress
                            .toString() ==
                            ""
                            ?ColorConstant.greyColor :ColorConstant.darkBlackColor,
                        border: Border.all(
                            width: 1, color: ColorConstant.greyColor),
                        prefix: const Icon(Icons.home),
                        label:
                            widget.ProfileData!.homeAddress.toString() == "null"
                                ||  widget.ProfileData!.homeAddress
                                .toString() ==
                                ""
                                ? "Home Address"
                                : widget.ProfileData!.homeAddress.toString(),
                        sufix: CustomContainer(
                          onTap: () {
                            _selectLocation('home');
                          },
                          width: widths / 12,
                          child: const Icon(Icons.location_on_outlined),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      corporateEmail.text.isNotEmpty? isCorporateEmailValid ?
                      SizedBox():
                      Small_Text(
                        textColor: Colors.red,
                        Title:'Enter a valid corporate email' ,
                      ):SizedBox(),
                      isCorporateEnabled == true
                          ? CustomTextField(
                              controller: corporateEmail,
                              borderRadius: BorderRadius.circular(10),
                              fieldRadius: BorderRadius.circular(10),
                              fillColor: ColorConstant.whiteColor,
                        onChanged: (c){
                          validateEmail(corporateEmail);
                        },
                        hintColor: widget.ProfileData!.corporateEmail
                            .toString() ==
                            "null" || widget.ProfileData!.corporateEmail
                            .toString() ==
                            ""
                            ?ColorConstant.greyColor :ColorConstant.darkBlackColor,
                              border: Border.all(
                                  width: 1, color: ColorConstant.greyColor),
                              prefix: const Icon(Icons.email),
                              label: widget.ProfileData!.corporateEmail
                                          .toString() ==
                                      "null" ||  widget.ProfileData!.corporateEmail
                                  .toString() ==
                                  ""
                                  ? "Corporate Email"
                                  : widget.ProfileData!.corporateEmail
                                      .toString(),
                              sufix: PrimaryButton(
                                onTap: () {
                                  print(widget.ProfileData!.corporateEmail);
                                  if (corporateEmail.text.isNotEmpty && isCorporateEmailValid) {
                                    SendCorporateEmailVerificationCode(
                                        context, corporateEmail.text);
                                  } else {
                                    Utils.flushBarErrorMessage(
                                        "Valid corporate email is required",
                                        context);
                                  }
                                },
                                borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(9),
                                  topRight: Radius.circular(9),
                                ),
                                inCol: true,
                                width: widths / 7,
                                color: corporateEmail.text.isNotEmpty && isCorporateEmailValid
                                    ? Colors.green
                                    : ColorConstant.greyColor,
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.check,
                                      color: ColorConstant.whiteColor,
                                    ),
                                    Small_Text(
                                      textColor: ColorConstant.whiteColor,
                                      Title: "Verify",
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox(),
                      const SizedBox(
                        height: 8,
                      ),
                      isCorporateEnabled == true
                          ? CustomTextField(
                        controller: officeAddress,
                        borderRadius: BorderRadius.circular(10),
                        fieldRadius: BorderRadius.circular(10),
                        fillColor: ColorConstant.whiteColor,
                        hintColor: widget.ProfileData!.officeAddress
                            .toString() ==
                            "null" || widget.ProfileData!.officeAddress
                            .toString() ==
                            ""
                            ?ColorConstant.greyColor :ColorConstant.darkBlackColor,
                        border: Border.all(
                            width: 1, color: ColorConstant.greyColor),
                        prefix: const Icon(Icons.location_city_rounded),
                        label: widget.ProfileData!.officeAddress
                            .toString() ==
                            "null" ||  widget.ProfileData!.officeAddress
                            .toString() ==
                            ""
                            ? "Office Address"
                            : widget.ProfileData!.officeAddress
                            .toString(),
                        sufix: CustomContainer(
                          onTap: () {
                            _selectLocation('office');
                          },
                          width: widths / 12,
                          child: const Icon(Icons.location_on_outlined),
                        ),
                      )
                          : const SizedBox(),
                      const SizedBox(
                        height: 8,
                      ),
                      isCorporateEnabled == true
                          ? CustomTextField(
                              controller: companyName,
                              borderRadius: BorderRadius.circular(10),
                              fieldRadius: BorderRadius.circular(10),
                              fillColor: ColorConstant.whiteColor,
                        hintColor:widget.ProfileData!.companyName
                            .toString() ==
                            "null" || widget.ProfileData!.companyName
                            .toString() ==
                            ""
                            ?ColorConstant.greyColor :ColorConstant.darkBlackColor,
                              border: Border.all(
                                  width: 1, color: ColorConstant.greyColor
                              ),
                              prefix:
                                  const Icon(Icons.drive_file_rename_outline),
                              label: widget.ProfileData!.companyName
                                          .toString() ==
                                      "null" || widget.ProfileData!.companyName
                                  .toString() ==
                                  ""
                                  ? "Company Name"
                                  : widget.ProfileData!.companyName.toString(),
                            )
                          : const SizedBox(),
                      const SizedBox(
                        height: 20,
                      ),
                      PrimaryButton(
                        // onTap: () {
                        //   UpdateProfile(
                        //       context,
                        //       Name.text.isEmpty? widget.ProfileData!.name:Name.text,
                        //       widget.ProfileData!.phone,
                        //       email.text.isEmpty? widget.ProfileData!.email:email.text,
                        //       DateOfBirth.text.isEmpty?widget.ProfileData!.dob!:DateOfBirth.text,
                        //       selectedGender.toString(),
                        //       homeAddress.text.isEmpty? widget.ProfileData!.homeAddress!:homeAddress.text,
                        //       officeAddress.text.isEmpty? widget.ProfileData!.officeAddress!:officeAddress.text,
                        //       corporateEmail.text.isEmpty? widget.ProfileData!.corporateEmail!:corporateEmail.text,
                        //       companyName.text.isEmpty? widget.ProfileData!.companyName!:companyName.text
                        //   );
                        // },
                        onTap: () {
                          if (email.text.isNotEmpty) {
                            isEmailValid
                                ? UpdateProfile(
                                context,
                                Name.text.isEmpty
                                    ? widget.ProfileData!.name
                                    : Name.text,
                                widget.ProfileData!.phone,
                                email.text.isEmpty
                                    ? widget.ProfileData!.email
                                    : email.text,
                                DateOfBirth.text.isEmpty
                                    ? widget.ProfileData!.dob!
                                    : DateOfBirth.text,
                                selectedGender.toString(),
                                homeAddress.text.isEmpty
                                    ? widget.ProfileData!.homeAddress!
                                    : homeAddress.text,
                                officeAddress.text.isEmpty
                                    ? widget.ProfileData!.officeAddress!
                                    : officeAddress.text,
                                corporateEmail.text.isEmpty
                                    ? widget.ProfileData!.corporateEmail!
                                    : corporateEmail.text,
                                companyName.text.isEmpty
                                    ? widget.ProfileData!.companyName!
                                    : companyName.text):Utils.flushBarErrorMessage(
                                "Enter a valid email", context);
                          }
                          if (corporateEmail.text.isNotEmpty) {
                            isCorporateEmailValid
                                ?UpdateProfile(
                                context,
                                Name.text.isEmpty
                                    ? widget.ProfileData!.name
                                    : Name.text,
                                widget.ProfileData!.phone,
                                email.text.isEmpty
                                    ? widget.ProfileData!.email
                                    : email.text,
                                DateOfBirth.text.isEmpty
                                    ? widget.ProfileData!.dob!
                                    : DateOfBirth.text,
                                selectedGender.toString(),
                                homeAddress.text.isEmpty
                                    ? widget.ProfileData!.homeAddress!
                                    : homeAddress.text,
                                officeAddress.text.isEmpty
                                    ? widget.ProfileData!.officeAddress!
                                    : officeAddress.text,
                                corporateEmail.text.isEmpty
                                    ? widget.ProfileData!.corporateEmail!
                                    : corporateEmail.text,
                                companyName.text.isEmpty
                                    ? widget.ProfileData!.companyName!
                                    : companyName.text):
                            Utils.flushBarErrorMessage(
                                "Enter a valid corporate email", context);
                          }
                          else{
                            UpdateProfile(
                                context,
                                Name.text.isEmpty
                                    ? widget.ProfileData!.name
                                    : Name.text,
                                widget.ProfileData!.phone,
                                email.text.isEmpty
                                    ? widget.ProfileData!.email
                                    : email.text,
                                DateOfBirth.text.isEmpty
                                    ? widget.ProfileData!.dob!
                                    : DateOfBirth.text,
                                selectedGender.toString(),
                                homeAddress.text.isEmpty
                                    ? widget.ProfileData!.homeAddress!
                                    : homeAddress.text,
                                officeAddress.text.isEmpty
                                    ? widget.ProfileData!.officeAddress!
                                    : officeAddress.text,
                                corporateEmail.text.isEmpty
                                    ? widget.ProfileData!.corporateEmail!
                                    : corporateEmail.text,
                                companyName.text.isEmpty
                                    ? widget.ProfileData!.companyName!
                                    : companyName.text);
                          }
                        },
                        borderRadius: BorderRadius.circular(5),
                        fontSize: 20,
                        Label: "Save Changes",
                        textColor: ColorConstant.whiteColor,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // manage with no fileds are filled.....




  // open map for select the address ................
  void _selectLocation(String locationType) async {
    final selectedLocation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchAddress(locationType: locationType),
      ),
    );

    if (selectedLocation != null && selectedLocation is Map<String, dynamic>) {
      if (locationType == 'home') {
        setState(() {
          homeAddress.text = selectedLocation['locationName'];
        });
      } else if (locationType == 'office') {
        setState(() {
          officeAddress.text = selectedLocation['locationName'];
        });
      }
    }
  }

  // widget for open bottom modal sheet to select image picking option.
  Widget choose(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SubTitle_Text(
              padding: const EdgeInsets.only(left: 15),
              Title: "Choose Option",
            ),
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.cancel_outlined,
                  color: Colors.red,
                ))
          ],
        ),
        ListTile(
          leading: Icon(
            Icons.camera_alt,
            color: ColorConstant.greyColor,
            size: 30,
          ),
          title: SubTitle_Text(
              alignment: Alignment.centerLeft, Title: 'Open Camera'),
          subtitle: Small_Text(
            alignment: Alignment.centerLeft,
            Title: "Open Camera to click Image now",
          ),
          onTap: () {
            _getImage(ImageSource.camera);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.photo_camera_back,
            color: ColorConstant.greyColor,
          ),
          title: SubTitle_Text(
              alignment: Alignment.centerLeft, Title: 'Open File'),
          subtitle: Small_Text(
            alignment: Alignment.centerLeft,
            Title: "Open Galary to choose from images",
          ),
          onTap: () {
            _getImage(ImageSource.gallery);
          },
        ),

        const SizedBox(
          height: 20,
        )
        // Add more options as needed
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<File?>('_image', _image));
    properties.add(DiagnosticsProperty<File?>('_image', _image));
  }


  // Email validation
  bool isEmailValid = true;
  bool isCorporateEmailValid = true;

  void validateEmail(TextEditingController emailController) {
    setState(() {
      isEmailValid = isValidEmail(emailController.text);
      isCorporateEmailValid = isValidEmail(emailController.text);

    });
    if (isEmailValid) {
      print('Email is valid: ${email.text}');
    } else {
      print('Enter valid email : ${email.text}');
    }
  }
  bool isValidEmail(String email) {
    RegExp emailRegex =
    RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }
}
