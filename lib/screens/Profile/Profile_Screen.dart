import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zoom_travel/screens/login/Login_Screen.dart';
import 'package:zoom_travel/shared/App%20Controllers/Profile/profile_cubit.dart';
import 'package:zoom_travel/shared/components/app_button.dart';
import 'package:zoom_travel/shared/components/components.dart';
import 'package:zoom_travel/shared/components/constants.dart';
import 'package:zoom_travel/shared/network/end_points.dart';

import '../../shared/network/local/cache_helper.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider(
      create: (context) => ProfileCubit()..getProfile(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = ProfileCubit.get(context);
          return cubit.profile == null
              ? Center(child: CircularProgressIndicator())
              : Scaffold(
                  appBar: AppBar(
                    leadingWidth: 80.w,
                    leading: TextButton(
                        onPressed: () {
                          token='';
                          CacheHelper.removeData(key: "token").then((value) {
                            navigateAndFinish(context, ZoomLoginScreen());
                          });
                        },
                        child: Text(
                          "LOGOUT",
                          style: TextStyle(
                            color: Color(0x96FD3535),
                            fontSize: 16.sp,
                          ),
                        )),
                    actions: [
                      cubit.editProfile
                          ? state is ProfileLoadingState
                              ? Center(child: CircularProgressIndicator())
                              : TextButton(
                                  onPressed: () {
                                    cubit.updateProfile(
                                      email: cubit.emailController.text,
                                      name: cubit.nameController.text,
                                      phone: cubit.phoneController.text,
                                      birthDate: cubit.birthDateController.text,
                                      onSuccess: () {
                                        onSuccess(context: context, text: "Profile updated successfully");
                                        cubit.openEditing();
                                      },
                                      onError: () {
                                        onError(context: context);
                                      },
                                    );
                                  },
                                  child: Text(
                                    "Save",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                    ),
                                  ))
                          : SizedBox(),
                    ],
                    backgroundColor: Colors.white,
                    elevation: 0,
                    title: Text(
                      "Profile",
                      style: GoogleFonts.akayaKanadaka(
                        fontSize: 30.sp,
                        color: Colors.black,
                      ),
                    ),
                    centerTitle: true,
                  ),
                  body: ListView(
                    padding: EdgeInsets.all(15),
                    children: [
                      Column(

                        children: [
                          state is GetProfileImageLoadingState
                              ? Center(child: CircularProgressIndicator())
                              : InkWell(
                                  onTap: () async {
                                    await cubit.chooseImage();
                                  },
                                  child: Card(
                                    shape: CircleBorder(),
                                    elevation: 10,
                                    shadowColor: ConstColors.defaultColor,
                                    child: Container(
                                      width: 120.w,
                                      height: 120.h,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: cubit.image != null
                                          ? Card(
                                              clipBehavior: Clip.antiAlias,
                                              shape: CircleBorder(),
                                              elevation: 10,
                                              child: Image.file(
                                                cubit.image!,
                                                fit: BoxFit.contain,
                                              ),
                                            )
                                          : Card(
                                              shape: CircleBorder(),
                                              clipBehavior: Clip.antiAlias,
                                              child: Image.network(ApiUrl.baseUrl + ApiUrl.profileImage,
                                                  fit: BoxFit.contain,
                                                  headers: {
                                                    "Authorization":
                                                        "Bearer ${CacheHelper.getData(key: "token")}",
                                                  }),
                                            ),
                                    ),
                                  ),
                                ),
                          state is UpdateProfileImageLoadingState
                              ? CircularProgressIndicator()
                              : cubit.image == null
                                  ? SizedBox()
                                  : TextButton(
                                      onPressed: () {
                                        cubit.updateProfileImage(onSuccess: () {
                                          cubit.image = null;
                                          onSuccess(
                                              context: context, text: "Profile image updated successfully");
                                        });
                                      },
                                      child: Text("Upload")),
                          defaultFormField(
                              readOnly: !cubit.editProfile,
                              title: "Name",
                              width: .85.sw,
                              noBorder: false,
                              controller: cubit.nameController,
                              type: TextInputType.text,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter your name';
                                }
                                return null;
                              },
                              prefix: FontAwesomeIcons.user,
                              hint: "Enter your full name"),
                          defaultFormField(
                              readOnly: !cubit.editProfile,
                              title: "E-mail",
                              width: .85.sw,
                              noBorder: false,
                              controller: cubit.emailController,
                              type: TextInputType.text,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'please enter your E-mail';
                                }
                                return null;
                              },
                              prefix: Icons.email_outlined,
                              hint: "example@gmail.com"),
                          defaultFormField(
                              readOnly: !cubit.editProfile,
                              title: "Phone number",
                              width: .85.sw,
                              noBorder: false,
                              controller: cubit.phoneController,
                              type: TextInputType.text,
                              prefix: Icons.phone,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'please enter your Phone Number';
                                }
                                return null;
                              },
                              hint: "Enter your phone number"),
                          defaultFormField(
                              readOnly: !cubit.editProfile,
                              title: "Birth Date",
                              width: .85.sw,
                              noBorder: false,
                              controller: cubit.birthDateController,
                              type: TextInputType.text,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter your Birth Date';
                                }
                                return null;
                              },
                              prefix: Icons.date_range,
                              hint: "dd-mm-yyyy"),
                          !cubit.editProfile
                              ? Padding(
                                  padding: EdgeInsets.only(top: 20.h),
                                  child: AppButton(
                                    text: "Edit profile",
                                    function: () {
                                      cubit.openEditing();
                                    },
                                  ),
                                )
                              : SizedBox(),
                        ],
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
