import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zoom_travel/screens/login/Login_Screen.dart';
import 'package:zoom_travel/shared/App%20Controllers/Auth/auth_cubit.dart';
import 'package:zoom_travel/shared/cubit/cubit.dart';
import 'package:zoom_travel/shared/cubit/states.dart';

import '../../shared/components/components.dart';
import '../../shared/components/default_button.dart';

class ZoomRegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final dateOfBirthController = TextEditingController();

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
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Text('Create Account',
                              style: GoogleFonts.lato(
                                  textStyle: Theme.of(context).textTheme.headline3, color: Colors.black)),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your name';
                            }
                            return null;
                          },
                          hint: 'User name',
                          prefix: FontAwesomeIcons.user,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your E-mail';
                            }
                            return null;
                          },
                          hint: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your Phone Number';
                            }
                            return null;
                          },
                          hint: 'Phone',
                          prefix: Icons.phone,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: dateOfBirthController,
                          type: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your Date of Birth';
                            }
                            return null;
                          },
                          hint: 'Birth Date',
                          prefix: Icons.date_range,
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
                              isPassword: ZoomCubit.get(context).showPassword,
                              width: .9.sw,
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              onSubmit: (value) {
                                if (formKey.currentState!.validate()) {}
                              },
                              suffixPressed: () {
                                ZoomCubit.get(context).switchPasswordVisibility();
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'password is to short';
                                }
                              },
                              hint: 'Password',
                              prefix: Icons.lock_outline,
                              suffix: ZoomCubit.get(context).showPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            );
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text.rich(
                          TextSpan(
                            text: 'By Continuing , You Agree to Our,',
                            // default text style
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Terms Of Service ',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text.rich(
                                textAlign: TextAlign.center,
                                TextSpan(text: 'and ', children: <TextSpan>[
                                  TextSpan(text: 'Privacy Police', style: TextStyle(color: Colors.blue)),
                                ])),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        state is SignUpLoadingState
                            ? const Center(
                                child: CircularProgressIndicator(
                                color: Colors.black,
                              ))
                            : Center(
                                child: DefaultButton(
                                    function: () {
                                      if (formKey.currentState!.validate()) {
                                        cubit.signup(
                                          userName: nameController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                          phone: phoneController.text,
                                          birthDate: dateOfBirthController.text,
                                          onSuccess: () {
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                              content: Text("Account Created Successfully !"),
                                              backgroundColor: Colors.green,
                                            ));
                                            navigateAndFinish(context, ZoomLoginScreen());
                                          },
                                          onError: () {
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                              content: Text("Something went wrong!"),
                                              backgroundColor: Colors.red,
                                            ));
                                          },
                                        );
                                      }
                                    },
                                    width: .8.sw,
                                    radius: 50,
                                    height: 50,
                                    isUpperCase: true,
                                    text: 'sign up'),
                              ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Already have an account? '),
                            defaultTextButton(
                                function: () {
                                  navigateTo(context, ZoomLoginScreen());
                                },
                                text: 'Login')
                          ],
                        )
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
