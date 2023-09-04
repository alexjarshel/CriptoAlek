import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:urubu_do_pix/repositories/favorites_repository.dart';
import './my_app.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (context) => FavoritesRepository(),
    child:  MyApp()
    ),
  );

   
}
