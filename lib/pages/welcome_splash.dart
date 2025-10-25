import 'dart:async';
import 'package:flutter/material.dart';

class WelcomeSplash extends StatefulWidget {
  final String email;
  final int durationMs; // 1000–3000 мс

  const WelcomeSplash({
    super.key,
    required this.email,
    this.durationMs = 1500,
  });

  @override
  State<WelcomeSplash> createState() => _WelcomeSplashState();
}

class _WelcomeSplashState extends State<WelcomeSplash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: widget.durationMs), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const FlutterLogo(size: 100),
                const SizedBox(height: 20),
                Text(
                  'Тавтай морил, ${widget.email}!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 12),
                const Text('Таны акаунтыг бэлдэж байна…'),
                const SizedBox(height: 20),
                const CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
