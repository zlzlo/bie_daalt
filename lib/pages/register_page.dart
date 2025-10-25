import 'package:flutter/material.dart';
import 'package:bie_daalt/services/auth_service.dart';
import 'package:bie_daalt/pages/welcome_splash.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);

    final email = _email.text.trim();
    final pass = _password.text;

    final ok = await AuthService.instance.register(email, pass);
    if (ok) {
      // амжилттай бол автоматаар нэвтэрнэ
      await AuthService.instance.login(email, pass);
    }

    setState(() => _loading = false);

    if (ok) {
      if (!mounted) return;
      // Бүртгэл амжилттай → мэндчилгээтэй splash руу (1–3 сек)
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => WelcomeSplash(email: email, durationMs: 1800),
        ),
        (route) => false,
      );
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Энэ имэйлээр аль хэдийн бүртгэгдсэн байна.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Бүртгүүлэх')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Имэйл',
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => (v == null || v.isEmpty || !v.contains('@'))
                      ? 'Зөв имэйл оруулна уу'
                      : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _password,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Нууц үг',
                    prefixIcon: Icon(Icons.lock_outline),
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => (v == null || v.length < 6)
                      ? 'Доод тал нь 6 тэмдэгт'
                      : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _confirm,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Нууц үг давтах',
                    prefixIcon: Icon(Icons.lock_outline),
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) =>
                      (v != _password.text) ? 'Нууц үг таарахгүй байна' : null,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _loading ? null : _register,
                    child: _loading
                        ? const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          )
                        : const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Text('Бүртгүүлэх'),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
