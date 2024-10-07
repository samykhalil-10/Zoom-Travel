import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zoom_travel/shared/App%20Controllers/Favourite/favourite_cubit.dart';
import 'package:zoom_travel/shared/components/constants.dart';
import 'package:zoom_travel/shared/widgets/fav_item.dart';

class FavouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: BlocProvider(
        create: (context) => FavouriteCubit()..getFavourites(),
        child: BlocConsumer<FavouriteCubit, FavouriteState>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = context.read<FavouriteCubit>();
            return Scaffold(
              body: cubit.favourite == null
                  ? Center(
                      child: CircularProgressIndicator(
                      color: ConstColors.defaultColor,
                    ))
                  : cubit.favourite!.content!.wishlist!.isEmpty
                      ? Center(
                          child: Text(
                            'Add your Favourite Places Here..!',
                            style: GoogleFonts.akayaKanadaka(
                                fontSize: 18.sp, fontWeight: FontWeight.bold),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Offers you love",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Expanded(
                                child: GridView.count(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 2.0,
                                  childAspectRatio: 1 / 1.2,
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  children: List.generate(
                                      cubit
                                          .favourite!.content!.wishlist!.length,
                                      (index) => FavItem(
                                            favorites: cubit.favourite!.content!
                                                .wishlist![index],
                                            index: index,
                                          )),
                                ),
                              ),
                            ],
                          ),
                        ),
            );
          },
        ),
      ),
    );
  }
}
