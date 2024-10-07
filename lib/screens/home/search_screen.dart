import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zoom_travel/shared/App%20Controllers/Home/home_cubit.dart';
import 'package:zoom_travel/shared/widgets/Activities_list.dart';
import '../../shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit cubit = HomeCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              toolbarHeight: 70.h,
              backgroundColor: Colors.white,
              elevation: 0,
              automaticallyImplyLeading: false,
              leadingWidth: 0,
              centerTitle: true,
              title: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: defaultFormField(
                  height: 50.h,
                  width: .9.sw,
                  controller: searchController,
                  hint: "Search",
                  type: TextInputType.text,
                  onSubmit: (v) {
                    cubit.searchActivity(searchKey: searchController.text);
                  },
                  suffix: Icons.search,
                  suffixColor: Color(0xFF009578),
                  validator: (String? a) {},
                ),
              ),
            ),
            body: Column(
              children: [
                state is SearchActivityLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.teal,
                        ),
                      )
                    : cubit.generalActivities != null &&
                            cubit.searchList.isEmpty
                        ? Center(
                            child: Center(
                              child: Text(
                                'No Result Found!',
                                style: GoogleFonts.akayaKanadaka(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        : Expanded(
                            child: ActivityList(
                              activities:
                                  cubit.searchList,
                              direction: Axis.vertical,
                            ),
                          ),
              ],
            ),
          );
        },
      ),
    );
  }
}
