import 'package:flutter/material.dart';
// Automatic FlutterFlow imports
import 'package:http/http.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';


Future<bool> checkInternetConnection() async {
  // This returns true if the app is connected to the internet (determined by checking access to certain websites) and false if no internet connection can be established

  bool connection = await InternetConnection().hasInternetAccess;
  return connection;
}
