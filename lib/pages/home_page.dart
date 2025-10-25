import 'package:flutter/material.dart';
import 'package:bie_daalt/services/auth_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthService.instance.currentUserEmail;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Нүүр'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await AuthService.instance.logout();
              if (context.mounted) {
                Navigator.of(context).pushReplacementNamed('/login');
              }
            },
          )
        ],
      ),
      body: Center(
        child: Text('Сайн уу, ${user ?? 'зочин'}!'),
      ),
    );
  }
}
