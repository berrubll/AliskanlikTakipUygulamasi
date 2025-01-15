import 'package:flutter/material.dart';
import 'register_third.dart';

class SignUpStep2 extends StatefulWidget {
  final Map<String, dynamic> step1Data;
  const SignUpStep2({Key? key, required this.step1Data}) : super(key: key);

  @override
  State<SignUpStep2> createState() => _SignUpStep2State();
}

class _SignUpStep2State extends State<SignUpStep2> {
  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hesap Oluştur"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Cinsiyetinizi Seçin"),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => setState(() => _selectedGender = "Erkek"),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: _selectedGender == "Erkek"
                          ? Colors.blue
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(child: Text("Erkek")),
                  ),
                ),
                GestureDetector(
                  onTap: () => setState(() => _selectedGender = "Kadın"),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: _selectedGender == "Kadın"
                          ? Colors.pink
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(child: Text("Kadın")),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_selectedGender == null) return;
                  final step2Data = {
                    ...widget.step1Data,
                    "gender": _selectedGender,
                  };

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUpStep3(step2Data: step2Data),
                    ),
                  );
                },
                child: const Text("İleri"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
