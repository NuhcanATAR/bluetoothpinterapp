import 'package:bluetoothpinterapp/feature/splash/splash_view.dart';
import 'package:bluetoothpinterapp/product/initilalize/app_start.dart';
import 'package:bluetoothpinterapp/product/theme/light_theme.dart';
import 'package:flutter/material.dart';

void main() async {
  await AppStart.initStartApp();
  runApp(const AppView());
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: CustomLightTheme().themeData,
      themeMode: ThemeMode.light,
      home: const SplashView(),
    );
  }
}
