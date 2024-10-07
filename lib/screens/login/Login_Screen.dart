import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zoom_travel/layout/zoom_layout.dart';
import 'package:zoom_travel/screens/login/Reset_my_password.dart';
import 'package:zoom_travel/shared/App%20Controllers/Auth/auth_cubit.dart';
import 'package:zoom_travel/shared/components/constants.dart';
import 'package:zoom_travel/shared/components/default_button.dart';
import 'package:zoom_travel/shared/cubit/cubit.dart';
import 'package:zoom_travel/shared/cubit/states.dart';

import '../../shared/components/components.dart';
import 'Signup_Screen.dart';

class ZoomLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => ZoomCubit()),
      ],
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = AuthCubit.get(context);
          var appCubit = ZoomCubit.get(context);
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Center(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 90,
                        ),
                        Center(
                          child: Image.asset(
                            "assets/images/logo.png",
                            height: 200,
                            width: 200,
                            fit: BoxFit.fill,
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
                          child: defaultFormField(
                            width: .8.sw,
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter your email address';
                              } else {}
                            },
                            hint: 'Email Address',
                            prefix: Icons.email_outlined,
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        BlocConsumer<ZoomCubit, ZoomStates>(
                          listener: (context, state) {
                            // TODO: implement listener
                          },
                          builder: (context, state) {
                            return defaultFormField(
                              isPassword: appCubit.showPassword,
                              width: .8.sw,
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              onSubmit: (value) {
                                if (formKey.currentState!.validate()) {}
                              },
                              suffixPressed: () {
                                appCubit.switchPasswordVisibility();
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'password is to short';
                                }
                              },
                              hint: 'Password',
                              prefix: Icons.lock_outline,
                              suffix: appCubit.showPassword ? Icons.visibility_off : Icons.visibility,
                            );
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            defaultTextButton(
                              function: () {
                                navigateTo(context, ResetMyPassword());
                              },
                              text: 'Forget Password',
                            )
                          ],
                        ),
                        state is LoginLoadingState
                            ? const Center(
                                child: CircularProgressIndicator(
                                color: Colors.black,
                              ))
                            : Center(
                                child: DefaultButton(
                                    function: () {
                                      if (formKey.currentState!.validate()) {
                                        cubit.login(
                                            userName: emailController.text,
                                            password: passwordController.text,
                                            onSuccess: () {
                                              onSuccess(context: context, text: "Log in Successfully !");
                                              navigateAndFinish(context, LayoutScreen());
                                            },
                                            onError: () {
                                              onError(context: context);
                                            });
                                      }
                                    },
                                    width: .7.sw,
                                    radius: 50,
                                    height: 50,
                                    text: 'LOGIN'),
                              ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Not a member ?',
                            ),
                            defaultTextButton(
                              function: () {
                                navigateTo(
                                  context,
                                  ZoomRegisterScreen(),
                                );
                              },
                              text: 'Register Now',
                            ),
                          ],
                        ),
                      ],
                    ),
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
