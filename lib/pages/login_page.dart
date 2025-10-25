import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  void _login() {
    if (_formKey.currentState!.validate()) {
      // Нэвтрэлт амжилттай гэж үзье
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Амжилттай нэвтэрлээ ✅')),
      );
      // TODO: дараагийн дэлгэц рүү чиглүүлэх хэсэг
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset('assets/flutter_logo.png', width: 100),
                const SizedBox(height: 20),
                const Text(
                  "Нэвтрэх",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Имэйл",
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (val) => email = val,
                  validator: (val) => val!.isEmpty ? 'Имэйл оруулна уу' : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Нууц үг",
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (val) => password = val,
                  validator: (val) =>
                      val!.length < 6 ? '6-аас дээш тэмдэгт оруул' : null,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 80, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Нэвтрэх",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {},
                  child: const Text("Бүртгэл үүсгэх"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
