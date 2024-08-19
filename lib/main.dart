import 'package:digitalis_shop_grocery_app/presentation/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'domain/repsoitories/provider_repo.dart';
import 'utils/theme/dark_light/dark_light.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ProviderRepo(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme(context),
        home: const SplashScreen(),
      ),
    );
  }
}
