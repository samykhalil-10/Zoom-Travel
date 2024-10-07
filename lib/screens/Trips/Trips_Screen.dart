import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zoom_travel/shared/widgets/trip_item.dart';

class TripsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Trips",
                    style: GoogleFonts.akayaKanadaka(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  children: [
                    TripItem(
                      location: "Cairo",
                      image: "assets/images/cairo.jpeg",
                    ),
                    TripItem(
                        image: "assets/images/aswan.jpeg", location: "Aswan"),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  children: [
                    TripItem(
                        image: "assets/images/luxor.jpeg", location: "Luxor"),
                    TripItem(
                        image: "assets/images/alex.jpeg",
                        location: "Alexandria"),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  children: [
                    TripItem(
                        image: "assets/images/ismailia.jpeg",
                        location: "Ismailia"),
                    TripItem(
                        image: "assets/images/sharm.jpeg",
                        location: "Sharm El-Sheikh"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
