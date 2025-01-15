import 'package:berrubulbulodev/apppage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Firebase Auth örneği (genelde singleton)
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // E-posta/şifre ile giriş fonksiyonu
  Future<void> _signIn() async {
    try {
      // Text alanlarından değerleri al
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      // Firebase Auth ile giriş yap
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Giriş başarılıysa userCredential.user üzerinden kullanıcı bilgilerine erişebilirsiniz.
      if (userCredential.user != null) {
        final uid = userCredential.user!.uid; // Kullanıcı UID'si

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Giriş başarılı!"),
          ),
        );

        // HomePage'e UID ile yönlendirme
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(uid: uid),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      // FirebaseAuth spesifik hataları
      String errorMsg;
      if (e.code == 'user-not-found') {
        errorMsg = 'Kullanıcı bulunamadı.';
      } else if (e.code == 'wrong-password') {
        errorMsg = 'Hatalı şifre.';
      } else {
        errorMsg = 'Bir hata oluştu: ${e.message}';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMsg)),
      );
    } catch (e) {
      // Diğer hatalar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hata: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Giriş Yap"),
      ),
      body: Container(
        decoration: const BoxDecoration(color: Color(0xff2B2630)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // E-mail TextField
              SizedBox(
                width: 380,
                child: TextField(
                  controller: _emailController, // <-- controller bağladık
                  style:
                      const TextStyle(fontFamily: "SfPro", color: Colors.white),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text(
                      "Email Adresinizi Giriniz",
                      style: TextStyle(
                        fontFamily: "SfPro",
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Şifre TextField
              SizedBox(
                width: 380,
                child: TextField(
                  controller: _passwordController, // <-- controller bağladık
                  style:
                      const TextStyle(fontFamily: "SfPro", color: Colors.white),
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text(
                      "Şifrenizi Giriniz",
                      style: TextStyle(
                        fontFamily: "SfPro",
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Giriş Butonu
              ElevatedButton(
                onPressed:
                    _signIn, // <-- basıldığında _signIn fonksiyonu çağrılır
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(345, 52),
                  maximumSize: const Size(345, 52),
                  // Arka planı şeffaf yapıyoruz.
                  backgroundColor: Colors.transparent,
                  // Gölge rengini de şeffaf yaparak butonun mat görünmesini sağlayabiliriz.
                  shadowColor: Colors.transparent,
                  // Kenar yuvarlama
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  // "padding: EdgeInsets.zero" da kullanabilirsiniz (kendi Container'ınızda padding verecekseniz).
                  padding: EdgeInsets.zero,
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xffBF7BFB), Color(0xff58378E)],
                    ),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  // Container, butonun boyutunu korumak için:
                  child: Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.login),
                        SizedBox(width: 8),
                        Text(
                          "Giriş Yap",
                          style: TextStyle(
                            fontFamily: "SfPro",
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
