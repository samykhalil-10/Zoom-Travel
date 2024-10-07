import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zoom_travel/layout/zoom_layout.dart';
import 'package:zoom_travel/screens/login/Login_Screen.dart';
import 'package:zoom_travel/screens/onboarding/onboarding.dart';
import 'package:zoom_travel/shared/components/constants.dart';
import 'package:zoom_travel/shared/cubit/cubit.dart';
import 'package:zoom_travel/shared/cubit/states.dart';
import 'package:zoom_travel/shared/network/local/cache_helper.dart';
import 'package:zoom_travel/shared/network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ZoomCubit()..getCurrentPosition(),
      child: BlocConsumer<ZoomCubit, ZoomStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ScreenUtilInit(
            designSize: const Size(360, 760),
            builder: (_, child) => MaterialApp(
              themeMode: ThemeMode.light,
              theme: ThemeData(
                scaffoldBackgroundColor: Colors.white,
                primarySwatch: Colors.teal,
                appBarTheme:
                    Theme.of(context).appBarTheme.copyWith(systemOverlayStyle: SystemUiOverlayStyle.light),
              ),
              debugShowCheckedModeBanner: false,
              // home: LayoutScreen(),
              home:
              firstTime == null
                  ? OnBoardingScreen()
                  : token != null
                      ? LayoutScreen()
                      : ZoomLoginScreen(),
            ),
          );
        },
      ),
    );
  }
}
