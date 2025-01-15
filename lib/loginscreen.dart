import 'package:berrubulbulodev/login.dart';
import 'package:berrubulbulodev/registerpage/register_first.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Container(
        decoration: BoxDecoration(
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
              // 1. Habit Container
              Container(
                width: 343,
                height: 81,
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8, // Gölgenin yumuşaklığı
                      offset: const Offset(0, 2), // Gölgenin konumu
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Sol kısım: Daire içinde progress ve ikon
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 48,
                          height: 48,
                          child: CircularProgressIndicator(
                            value: 0.25, // 500/2000 => 1/4 = %25
                            strokeWidth: 4,
                            backgroundColor: Colors.grey[200],
                            color: Colors.blue,
                          ),
                        ),
                        // İkon
                        const Icon(
                          Icons.water_drop,
                          color: Colors.blue,
                          size: 24,
                        ),
                      ],
                    ),

                    const SizedBox(width: 16),

                    // Orta kısım: Metinler
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Su İç",
                            style: TextStyle(
                              fontFamily: "SfPro",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "500/2000 ML",
                            style: TextStyle(
                              fontFamily: "SfPro",
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Sağ kısım: Artı butonu
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () {
                          // Artıya basılınca yapılacak işlem
                        },
                        icon: const Icon(Icons.add),
                        iconSize: 20,
                        color: Colors.blue,
                        splashRadius: 20,
                      ),
                    ),
                  ],
                ),
              ),

              // 2. Habit Container
              Container(
                width: 343,
                height: 81,
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8, // Gölgenin yumuşaklığı
                      offset: const Offset(0, 2), // Gölgenin konumu
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Sol kısım: Daire içinde progress ve ikon
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 48,
                          height: 48,
                          child: CircularProgressIndicator(
                            value: 0.50,
                            strokeWidth: 4,
                            backgroundColor: Colors.grey[200],
                            color: Colors.blue,
                          ),
                        ),
                        // İkon
                        const Icon(
                          Icons.directions_walk,
                          color: Colors.blue,
                          size: 24,
                        ),
                      ],
                    ),

                    const SizedBox(width: 16),

                    // Orta kısım: Metinler
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Yürüyüş Yap",
                            style: TextStyle(
                              fontFamily: "SfPro",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "5000 / 10000 Adım",
                            style: TextStyle(
                              fontFamily: "SfPro",
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Sağ kısım: Artı butonu
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () {
                          // Artıya basılınca yapılacak işlem
                        },
                        icon: const Icon(Icons.add),
                        iconSize: 20,
                        color: Colors.blue,
                        splashRadius: 20,
                      ),
                    ),
                  ],
                ),
              ),

              // 3. Habit Container
              Container(
                width: 343,
                height: 81,
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8, // Gölgenin yumuşaklığı
                      offset: const Offset(0, 2), // Gölgenin konumu
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Sol kısım: Daire içinde progress ve ikon
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 48,
                          height: 48,
                          child: CircularProgressIndicator(
                            value: 0.60, // 500/2000 => 1/4 = %25
                            strokeWidth: 4,
                            backgroundColor: Colors.grey[200],
                            color: Colors.blue,
                          ),
                        ),
                        // İkon
                        const Icon(
                          Icons.menu_book,
                          color: Colors.blue,
                          size: 24,
                        ),
                      ],
                    ),

                    const SizedBox(width: 16),

                    // Orta kısım: Metinler
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Kitap Oku",
                            style: TextStyle(
                              fontFamily: "SfPro",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "60 / 100 Sayfa",
                            style: TextStyle(
                              fontFamily: "SfPro",
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Sağ kısım: Artı butonu
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () {
                          // Artıya basılınca yapılacak işlem
                        },
                        icon: const Icon(Icons.add),
                        iconSize: 20,
                        color: Colors.blue,
                        splashRadius: 20,
                      ),
                    ),
                  ],
                ),
              ),

              const Text(
                "İlerlemeni Takip Et",
                style: TextStyle(
                  fontFamily: "SfPro",
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 40),

              // 1. Buton
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  minimumSize: const Size(345, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.login),
                    SizedBox(width: 8),
                    Text("Giriş Yap"),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // 2. Buton
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpStep1()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  minimumSize: const Size(345, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.add),
                    SizedBox(width: 8),
                    Text("Kayıt Ol"),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
