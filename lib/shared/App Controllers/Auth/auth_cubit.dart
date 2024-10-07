import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:zoom_travel/shared/Model/login_model.dart';
import 'package:zoom_travel/shared/network/end_points.dart';
import 'package:zoom_travel/shared/network/local/cache_helper.dart';
import 'package:zoom_travel/shared/network/remote/dio_helper.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  Login? loginModel;
  String gender = "Male";
  void login({
    required String userName,
    required String password,
    Function()? onError,
    Function()? onSuccess,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: ApiUrl.login,
      data: {
        "email": userName,
        "password": password,
      },
    ).then((value) {
      print(value.data);
      if (value.statusCode == 200) {
        print("Login success");
        loginModel = Login.fromJson(value.data);
        CacheHelper.saveData(key: "token", value: loginModel!.accessToken);
        onSuccess!();
      } else {
        print("Login Error !");
        onError!();
      }
      emit(LoginSuccessState());
    }).catchError((e) {
      emit(LoginErrorState());
    });
  }

  void signup({
    required String userName,
    required String email,
    required String phone,
    required String birthDate,
    required String password,
    Function()? onError,
    Function()? onSuccess,
  }) {
    emit(SignUpLoadingState());
    DioHelper.postData(url: ApiUrl.signUp, data: {
      "name": userName,
      "email": email,
      "password": password,
      "date_of_birth": birthDate,
      "phone_number":phone
    }).then((value) {
      print(value.data);
      if (value.statusCode == 200) {
        print("Login success");
        onSuccess!();
      } else {
        print("Login Error !");
        onError!();
      }
      emit(SignUpSuccessState());
    }).catchError((e) {
      emit(SignUpErrorState());
    });
  }

  void forgetPass({
    required String email,
    Function()? onError,
    Function()? onSuccess,
  }) {
    emit(ForgetPassLoadingState());
    DioHelper.postData(url: ApiUrl.forgetPass, data: {
      "email": email,
    }).then((value) {
      print(value.data);
      if (value.statusCode == 200) {
        print("Email sent successfully !");
        onSuccess!();
      } else {
        print("Email sent Error !");
        onError!();
      }
      emit(ForgetPassSuccessState());
    }).catchError((e) {
      emit(ForgetPassErrorState());
    });
  }

  void resetPass({
    required String password,
    Function()? onError,
    Function()? onSuccess,
  }) {
    emit(ResetPassLoadingState());
    DioHelper.postData(url: ApiUrl.resetPass, data: {
      "email": CacheHelper.getData(key: "email"),
      "code": CacheHelper.getData(key: "code"),
      "password": password,
    }).then((value) {
      print(value.data);
      if (value.statusCode == 200) {
        print("ResetPass success");
        onSuccess!();
      } else {
        print("ResetPass Error !");
        onError!();
      }
      emit(ResetPassSuccessState());
    }).catchError((e) {
      emit(ResetPassErrorState());
    });
  }
}
