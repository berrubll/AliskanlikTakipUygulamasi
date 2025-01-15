import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:berrubulbulodev/apppage/homepage.dart';

class SignUpStep3 extends StatefulWidget {
  final Map<String, dynamic> step2Data;
  const SignUpStep3({Key? key, required this.step2Data}) : super(key: key);

  @override
  State<SignUpStep3> createState() => _SignUpStep3State();
}

class _SignUpStep3State extends State<SignUpStep3> {
  final List<String> _habitList = ["Su İçme", "Koşu", "Kitap Okuma"];
  final Map<String, dynamic> _selectedHabits = {};

  Future<void> _completeSignUp() async {
    try {
      final email = widget.step2Data["email"];
      final password = widget.step2Data["password"];

      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final uid = userCredential.user!.uid;

      final userDoc = FirebaseFirestore.instance.collection("users").doc(uid);
      final habitsProgress = {for (var habit in _selectedHabits.keys) habit: 0};

      await userDoc.set({
        "name": widget.step2Data["name"],
        "surname": widget.step2Data["surname"],
        "email": email,
        "birthDate":
            (widget.step2Data["birthDate"] as DateTime).toIso8601String(),
        "gender": widget.step2Data["gender"],
        "habitsProgress": habitsProgress,
        "selectedHabits": _selectedHabits,
        "lastActivity": ["Hesabınız oluşturuldu"],
      });

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage(uid: uid)),
        (route) => false,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Hesap başarıyla oluşturuldu!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Hata oluştu: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hesap Oluştur - Adım 3")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text("Başlangıç Alışkanlıklarını Seç"),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemCount: _habitList.length,
              itemBuilder: (context, index) {
                final habit = _habitList[index];
                final isSelected = _selectedHabits.containsKey(habit);

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        _selectedHabits.remove(habit);
                      } else {
                        _selectedHabits[habit] = 250;
                      }
                    });
                  },
                  child: Container(
                    color: isSelected ? Colors.blue : Colors.grey[300],
                    child: Center(child: Text(habit)),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _selectedHabits.isEmpty ? null : _completeSignUp,
              child: const Text("Kaydı Tamamla"),
            ),
          ],
        ),
      ),
    );
  }
}
