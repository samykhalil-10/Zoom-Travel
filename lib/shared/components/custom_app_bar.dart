import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

customAppBar({Widget? title, required BuildContext context}) {
  return AppBar(
    title: title,
    centerTitle: true,
    backgroundColor: Colors.white,
    elevation: 0,
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(
        Icons.chevron_left,
        color: Colors.black,
        size: 30.sp,
      ),
    ),
  );
}
