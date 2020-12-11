import 'package:bookings/screens/home/home.dart';
import 'package:bookings/services/mainService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => MainAppProvider(),
      child: new MaterialApp(
        home: new MyApp(),
      )));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainAppProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bookings',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(provider),
    );
  }
}
