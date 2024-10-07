import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:zoom_travel/screens/login/Create_New_Password.dart';
import 'package:zoom_travel/shared/App%20Controllers/Auth/auth_cubit.dart';
import 'package:zoom_travel/shared/components/default_button.dart';
import 'package:zoom_travel/shared/cubit/cubit.dart';
import 'package:zoom_travel/shared/network/local/cache_helper.dart';

import '../../shared/components/components.dart';

class Verification extends StatelessWidget {
  const Verification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pinController = TextEditingController();
    final focusNode = FocusNode();
    final _formKey = GlobalKey<FormState>();
    const borderColor = Color.fromRGBO(150, 157, 156, 0.4);
    final defaultPinTheme = PinTheme(
      width: 55,
      height: 55,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
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
        title: const Text("Verification", style: TextStyle(color: Colors.black)),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("You will receive a verification code in a moment !",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Pinput(
                length: 6,
                controller: pinController,
                focusNode: focusNode,
                validator: (v) {
                  if (v!.isEmpty || v.length < 6) {
                    return "Pin is required !";
                  }
                },
                defaultPinTheme: defaultPinTheme,
              ),
              SizedBox(height: 50),
              DefaultButton(
                height: 40,
                width: 300,
                radius: 10,
                textSize: 14,
                textWeight: FontWeight.bold,
                textColor: Colors.white,
                text: 'Continue',
                function: () {
                  focusNode.unfocus();
                  if (_formKey.currentState!.validate()) {

                    print(pinController.text);
                    CacheHelper.saveData(key: "code", value: pinController.text);
                    replaceTo(context, CreateNewPasswordScreen());
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Resend code",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}
