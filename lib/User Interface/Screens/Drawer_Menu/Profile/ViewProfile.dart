// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:early_shuttle/Constant/SharedPreference.dart';
import 'package:early_shuttle/Constant/assets.dart';
import 'package:early_shuttle/Models/Profile_Model/ViewProfile_Model.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Buttons/PrimaryButton.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/ConstScreens/loadingScreen.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Container/Container_widget.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Custom%20Shape/CustomShape.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Text%20Field/TextField_widget.dart';
import 'package:early_shuttle/User%20Interface/Screens/Drawer_Menu/Profile/EditProfile.dart';
import 'package:early_shuttle/Utils/message_utils.dart';
import 'package:flutter/material.dart';
import '../../../../../Constant/color.dart';
import '../../../../main.dart';
import '../../../Constant Widgets/TextStyling/AppBarTitle.dart';
import '../../../Constant Widgets/TextStyling/subtitleStyle.dart';
import '../../../Constant Widgets/TextStyling/titleStyle.dart';

class viewProfile extends StatefulWidget {
 final  UserData? ProfileData;
   const viewProfile({Key? key, required this.ProfileData}) : super(key: key);

  @override
  State<viewProfile> createState() => _viewProfileState();
}

class _viewProfileState extends State<viewProfile> {
  final TextEditingController _name = TextEditingController();
  TextEditingController DOB = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  final TextEditingController _homeAddress = TextEditingController();
  final TextEditingController _officeAddress = TextEditingController();
  final TextEditingController _corporateEmail = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _complanyName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController corporateEmail = TextEditingController();

  @override
  void initState() {
    GotData();
    super.initState();
    // SharedPreferencesUtil.clearCorporateProfile();
  }

  GotData(){
    setState(() {
      if(widget.ProfileData != null){
        if(widget.ProfileData!.corporateEmail.toString()=="null" || widget.ProfileData!.corporateEmail.toString()==""){
          SharedPreferencesUtil.setCorporateProfile(false);
        }
        else{
          SharedPreferencesUtil.setCorporateProfile(true);
        }
        _name.text= widget.ProfileData!.name.toString()=="null" || widget.ProfileData!.name ==""?"Name":widget.ProfileData!.name.toString();
        DOB.text = widget.ProfileData!.dob.toString()=="null"?"Date of Birth":widget.ProfileData!.dob.toString();
        _gender.text = widget.ProfileData!.gender.toString()=="null"?"Gender":widget.ProfileData!.gender.toString();
        _homeAddress.text = widget.ProfileData!.homeAddress.toString()=="null"?"Home Address":widget.ProfileData!.homeAddress.toString();
        _officeAddress.text= widget.ProfileData!.officeAddress.toString()=="null"?"Office Address":widget.ProfileData!.officeAddress.toString();
        _corporateEmail.text= widget.ProfileData!.corporateEmail.toString()=="null" || widget.ProfileData!.corporateEmail ==""?"Corporate Email":widget.ProfileData!.corporateEmail.toString();
        _phoneNumber.text = widget.ProfileData!.phone.toString()=="null"?"Phone":widget.ProfileData!.phone.toString();
        _complanyName.text =widget.ProfileData!.companyName.toString()=="null"?"Company Name":widget.ProfileData!.companyName.toString();
        _email.text =widget.ProfileData!.email.toString()=="null"?"Email":widget.ProfileData!.email.toString();
        corporateEmail.text =widget.ProfileData!.corporateEmail.toString()=="null"?"Email":widget.ProfileData!.corporateEmail.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isSelected = SharedPreferencesUtil.checkCorporateProfile();
    final heights = MediaQuery.of(context).size.height;
    final widths = MediaQuery.of(context).size.width;
    return widget.ProfileData != null?
    Scaffold(
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
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                CustomContainer(
                  height: heights/4,
                  child: ClipPath(
                    clipper: CustomShapeprofile(),
                    child: CustomContainer(
                      gradient: LinearGradient(
                        tileMode: TileMode.mirror,
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          ColorConstant.gradientLightblue,
                          ColorConstant.primaryColor.withOpacity(0.5),
                        ],
                      ),
                      color: ColorConstant.primaryColor,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ),
                Positioned(
                  top: heights/9.5,
                  child: const CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage("assets/male3.png"),
                  ),
                ),
                Positioned(
                  left: 10, top: 35,
                    child: CustomContainer(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      borderRadius: BorderRadius.circular(50),
                      width: 50,
                      height: 40,
                      // color: Colors.black.withOpacity(0.5),
                      child: Icon(Icons.arrow_back_ios, size: 25,color: ColorConstant.whiteColor,)
                    )),
                Positioned(
                  top: 40,
                  child: CustomContainer(
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(0, 2),
                          color:
                          ColorConstant.darkBlackColor.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 3)
                    ],
                    border:
                    Border.all(color: ColorConstant.greyColor, width: 1),
                    borderRadius: BorderRadius.circular(12),
                    padding: const EdgeInsets.only(left: 8, right: 0),
                    width: widths / 1.7,
                    height: 35,
                    color: isSelected == false
                        ? ColorConstant.gradientLightblue
                        : ColorConstant.primaryColor,
                    child: Row(
                      children: [
                        TitleStyle(
                          Title: "Corporate Profile",
                          textColor: ColorConstant.darkBlackColor,
                        ),
                        Transform.scale(
                          alignment: FractionalOffset.centerRight,
                          scale: 0.6,
                          child: Switch(
                              value: isSelected,
                              onChanged: (bool v) {
                                setState(() {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return confirmCorporateProfile(
                                            context, v);
                                      });
                                });
                              }),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            CustomContainer(
              margin:const EdgeInsets.only(left: 10, right: 10, top: 5),
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 15, right: 15, top: 12),
              height: heights/1.4,
              child:SingleChildScrollView(
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextField(
                      controller: _name,
                      enabled: false,
                      borderRadius: BorderRadius.circular(10),
                      fieldRadius: BorderRadius.circular(10),
                      fillColor:ColorConstant.whiteColor,
                      border: Border.all(width: 1, color: ColorConstant.greyColor),
                      prefix: const Icon(Icons.person),
                      label:"Name",
                    ),
                    const SizedBox(height: 8,),
                    CustomTextField(
                      controller: DOB,
                      enabled: false,
                      borderRadius: BorderRadius.circular(10),
                      fieldRadius: BorderRadius.circular(10),
                      fillColor:ColorConstant.whiteColor,
                      border: Border.all(width: 1, color: ColorConstant.greyColor),
                      prefix: const Icon(Icons.calendar_month),
                      label:"Date of Birth",
                    ),
                    const SizedBox(height: 5,),
                    CustomTextField(
                      controller: _email,
                      enabled: false,
                      borderRadius: BorderRadius.circular(10),
                      fieldRadius: BorderRadius.circular(10),
                      fillColor:ColorConstant.whiteColor,
                      border: Border.all(width: 1, color: ColorConstant.greyColor),
                      prefix: const Icon(Icons.email),
                      label: "Email",
                    ),
                    const SizedBox(height: 5,),
                    CustomTextField(
                      controller: _gender,
                      enabled: false,
                      borderRadius: BorderRadius.circular(10),
                      fieldRadius: BorderRadius.circular(10),
                      fillColor:ColorConstant.whiteColor,
                      border: Border.all(width: 1, color: ColorConstant.greyColor),
                      prefix: const Padding(
                        padding: EdgeInsets.only(top: 10,bottom: 10),
                        child: ImageIcon(AssetImage(Graphics.genderIcon,),size: 5,),
                      ),
                      label:"Gender",
                    ),
                    const SizedBox(height: 5,),
                    CustomTextField(
                      controller: _homeAddress,
                      enabled: false,
                      borderRadius: BorderRadius.circular(10),
                      fieldRadius: BorderRadius.circular(10),
                      fillColor:ColorConstant.whiteColor,
                      border: Border.all(width: 1, color: ColorConstant.greyColor),
                      prefix: const Icon(Icons.home),
                      label: "Home Address",
                    ),
                    isSelected==true? const SizedBox(height: 5,):const SizedBox(),
                    isSelected==true? CustomTextField(
                      controller: _officeAddress,
                      enabled: false,
                      borderRadius: BorderRadius.circular(10),
                      fieldRadius: BorderRadius.circular(10),
                      fillColor:ColorConstant.whiteColor,
                      border: Border.all(width: 1, color: ColorConstant.greyColor),
                      prefix: const Icon(Icons.location_city_rounded),
                      label:"Office Address",
                    ):const SizedBox(),
                    isSelected==true? const SizedBox(height: 5,):const SizedBox(),
                    isSelected==true? CustomTextField(
                      controller: _corporateEmail,
                      enabled: false,
                      borderRadius: BorderRadius.circular(10),
                      fieldRadius: BorderRadius.circular(10),
                      fillColor:ColorConstant.whiteColor,
                      border: Border.all(width: 1, color: ColorConstant.greyColor),
                      prefix: const Icon(Icons.email),
                      label: "Corporate Email",
                    ):const SizedBox(),
                    const SizedBox(height: 5,),
                    CustomTextField(
                      controller: _phoneNumber,
                      enabled: false,
                      borderRadius: BorderRadius.circular(10),
                      fieldRadius: BorderRadius.circular(10),
                      fillColor:ColorConstant.whiteColor,
                      border: Border.all(width: 1, color: ColorConstant.greyColor),
                      prefix: const Icon(Icons.phone),
                      label: "Phone",
                    ),
                    isSelected==true?const SizedBox(height: 5,):const SizedBox(),
                    isSelected==true? CustomTextField(
                      controller: _complanyName,
                      enabled: false,
                      borderRadius: BorderRadius.circular(10),
                      fieldRadius: BorderRadius.circular(10),
                      fillColor:ColorConstant.whiteColor,
                      border: Border.all(width: 1, color: ColorConstant.greyColor),
                      prefix: const Icon(Icons.drive_file_rename_outline),
                      label: "Company Name",
                    ):const SizedBox(),
                    const SizedBox(height: 15,),
                    PrimaryButton(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> editProfile(ProfileData:widget.ProfileData)));
                      },
                      fontSize: 20,
                      Label: "Edit Profile",
                      textColor: ColorConstant.whiteColor,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ):const LoadingData();
  }

  Widget confirmCorporateProfile(BuildContext context, bool v) {
    return Dialog(
        child: CustomContainer(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TitleStyle(
                textColor: ColorConstant.darkBlackColor,
                textAlign: TextAlign.center,
                Title: v == true
                    ? "Are you sure you want to enable the corporate profile?"
                    : "Are you sure you want to disable the corporate profile.",
              ),
              const SizedBox(
                height: 10,
              ),
              SubTitle_Text(
                textAlign: TextAlign.center,
                Title:"Note - To enable corporate email, verify your corporate email address"
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PrimaryButton(
                    width: width / 4,
                    color: Colors.red,
                    Label: "No",
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  PrimaryButton(
                    width: width / 4,
                    color: ColorConstant.primaryColor,
                    Label: "Yes",
                    onTap: () {
                      setState(() {
                        SharedPreferencesUtil.setCorporateProfile(v);
                        if (v == true) {
                          Navigator.of(context).pop();
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> editProfile(ProfileData:widget.ProfileData)));
                          Utils.toastMessage("Corporate profile enabled");
                        } else {
                          Navigator.of(context).pop();
                          Utils.errorToastMessage("Corporate profile disabled");
                        }
                      });
                    },
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
