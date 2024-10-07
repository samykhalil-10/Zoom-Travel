import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zoom_travel/screens/Trips/Trips_Page_Detailed.dart';
import 'package:zoom_travel/shared/components/components.dart';

class TripItem extends StatelessWidget {
  const TripItem({Key? key, required this.location, required this.image})
      : super(key: key);

  final String location;
  final String image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateTo(
            context,
            TripDetailed(
                title: location,
                id: location == 'Alexandria'
                    ? 2
                    : location == 'Cairo'
                        ? 3
                        : location == 'Aswan'
                            ? 4
                            : location == 'Luxor'
                                ? 5
                                : location == 'Ismailia'
                                    ? 6
                                    : location == 'Sharm El-Sheikh'
                                        ? 1
                                        : 0));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          height: .32.sh,
          width: .45.sw,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade200,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Text(
                  location,
                  style: GoogleFonts.akayaKanadaka(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(50)),
                ),
                child: Image.asset(
                  image,
                  height: .27.sh,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
