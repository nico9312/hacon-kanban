import 'package:app/ui/board_page.dart';
import 'package:app/utils/config/di_bindings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  runApp(GetMaterialApp(
    home: const BoardView(),
    initialBinding: AppBindings(),
  ));
}
