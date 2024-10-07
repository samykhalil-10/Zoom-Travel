import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zoom_travel/shared/App%20Controllers/Auth/auth_cubit.dart';
import 'package:zoom_travel/shared/components/default_button.dart';

import 'constants.dart';

class AppButton extends StatelessWidget {
  const AppButton({Key? key, this.function, required this.text, this.width}) : super(key: key);

  final Function()? function;
  final String text;
  final double? width;

  @override
  Widget build(BuildContext context) {

    return DefaultButton(
      function: function,
      gradient: null,
      background: ConstColors.defaultColor,
      text: text,
      textWeight: FontWeight.bold,
      isUpperCase: false,
      textSize: 16.sp,
      height: 45.h,
      width: width ?? .85.sw,
      radius: 30,
    );
  }
}
