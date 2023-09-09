import 'package:early_shuttle/Constant/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrimaryButton extends StatelessWidget {
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Decoration? decoration;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final Color? gradientColorOne;
  final Color? gradientColorTwo;
  final Color? shadowColor;
  final double? dx;
  final double? dy;
  final Gradient? gradient;
  final String? Label;
  final  TextStyle? style;
  final IconData? icon;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final Color? iconColor;
  final Color? textColor;
  final double? fontSize;
  final AlignmentGeometry? begin;
  final AlignmentGeometry? end;
  final double? blurRadius;
  final double? spreadRadius;
  final Widget? child;
  final BorderRadiusGeometry? borderRadius;
  final void Function()? onTap;
  final double? space;
  final double? iconSize;
  final List<BoxShadow>? boxShadow;
  bool? isClicked;
  final BoxShape? shape;
  final bool? inCol;
  PrimaryButton({this.alignment,
    this.padding,
    this.color,
    this.decoration,
    this.width,
    this.height,
    this.margin,
    this.gradientColorOne,
    this.gradientColorTwo,
    this.shadowColor,
    this.dx, this.dy,
    this.gradient,
    this.Label,
    this.style,
    this.icon,
    this.fontWeight,
    this.fontStyle,
    this.iconColor,
    this.textColor,
    this.fontSize,
    this.begin,
    this.end,
    this.blurRadius,
    this.spreadRadius,
    this.child,
    this.borderRadius,
    this.onTap,
    this.space,
    this.iconSize,
    this.boxShadow,
    this.isClicked,
    this.shape,
    this.inCol
  }) ;

  @override
  Widget build(BuildContext context) {
    final widths = MediaQuery.of(context).size.width;
    return InkWell(
      onTap:onTap,
      child:Container(
        margin: margin,
        alignment: Alignment.center,
        padding:padding,
        height: height==null?40:height,
        width: width==null?widths:width,
        decoration: BoxDecoration(
          shape:shape==null?BoxShape.rectangle:shape!,
            borderRadius: borderRadius==null?BorderRadius.circular(5):borderRadius,
            color: color==null?ColorConstant.primaryColor:color,
            gradient: gradient,
            boxShadow: boxShadow
        ),
        child:child==null?icon==null?
        Text(Label==null?"":Label!, style:GoogleFonts.alike(
            textStyle:TextStyle(color:ColorConstant.whiteColor?? textColor,fontSize: fontSize, fontWeight:fontWeight==null? FontWeight.w500: fontWeight)),)
        :inCol==false?Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor==null?ColorConstant.whiteColor:iconColor, size: iconSize,),
            SizedBox(width:space==null?5:space ,),
            Text(Label==null?"":Label!, style:GoogleFonts.alike(
                textStyle:TextStyle(color:ColorConstant.whiteColor?? textColor,fontSize: fontSize, fontWeight:fontWeight==null? FontWeight.w500: fontWeight)),),
          ],
        )
            :Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor==null?ColorConstant.whiteColor:iconColor, size: iconSize,),
            SizedBox(width:space==null?5:space ,),
            Text(Label==null?"":Label!, style:GoogleFonts.alike(
                textStyle:TextStyle(color:ColorConstant.whiteColor?? textColor,fontSize: fontSize, fontWeight:FontWeight.w500?? fontWeight)),),
          ],
        ):child,
      )
      ,
    );
  }
}

