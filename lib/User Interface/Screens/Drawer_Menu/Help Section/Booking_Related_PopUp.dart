// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison

import 'package:early_shuttle/Constant/assets.dart';
import 'package:early_shuttle/Models/HelpSection_Model/TripRelated_Model.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Buttons/PrimaryButton.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/AppBarTitle.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/subtitleStyle.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/titleStyle.dart';
import 'package:flutter/material.dart';
import '../../../../API/Help_Section/SubmitTicket_Api.dart';
import '../../../../Constant/color.dart';
import '../../../../Utils/message_utils.dart';
import '../../../Constant Widgets/Container/Container_widget.dart';

class BookingRelatedPopUp extends StatefulWidget {
  final HelpDetail? TicketType;
  final String? ordId;
  final String? description;
  const BookingRelatedPopUp({
    Key? key,
    this.TicketType,
    this.ordId,
    this.description,
  }) : super(key: key);

  @override
  State<BookingRelatedPopUp> createState() => _BookingRelatedPopUpState();
}

class _BookingRelatedPopUpState extends State<BookingRelatedPopUp> {
  bool isIssueSubmited = false;
  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetAnimationCurve: Curves.easeIn,
        child: CustomContainer(
          padding: const EdgeInsets.all(0),
          borderRadius: BorderRadius.circular(8),
          color: isIssueSubmited == true
              ? Colors.white
              : const Color(0xfffaf7fe), //e2d6e4
          child: isIssueSubmited == false
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.cancel,
                            color: Colors.red,
                          )),
                    ),
                    TitleStyle(
                      textColor: ColorConstant.darkBlackColor,
                      textAlign: TextAlign.center,
                      Title: "Are you sure want to submit the selected issue.",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SubTitle_Text(
                      textColor: ColorConstant.blueColor,
                      textAlign: TextAlign.center,
                      Title:
                          "\"${widget.TicketType!.tktTypeDetailDescription}\"",
                    ),
                    PrimaryButton(
                      margin: const EdgeInsets.all(15),
                      onTap: () {
                        setState(() {
                          isIssueSubmited = true;
                        });
                        print(widget.ordId);
                        print(widget.TicketType!.tktTypeDetailDescription);
                        print(widget.description);
                        SubmitHelpTicket(
                                context,
                                widget.ordId == null ? "" : widget.ordId!,
                                widget.TicketType!.tktTypeDetailId == null
                                    ? ""
                                    : widget
                                        .TicketType!.tktTypeDetailId.toString(),
                                widget.description == null
                                    ? ""
                                    : widget.description!,
                        ""
                        )
                            .then((data) {
                          Utils.toastMessage("Ticket submitted successfully");
                          setState(() {
                            isIssueSubmited = true;
                          });
                        });
                      },
                      Label: "Submit",
                    ),
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    HeadingOne(
                      textColor: ColorConstant.darkBlackColor,
                      alignment: Alignment.center,
                      Title: "Thankyou",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Image(image: AssetImage(Graphics.sendImg)),
                    const SizedBox(
                      height: 10,
                    ),
                    SubTitle_Text(
                        textAlign: TextAlign.center,
                        Title:
                            "Ticket submitted successfully, we shall get back to you shortly."),
                    PrimaryButton(
                      margin: const EdgeInsets.all(15),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Help()));
                      },
                      Label: "Back to home",
                    )
                  ],
                ),
        ));
  }
}
