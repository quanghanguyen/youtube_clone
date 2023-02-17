import 'package:flutter/material.dart';
import 'package:youtube_app/app/app_screen.dart';
import 'package:youtube_app/pages/home_pages.dart';

import 'injection/injection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppPage(),
    );
  }
}
