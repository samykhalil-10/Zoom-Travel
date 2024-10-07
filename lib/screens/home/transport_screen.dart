import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zoom_travel/shared/widgets/transports_item.dart';

class TransportScreen extends StatelessWidget {
  const TransportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Image.asset(
                  'assets/images/transport.png',
                  width: 1.sw,
                  height: .33.sh,
                  fit: BoxFit.fill,
                ),
                Positioned(
                  left: 10,
                  bottom: 20,
                  child: Text("Transports",
                      style: GoogleFonts.akayaKanadaka(
                          fontWeight: FontWeight.bold, color: Colors.black, fontSize: 30.sp)),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Card(
                          shape: CircleBorder(),
                          elevation: 10,
                          child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 20,
                              child: Icon(
                                Icons.chevron_left,
                                size: 30.sp,
                                color: Colors.black,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: .31.sh),
              padding: EdgeInsets.all(15),
              width: 1.sw,
              height: .69.sh,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      TransportsItem(
                        mapLink: "https://www.google.com/maps/search/%D9%82%D8%B7%D8%A7%D8%B1",
                        title: "Trains",
                        image: 'assets/images/train.png',
                      ),
                      TransportsItem(
                        mapLink: "https://www.google.com/maps/search/%D9%85%D8%B7%D8%A7%D8%B1",
                        title: "Airports",
                        image: 'assets/images/plane2.png',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      TransportsItem(
                        mapLink: "https://www.google.com/maps/search/%D9%85%D8%AA%D8%B1%D9%88",
                        title: "Subways",
                        image: 'assets/images/metro.png',
                      ),
                      TransportsItem(
                        mapLink: "https://www.google.com/maps/search/%D8%A8%D8%A7%D8%B5",
                        title: "Bus",
                        image: 'assets/images/bus.png',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
