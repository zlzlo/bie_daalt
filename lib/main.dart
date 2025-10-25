import 'package:flutter/material.dart';
import 'package:bie_daalt/pages/login_page.dart';
import 'package:bie_daalt/pages/register_page.dart';
import 'package:bie_daalt/pages/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bie Daalt',
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (_) => const LoginPage(),
        '/register': (_) => const RegisterPage(),
        '/home': (_) => const HomePage(),
      },
    );
  }
}
