import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultButton extends StatelessWidget {
  final double width;
  final double? height;
  final Color? background;
  final Color borderColor;
  final Color textColor;
  final double textSize;
  final FontWeight textWeight;
  final bool isUpperCase;
  final double radius;
  final Function()? function;
  final String text;
  final LinearGradient? gradient;

  const DefaultButton({
    Key? key,
    this.height,
    this.width = double.infinity,
    this.background,
    this.textColor = Colors.white,
    this.textSize = 14,
    this.textWeight = FontWeight.w400,
    this.isUpperCase = true,
    this.radius = 10,
    required this.function,
    required this.text,
    this.borderColor = Colors.transparent,
    this.gradient = const LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [
      Color(0xFF81D4FA),
      Color(0xFF8D6E63),
    ]),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
        gradient: gradient,
        border: Border.all(color: borderColor),
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: textColor,
            fontSize: textSize.sp,
            fontWeight: textWeight,
            fontFamily: 'Almarai',
          ),
        ),
      ),
    );
  }
}
