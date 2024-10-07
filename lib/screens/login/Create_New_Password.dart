import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zoom_travel/screens/login/Login_Screen.dart';
import 'package:zoom_travel/shared/App%20Controllers/Auth/auth_cubit.dart';
import 'package:zoom_travel/shared/cubit/cubit.dart';
import 'package:zoom_travel/shared/cubit/states.dart';

import '../../shared/components/components.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  final passwordController = TextEditingController();
  final ConfirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ZoomCubit()),
        BlocProvider(create: (context) => AuthCubit()),
      ],
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = AuthCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.chevron_left,
                  color: Colors.black,
                  size: 30.sp,
                ),
              ),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        'Create New Password',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Column(
                          children: [
                            Text('Your new password must be different '),
                            Text('from previous used passwords '),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      BlocConsumer<ZoomCubit, ZoomStates>(
                        listener: (context, state) {
                          // TODO: implement listener
                        },
                        builder: (context, state) {
                          return Form(
                            key: formKey,
                            child: Column(
                              children: [
                                BlocConsumer<ZoomCubit, ZoomStates>(
                                  listener: (context, state) {
                                    // TODO: implement listener
                                  },
                                  builder: (context, state) {
                                    return defaultFormField(
                                      isPassword:
                                          ZoomCubit.get(context).showPassword,
                                      width: .9.sw,
                                      controller: passwordController,
                                      type: TextInputType.visiblePassword,
                                      onSubmit: (value) {
                                        if (formKey.currentState!.validate()) {}
                                      },
                                      suffixPressed: () {
                                        ZoomCubit.get(context)
                                            .switchPasswordVisibility();
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty ||
                                            value.length < 8) {
                                          return 'password is too short';
                                        }
                                      },
                                      hint: 'Password',
                                      prefix: Icons.lock_outline,
                                      suffix:
                                          ZoomCubit.get(context).showPassword
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                defaultFormField(
                                  isPassword: ZoomCubit.get(context)
                                      .showConfirmPassword,
                                  width: .9.sw,
                                  controller: ConfirmPasswordController,
                                  type: TextInputType.visiblePassword,
                                  onSubmit: (value) {
                                    if (formKey.currentState!.validate()) {}
                                  },
                                  suffixPressed: () {
                                    ZoomCubit.get(context)
                                        .switchConfirmPasswordVisibility();
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'required';
                                    } else if (passwordController.text !=
                                        ConfirmPasswordController.text) {
                                      return "Password doesn't match!";
                                    }
                                  },
                                  hint: 'Confirm Password',
                                  prefix: Icons.lock_outline,
                                  suffix:
                                      ZoomCubit.get(context).showConfirmPassword
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      state is ResetPassLoadingState
                          ? const Center(
                              child: CircularProgressIndicator(
                              color: Colors.black,
                            ))
                          : defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.resetPass(
                                      password: passwordController.text,
                                      onError: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content:
                                              Text("Something went wrong!"),
                                          backgroundColor: Colors.red,
                                        ));
                                      },
                                      onSuccess: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              "Password Reset Successfully !"),
                                          backgroundColor: Colors.green,
                                        ));
                                        navigateAndFinish(
                                            context, ZoomLoginScreen());
                                      });
                                }
                              },
                              text: 'Reset Password'),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
