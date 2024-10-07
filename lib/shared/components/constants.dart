import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zoom_travel/shared/network/local/cache_helper.dart';

class ConstColors {
  static Color defaultColor = Color(0xFF009578);
}

void onSuccess({
  required BuildContext context,
  required String text,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
    backgroundColor: Colors.green,
  ));
}

void onError({
  required BuildContext context,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text("Something went wrong!"),
    backgroundColor: Colors.red,
  ));
}

void reserveActivity(String mapLink) async {
  await launch(mapLink);
}

void getLocation({ double? DLat,  double? DLong}) async {
  await launchUrl(
      Uri.parse("https://www.google.com/maps/dir/?api=1&origin=$lat,$long&destination=$DLat,$DLong"));
}

String? token = CacheHelper.getData(key: "token");
bool? firstTime = CacheHelper.getData(key: "firstTime");

double? lat = CacheHelper.getData(key: "lat");
double? long = CacheHelper.getData(key: "long");
