import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:urubu_do_pix/configs/app_setings.dart';
import 'package:urubu_do_pix/repositories/favorites_repository.dart';
import './my_app.dart';
import 'configs/hive_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveConfig.start();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => AppSettings()),
      ChangeNotifierProvider(create: (context) => FavoritesRepository())
    ], child: MyApp()),
  );
}
