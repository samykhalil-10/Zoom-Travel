import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zoom_travel/shared/Model/profile_model.dart';
import 'package:zoom_travel/shared/network/end_points.dart';
import 'package:zoom_travel/shared/network/local/cache_helper.dart';
import 'package:zoom_travel/shared/network/remote/dio_helper.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();

  void updateProfile({
    required String email,
    required String name,
    required String phone,
    required String birthDate,
    Function()? onError,
    Function()? onSuccess,
  }) {
    emit(ProfileLoadingState());
    DioHelper.putData(
        url: ApiUrl.profile,
        token: CacheHelper.getData(key: "token"),
        data: {"name": name, "email": email, "phone_number": phone, "date_of_birth": birthDate}).then((value) {
      print(value.data);
      if (value.statusCode == 200) {
        print("Profile Updated successfully !");
        onSuccess!();
      } else {
        print("Profile Edit Error !");
        onError!();
      }
      emit(ProfileSuccessState());
    }).catchError((e) {
      emit(ProfileErrorState());
    });
  }

  Profile? profile;

  void getProfile({
    Function()? onError,
    Function()? onSuccess,
  }) {
    {
      emit(ProfileLoadingState());
      DioHelper.getData(url: ApiUrl.profile, token: CacheHelper.getData(key: "token")).then((value) {
        print(value.data);
        if (value.statusCode == 200) {
          profile = Profile.fromJson(value.data);
          nameController.text = profile!.content.user.name;
          emailController.text = profile!.content.user.email;
          phoneController.text = profile!.content.user.phoneNumber;
          birthDateController.text = profile!.content.user.dateOfBirth;
          print("Get Profile successfully !");
          onSuccess!();
        } else {
          print("Get Profile Error !");
          onError!();
        }
        emit(ProfileSuccessState());
      }).catchError((e) {
        emit(ProfileErrorState());
      });
    }
  }

  ///Profile image functions
  ///
  File? image;

  chooseImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
    }
    emit(ChooseImageState());
  }

  void updateProfileImage({Function()? onSuccess}) async {
    emit(UpdateProfileImageLoadingState());
    DioHelper.postData(
        containImage: true,
        url: ApiUrl.profileImage,
        token: CacheHelper.getData(key: "token"),
        data: {
          "file": await MultipartFile.fromFile(image!.path,
              filename: image!.path.split('/').last, contentType: MediaType('image', 'jpg')),
        }).then((value) {
      print(value.statusCode);
      if (value.statusCode == 200) {
        onSuccess!();
      }
      emit(UpdateProfileImageSuccessState());
    }).catchError((e) {
      emit(UpdateProfileImageErrorState());
    });
  }

  ///edit profile
  bool editProfile = false;

  void openEditing() {
    editProfile = !editProfile;
    emit(ChangeEditProfileState());
  }
}
