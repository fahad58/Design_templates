import 'package:flutter/material.dart';
import 'package:notificationsinflutter/noti_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotiService().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(onPressed: (){
          NotiService().showNotification(title: 'Hey', body: "Hey");
        },child: Text("Press Button"),),
        ElevatedButton(onPressed: (){
          NotiService().scheduleNotification(title: 'title', body: "body", hour: 0, minute: 37);
        },child: Text("Schedule notification"),),
      ],
    ),));
  }
}

