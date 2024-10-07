import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class myClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height / 1.25);
    path.cubicTo(
      size.width / 2 * 0.6,
      size.height * .5,
      size.width,
      size.height * 1.2,
      size.width * 1.6,
      size.height / 1.5,
    );
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

Widget defaultButton({
  double width = double.infinity,
  bool isUpperCase = true,
  double radius = 0.0,
  List<Color>? color,
  required Function()? function,
  required String text,
}) =>
    Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(60)),
          gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [
            Color(0xFF81D4FA),
            Color(0xFF8D6E63),
          ])),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(color: Colors.white70, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
Widget defaultTextButton({
  double radius = 0.0,
  required Function function,
  required String text,
}) =>
    Container(
      child: TextButton(
          onPressed: () {
            function();
          },
          child: Text(
            text.toUpperCase(),
            style: TextStyle(color: Colors.indigo),
          )),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
      ),
    );
Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  double? height,
  double? width,
  bool noBorder = false,
  bool readOnly = false,
  double? textSize,
  String? title,
  onSubmit,
  onChanged,
  onTap,
  bool isPassword = false,
  required String? Function(String?)? validator,
  required String hint,
  IconData? prefix,
  bool? filled,
  bool isClickable = true,
  IconData? suffix,
  Color? suffixColor,
  Function? suffixPressed,
}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title != null
            ? Column(
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 18.sp, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              )
            : SizedBox(),
        Container(
          width: width ?? .9.sw,
          height: height,
          child: TextFormField(
            readOnly: readOnly,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: textSize ?? 18.sp,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            controller: controller,
            keyboardType: type,
            obscureText: isPassword,
            enabled: isClickable = true,
            onFieldSubmitted: onSubmit,
            onChanged: onChanged,
            onTap: onTap,
            validator: validator,
            decoration: InputDecoration(
              filled: filled,
              fillColor: Colors.grey.shade300,
              border: noBorder
                  ? null
                  : OutlineInputBorder(
                      borderRadius: BorderRadius.circular(90),
                    ),
              hintText: hint,
              prefixIcon: Icon(prefix),
              suffixIcon: suffix != null
                  ? IconButton(
                      onPressed: () {
                        suffixPressed!();
                      },
                      icon: Icon(
                        suffix,
                        color: suffixColor,
                      ))
                  : null,
              // border:  OutlineInputBorder())),
              // decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(50)
            ),
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
      ],
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[300],
      ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
void replaceTo(context, widget) =>
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => widget));
void navigateAndFinish(context, widget) =>
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => widget), (route) => false);
