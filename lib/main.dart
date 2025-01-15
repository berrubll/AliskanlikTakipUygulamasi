import 'package:berrubulbulodev/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const WelcomeScreen());
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: SplashScreen(),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold kullanarak ekranın tamamına uygulanacak arka plan tanımlayabilirsiniz
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft, // Rengin nereden başlamasını istiyorsanız
            end: Alignment.bottomRight, // ve nerede bitmesini istiyorsanız
            colors: [
              Color(0xFF3A2F68), // %0 Başlangıç rengi
              Color(0xFF7F3F97), // %100 Bitiş rengi
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: "logo",
                child: Image.asset(
                  "assets/images/welcomescreen_hand.png",
                  height: MediaQuery.of(context).size.height / 4,
                ),
              ),
              const SizedBox(height: 64),
              const Text(
                "Alışkanlık Takip Uygulaması",
                style: TextStyle(
                  fontFamily: "SfPro",
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: Colors
                      .white, // Arka plan koyu olduğu için yazıyı beyaz yapabilirsiniz
                ),
              ),
              const Text(
                "Günlük Belirlediğiniz Görevleri Yaparak Puanlar Kazanın",
                style: TextStyle(
                  fontFamily: "SfPro",
                  fontSize: 13,
                  color: Colors
                      .white, // Arka plan koyu olduğu için yazıyı beyaz yapabilirsiniz
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(311, 57),
                      backgroundColor: const Color(0xff5D4798),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(38)),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Hemen Başla",
                        style: TextStyle(
                            fontFamily: "SfPro",
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                      Image.asset(
                        "assets/images/welcomescreen_go.png",
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
