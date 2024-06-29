import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
// Suggested code may be subject to a license. Learn more: ~LicenseLog:1188471074.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png'),
            const SizedBox(height: 20),
            const Text('Bluetooth Tomato Counter', style: TextStyle(fontSize: 24)),
            const Text('v1.0.0', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
