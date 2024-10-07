import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zoom_travel/shared/App%20Controllers/Explore/explore_cubit.dart';
import 'package:zoom_travel/shared/widgets/best_deals_widget.dart';
import 'package:zoom_travel/shared/widgets/top_near_widget.dart';
import '../../shared/widgets/newest_places_wideget.dart';

class ExploreScreen extends StatelessWidget {
  ExploreScreen({Key? key}) : super(key: key);
  final TextEditingController searchController = TextEditingController();
  final List<Widget> tabs = [
    Tab(text: "Newest Places"),
    Tab(text: "Top nearby"),
    Tab(text: "Best Deals"),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExploreCubit()..getNewestAvitities(),
      child: BlocConsumer<ExploreCubit, ExploreState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ExploreCubit.get(context);
          return cubit.generalActivities == null
              ? Center(child: CircularProgressIndicator())
              : DefaultTabController(
                  length: tabs.length,
                  child: Scaffold(
                    backgroundColor: Colors.white,
                    appBar: AppBar(
                      toolbarHeight: 70.h,
                      backgroundColor: Colors.white,
                      elevation: 0,
                      automaticallyImplyLeading: false,
                      leadingWidth: 0,
                      title: Text(
                        'Explore',
                        style: GoogleFonts.akayaKanadaka(
                            fontSize: 25.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      bottom: TabBar(
                        labelColor: Colors.black,
                        labelStyle: GoogleFonts.poppins(
                            fontSize: 12.sp, fontWeight: FontWeight.bold),
                        tabs: tabs,
                      ),
                    ),
                    body: TabBarView(
                      children: [NewestList(), NearestList(), BestDealsList()],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
