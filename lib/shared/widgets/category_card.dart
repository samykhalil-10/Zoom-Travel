import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zoom_travel/screens/home/transport_screen.dart';

import '../../screens/home/category_screen.dart';
import '../components/components.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem(
      {Key? key,
      required this.icon,
      required this.text,
      this.function,
      this.isTransport = false})
      : super(key: key);

  final String icon;
  final String text;
  final Function()? function;
  final bool isTransport;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: InkWell(
        onTap: () {
          navigateTo(
              context,
              isTransport
                  ? TransportScreen()
                  : categoryScreen(
                      title: text,
                      id: text == 'Historical'
                          ? 3
                          : text == 'Restaurants'
                              ? 2
                              : text == 'Cafe'
                                  ? 4
                                  : text == 'Hotels'
                                      ? 1
                                      : 0,
                    ));
        },
        child: Column(
          children: [
            SvgPicture.asset(
              icon,
              fit: BoxFit.scaleDown,
              width: 70,
              height: 70,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
