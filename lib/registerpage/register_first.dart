import 'package:flutter/material.dart';
import 'register_second.dart';

class SignUpStep1 extends StatefulWidget {
  const SignUpStep1({Key? key}) : super(key: key);

  @override
  State<SignUpStep1> createState() => _SignUpStep1State();
}

class _SignUpStep1State extends State<SignUpStep1> {
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  DateTime? _birthDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hesap Oluştur - Adım 1"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Adınızı Girin"),
            TextField(controller: _nameController),
            const SizedBox(height: 16),
            const Text("Soyadınızı Girin"),
            TextField(controller: _surnameController),
            const SizedBox(height: 16),
            const Text("Email Adresinizi Girin"),
            TextField(controller: _emailController),
            const SizedBox(height: 16),
            const Text("Şifrenizi Girin"),
            TextField(
              controller: _passwordController,
              obscureText: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                );
                if (picked != null) {
                  setState(() {
                    _birthDate = picked;
                  });
                }
              },
              child: const Text("Doğum Tarihi Seç"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_birthDate == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Doğum tarihi seçiniz!")),
                  );
                  return;
                }

                final step1Data = {
                  "name": _nameController.text.trim(),
                  "surname": _surnameController.text.trim(),
                  "email": _emailController.text.trim(),
                  "password": _passwordController.text.trim(),
                  "birthDate": _birthDate,
                };

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignUpStep2(step1Data: step1Data),
                  ),
                );
              },
              child: const Text("İleri"),
            ),
          ],
        ),
      ),
    );
  }
}
