import 'package:early_shuttle/Constant/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeadingOne extends StatelessWidget {
  final String? Title;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? textColor;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry? alignment;
  final TextAlign? textAlign;
   HeadingOne({this.Title, this.fontSize, this.fontWeight, this.textColor, this.width, this.padding, this.alignment, this.textAlign}) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: width,
      alignment:alignment==null?Alignment.centerLeft:alignment,
      child: Text(
        Title==null?"":Title!,
        style: GoogleFonts.alike(
          textStyle: TextStyle(//MediaQuery.of(context).size.width/20//22
            fontSize: fontSize==null?22:fontSize,
            fontWeight:fontWeight==null?FontWeight.normal:fontWeight,
            fontStyle: FontStyle.normal,
              color: textColor==null?ColorConstant.whiteColor:textColor
          ),
        ),
        textAlign:textAlign,
      ),
    );
    //   Text(Title==null?"":Title!,
    //   style: TextStyle(
    //       fontSize:fontSize==null?20:fontSize,
    //       fontWeight:fontWeight==null?FontWeight.normal:fontWeight,
    //       color: textColor==null?ColorConstant.whiteColor:textColor ),
    // );
  }
}
