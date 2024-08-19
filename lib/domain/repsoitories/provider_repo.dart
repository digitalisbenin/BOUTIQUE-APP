
import 'package:digitalis_shop_grocery_app/presentation/provider/shopping_cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../presentation/provider/app_provider.dart';
import '../models/shopping_model.dart';

class ProviderRepo extends StatelessWidget {
  final Widget child;
  const ProviderRepo({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => AppProvider(),
        ),
        /* ChangeNotifierProvider(
          create: (ctx) => ShoppingCartProvider(),
        ),
        Provider<List<ShoppingCartModel>>(
          create: (context) => [],
          lazy: false,
        ), */
      ],
      child: child,
    );
  }
}
