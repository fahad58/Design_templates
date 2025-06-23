import 'package:flutter/material.dart';
// Automatic FlutterFlow imports
import 'package:http/http.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';


Future<bool> checkInternetConnection() async {
  // This returns true if the app is connected to the internet (determined by checking access to certain websites) and false if no internet connection can be established

  bool connection = await InternetConnection().hasInternetAccess;
  return connection;
}

void SnackBarInternet(bool hasconnection, BuildContext context,
    Text textinternet, Text textnointernet, Color coloryes, Color colorno) {
  if (hasconnection) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: coloryes,
        content: textinternet,
        duration: const Duration(milliseconds: 4000),
      ),
    );
  } else {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: textnointernet,
        backgroundColor: colorno,
        duration: const Duration(milliseconds: 4000),
      ),
    );
  }
}
