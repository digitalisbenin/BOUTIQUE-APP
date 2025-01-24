import 'dart:async';
import 'package:digitalis_shop_grocery_app/data/service/auth/user_service.dart';
import 'package:digitalis_shop_grocery_app/presentation/pages/bottom_page/bottom_page.dart';
import 'package:digitalis_shop_grocery_app/presentation/pages/introduction_page/on_boarding_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();

    Timer(
      const Duration(seconds: 8),
      () {
        verifLogin();
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> verifLogin() async {
    getToken().then((value) => {
          if (value == '')
            {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const OnBoardingPage()),
                  (route) =>
                      false)
            }
          else
            {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BottomBarPage()),
                  (route) =>
                      false) 
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  backgroundColor: Colors.white,
  body: Stack(
    children: [
      Align(
        alignment: Alignment.center,
        child: ScaleTransition(
          scale: _animation,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/vegetable.png',
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 10), // Espace entre l'image et le texte
              const Text(
                'Bienvenue sur Di_Shop',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                   fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        ),
      ),
      const Positioned(
        bottom: 20, // Position du texte "Version 1.0" en bas de l'écran
        left: 0,
        right: 0,
        child: Text(
          'Version 1.0',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey,
            
          ),
        ),
      ),
    ],
  ),
);

    // return Scaffold(
    //   backgroundColor: Colors.white,
    //   body: Stack(
    //     children: [
    //       Align(
    //         alignment: Alignment.center,
    //         child: ScaleTransition(
    //           scale: _animation,
    //           child: Image.asset(
    //             'assets/images/vegetable.png',
    //             // Changer le chemin de l'image avec votre image
    //             width: 200, // ajustez la taille de l'image selon votre besoin
    //             height: 200,
    //           ),
    //         ),
    //       ),

    //         // Alignement à droite
    //          Text(
    //           'Bienvenue sur Digit Shopping', // Mettez ici votre numéro de version
    //           textAlign: TextAlign.center, // Centrez le texte
    //           style: TextStyle(
    //             fontSize: 16,
    //             color: Colors.grey,
    //           ),
    //         ),
          
    //       const Positioned(
    //         bottom: 20, // Ajustez la position verticale du texte
    //         left: 0, // Alignement à gauche
    //         right: 0, // Alignement à droite
    //         child: Text(
    //           'Version 1.0', // Mettez ici votre numéro de version
    //           textAlign: TextAlign.center, // Centrez le texte
    //           style: TextStyle(
    //             fontSize: 16,
    //             color: Colors.grey,
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}