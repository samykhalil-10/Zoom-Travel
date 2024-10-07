import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoom_travel/screens/login/check.dart';
import 'package:zoom_travel/shared/App%20Controllers/Auth/auth_cubit.dart';
import 'package:zoom_travel/shared/components/components.dart';
import 'package:zoom_travel/shared/cubit/cubit.dart';
import 'package:zoom_travel/shared/network/local/cache_helper.dart';

class ResetMyPassword extends StatelessWidget {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
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
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Text(
                        'Reset Password ',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: Column(
                          children: [
                            Text(
                              'Enter your email address ',
                            ),
                            Text('associated with your account'),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: formKey,
                        child: defaultFormField(
                            controller: emailController,
                            type: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter your email address';
                              } else {}
                            },
                            hint: 'Email Address',
                            prefix: Icons.email_outlined),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      state is ForgetPassLoadingState
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ))
                      :defaultButton(
                          function: () {
                            if (formKey.currentState!.validate()) {
                              cubit.forgetPass(
                                  email: emailController.text,
                                  onSuccess: () {
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: Text("Password reset Successfully !"),
                                      backgroundColor: Colors.green,
                                    ));
                                    navigateTo(context, Check_Screen());
                                    CacheHelper.saveData(key: "email", value: emailController.text);
                                  },
                                  onError: () {
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: Text("Something went wrong!"),
                                      backgroundColor: Colors.red,
                                    ));
                                  }
                                  );
                            }
                          },
                          text: 'Send Email')
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
