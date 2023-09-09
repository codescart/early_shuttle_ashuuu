// ignore_for_file: non_constant_identifier_names

import 'package:early_shuttle/API/SafetyZone/ViewContacts_Api.dart';
import 'package:early_shuttle/Constant/color.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Buttons/PrimaryButton.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Container/Container_widget.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Other_Features/OpenDialer.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/AppBarTitle.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/subtitleStyle.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/titleStyle.dart';
import 'package:early_shuttle/User%20Interface/Screens/Drawer_Menu/Safety/AddEmergencyContact.dart';
import 'package:early_shuttle/User%20Interface/Screens/Drawer_Menu/Safety/EditEmergencyContact_PopUp.dart';
import 'package:early_shuttle/Utils/message_utils.dart';
import 'package:flutter/material.dart';
import '../../../../Constant/global_call.dart';

class SafetyZone extends StatefulWidget {
  const SafetyZone({Key? key}) : super(key: key);

  @override
  State<SafetyZone> createState() => _SafetyZoneState();
}

class _SafetyZoneState extends State<SafetyZone> {
  @override
  void initState() {
    super.initState();
    GotData();
  }

  GotData() async {
    final data = await fetchEmergencyContactViewData();
    setState(() {
      GlobalCallClass.EmergencyContactData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    final widths = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.primaryColor,
        leadingWidth: 50,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: ColorConstant.whiteColor,
          ),
        ),
        title: HeadingOne(
          Title: "Safety Zone",
          fontSize: 25,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            HeadingOne(
              fontSize: 25,
              textColor: ColorConstant.darkBlackColor,
              Title: "Promise to keep you safe",
            ),
            const SizedBox(
              height: 10,
            ),
            TitleStyle(
              textColor: ColorConstant.darkBlackColor,
              Title:
                  "These safety features ensure that your ride always stay worry-free",
            ),
            const SizedBox(
              height: 20,
            ),
            CustomContainer(
              margin: const EdgeInsets.only(bottom: 15),
              gradient: LinearGradient(
                tileMode: TileMode.mirror,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  ColorConstant.gradientLightGreen,
                  ColorConstant.gradientLightblue
                ],
              ),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 3),
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 2,
                    spreadRadius: 1)
              ],
              child: GlobalCallClass.EmergencyContactData == null
                  ? ExpansionTile(
                      initiallyExpanded: true,
                      tilePadding: const EdgeInsets.symmetric(horizontal: 5),
                      leading: Icon(
                        Icons.contact_emergency,
                        color: ColorConstant.blueColor,
                        size: 30,
                      ),
                      title: TitleStyle(
                        textColor: ColorConstant.darkBlackColor,
                        padding: const EdgeInsets.only(bottom: 3),
                        alignment: Alignment.centerLeft,
                        Title: "Emergency Contacts",
                      ),
                      children: [
                        ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          title: SubTitle_Text(
                            Title:
                                "Alert your family member or close friend in case of an emergency.",
                            padding: const EdgeInsets.only(bottom: 10),
                          ),
                          subtitle: PrimaryButton(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const AddEmergencyContact(
                                        isEnabled: false);
                                  });
                            },
                            color: Colors.grey,
                            fontSize: widths / 20,
                            width: widths / 1.15,
                            Label: "Not Enabled",
                          ),
                        ),
                      ],
                    )
                  : ExpansionTile(
                      initiallyExpanded: true,
                      tilePadding: const EdgeInsets.symmetric(horizontal: 5),
                      leading: const Icon(
                        Icons.person,
                        color: Colors.green,
                        size: 30,
                      ),
                      title: TitleStyle(
                        textColor: ColorConstant.darkBlackColor,
                        padding: const EdgeInsets.only(bottom: 3),
                        alignment: Alignment.centerLeft,
                        Title: "Emergency Contacts",
                      ),
                      children: [
                        ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          title: SubTitle_Text(
                            Title:
                                "Alert your family member or close friend in case of an emergency.",
                            padding: const EdgeInsets.only(bottom: 10),
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              PrimaryButton(
                                fontSize: widths / 20,
                                width: widths / 4,
                                gradient: const LinearGradient(
                                  tileMode: TileMode.mirror,
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Colors.lightGreen, Colors.green],
                                ),
                                Label: "Enabled",
                              ),
                              PrimaryButton(
                                onTap: () {
                                  if(GlobalCallClass.EmergencyContactData!.data.length<2){
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return const AddEmergencyContact(
                                            isEnabled: true,
                                          );
                                        });
                                  }
                                 else{
                                   Utils.flushBarErrorMessage("Maximum two contacts allowed", context);
                                  }
                                },
                                fontSize: widths / 20,
                                width: widths / 2,
                                gradient: const LinearGradient(
                                  tileMode: TileMode.mirror,
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Colors.blueAccent, Colors.blue],
                                ),
                                icon: Icons.add_call,
                                Label: "Add Contact",
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                        GlobalCallClass.EmergencyContactData!.status == 1
                            ? Column(
                                children: List.generate(
                                    GlobalCallClass.EmergencyContactData!.data
                                        .length, (index) {
                                  final ContactData = GlobalCallClass
                                      .EmergencyContactData!.data[index];
                                  return ListTile(
                                    contentPadding: const EdgeInsets.only(left: 10),
                                    leading: const Icon(
                                      Icons.account_box,
                                      size: 30,
                                    ),
                                    title: SubTitle_Text(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      alignment: Alignment.centerLeft,
                                      Title:
                                          "${ContactData.contactName.toUpperCase()}  (${ContactData.relationship})",
                                    ),
                                    subtitle: SubTitle_Text(
                                      alignment: Alignment.centerLeft,
                                      Title: ContactData.phone.toString(),
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            OpenDailerPad.openDialPad(ContactData.phone);
                                          },
                                          icon: Icon(
                                            Icons.call,
                                            color: ColorConstant.blueColor,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return EditEmergencyContactPopUp(
                                                      ContactData: ContactData);
                                                });
                                          },
                                          icon: const Icon(
                                            Icons.edit_note_outlined,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              )
                            : const SizedBox()
                      ],
                    ),
            ),
            CustomContainer(
              margin: const EdgeInsets.only(bottom: 15),
              gradient: LinearGradient(
                tileMode: TileMode.mirror,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  ColorConstant.gradientLightGreen,
                  ColorConstant.gradientLightblue
                ],
              ),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 3),
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 2,
                    spreadRadius: 1)
              ],
              child: ExpansionTile(
                initiallyExpanded: true,
                tilePadding: const EdgeInsets.symmetric(horizontal: 5),
                leading: Icon(
                  Icons.calendar_month,
                  color: ColorConstant.blueColor,
                  size: 30,
                ),
                title: TitleStyle(
                  textColor: ColorConstant.darkBlackColor,
                  padding: const EdgeInsets.only(bottom: 3),
                  alignment: Alignment.centerLeft,
                  Title: "Share Ride Details",
                ),
                children: [
                  ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    title: SubTitle_Text(
                      Title:
                          "Alert your family member or close friend in case of an emergency.",
                      padding: const EdgeInsets.only(bottom: 10),
                    ),
                    subtitle: PrimaryButton(
                      color: Colors.grey,
                      fontSize: widths / 20,
                      width: widths / 1.15,
                      Label: "Not Enabled",
                    ),
                  ),
                ],
              ),
            ),
            CustomContainer(
              margin: const EdgeInsets.only(bottom: 15),
              gradient: LinearGradient(
                tileMode: TileMode.mirror,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  ColorConstant.gradientLightGreen,
                  ColorConstant.gradientLightblue
                ],
              ),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 3),
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 2,
                    spreadRadius: 1)
              ],
              child: ExpansionTile(
                initiallyExpanded: true,
                tilePadding: const EdgeInsets.symmetric(horizontal: 5),
                leading: Icon(
                  Icons.location_city_rounded,
                  color: ColorConstant.blueColor,
                  size: 30,
                ),
                title: TitleStyle(
                  textColor: ColorConstant.darkBlackColor,
                  padding: const EdgeInsets.only(bottom: 3),
                  alignment: Alignment.centerLeft,
                  Title: "Home Check",
                ),
                children: [
                  ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    title: SubTitle_Text(
                      Title:
                          "Alert your family member or close friend in case of an emergency.",
                      padding: const EdgeInsets.only(bottom: 10),
                    ),
                    subtitle: PrimaryButton(
                      // onTap: () {
                      //   showDialog(
                      //       context: context,
                      //       builder: (BuildContext context) {
                      //         return AddEmergencyContact();
                      //       });
                      // },
                      color: Colors.grey,
                      fontSize: widths / 20,
                      width: widths / 1.15,
                      Label: "Not Enabled",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SafetyParams {
  final IconData icon;
  final String title;
  final String subtitle;

  SafetyParams(this.icon, this.title, this.subtitle);
}
