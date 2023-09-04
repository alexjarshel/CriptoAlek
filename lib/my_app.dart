import 'package:flutter/material.dart';
import 'pages/cripto_alek.dart';
import 'pages/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'CriptoAlek',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green
      ),
      home: HomePage(),
      //CriptoAlek(),
    );
  }
}