import 'package:flutter/material.dart';

class CriptoAlek extends StatelessWidget {
  const CriptoAlek({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cripto Alek'),
       //backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Text('Dogecoin'),
      ),
      backgroundColor: Colors.white,
    );
  }
}