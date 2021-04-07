import 'package:pizza_finder/local/db.dart';
import 'package:pizza_finder/provider/base_provider.dart';
import 'package:pizza_finder/router.dart';
import 'package:flutter/material.dart';

Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await LocalData.db.initDB();

  runApp(BaseProvider(
      router: AppRouter(),
  ));
}