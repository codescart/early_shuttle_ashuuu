import 'package:early_shuttle/Constant/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleStyle extends StatelessWidget {
  final String? Title;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? textColor;
  final TextAlign? textAlign;
  final int? maxLines;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? width;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;

  TitleStyle({this.Title, this.fontSize, this.fontWeight, this.textColor, this.textAlign, this.maxLines, this.softWrap, this.overflow,  this.width, this.alignment, this.padding}) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: padding,
      alignment: alignment==null?Alignment.center:alignment,
      child: Text(
        maxLines: maxLines,
          overflow: overflow,
          softWrap: softWrap,
          textAlign:textAlign,
          Title==null?"":Title!,
          style: GoogleFonts.alike(
            textStyle: TextStyle(//18
                fontSize: fontSize==null?MediaQuery.of(context).size.width/21:fontSize,
                fontWeight:fontWeight==null?FontWeight.normal:fontWeight,
                fontStyle: FontStyle.normal,
                color: textColor==null?ColorConstant.whiteColor:textColor
            ),
          )),
    );
    //   Text(Title==null?"":Title!,
    //   style: TextStyle(
    //       fontSize:fontSize==null?20:fontSize,
    //       fontWeight:fontWeight==null?FontWeight.normal:fontWeight,
    //       color: textColor==null?ColorConstant.whiteColor:textColor ),
    // );
  }
}
