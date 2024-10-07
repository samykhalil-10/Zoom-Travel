import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zoom_travel/shared/components/constants.dart';

class TransportsItem extends StatelessWidget {
  const TransportsItem({Key? key, required this.image, required this.title, required this.mapLink})
      : super(key: key);
  final String image;
  final String title;
  final String mapLink;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        reserveActivity(mapLink);
      },
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: .43.sw,
          height: .25.sh,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Image.asset(
                image,
                width: .41.sw,
                height: .18.sh,
              ),
              Text(
                title,
                style: GoogleFonts.akayaKanadaka(fontSize: 25.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
