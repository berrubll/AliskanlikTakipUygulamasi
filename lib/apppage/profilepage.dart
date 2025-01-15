import 'package:flutter/material.dart';
import 'package:berrubulbulodev/apppage/explorerpage.dart';
import 'package:berrubulbulodev/apppage/addhabitpage.dart';
import 'package:berrubulbulodev/apppage/settingpage.dart';
import 'package:berrubulbulodev/apppage/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  final String uid;

  const ProfilePage({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int currentIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _navBar(currentIndex: currentIndex),
      body: Column(
        children: [
          _buildProfileHeader(), // Sekmeler (Activity, Friends, Achievements)
          Expanded(
            child: _buildActivityList(), // Etkinlik listesi
          ),
        ],
      ),
    );
  }

  //Navbar
  Widget _navBar({required int currentIndex}) {
    final List<IconData> icons = [
      Icons.home,
      Icons.explore,
      Icons.add_circle_outline,
      Icons.person,
      Icons.settings,
    ];

    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(icons.length, (index) {
          final isSelected = index == currentIndex;

          // Eğer ortadaki '+' butonuysa, tasarımı farklı yapıyoruz
          if (index == 2) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CreateCustomHabitPage(uid: widget.uid),
                  ),
                );
              },
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            );
          }

          // Diğer butonlar
          return GestureDetector(
            onTap: () {
              if (index == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(uid: widget.uid),
                  ),
                );
              } else if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExplorePage(uid: widget.uid),
                  ),
                );
              } else if (index == 3) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(uid: widget.uid),
                  ),
                );
              } else if (index == 4) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                  ),
                );
              }
            },
            child: Icon(
              icons[index],
              size: 28,
              color: isSelected ? Colors.blue : Colors.grey,
            ),
          );
        }),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Profil Üst Kısmı
  // ---------------------------------------------------------------------------
  Widget _buildProfileHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),
          const Text(
            "Profil",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              // Profil Fotoğrafı
              CircleAvatar(
                radius: 30,
                child: Icon(Icons.person),
              ),
              const SizedBox(width: 16),
              // Kullanıcı Adı ve Puanlar
              StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(widget.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }

                  final userData =
                      snapshot.data!.data() as Map<String, dynamic>;
                  final name = userData["name"] ?? "User";
                  final surname = userData["surname"] ?? "User";
                  final userName = name + " " + surname;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 80,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.star,
                                  color: Colors.orange, size: 20),
                              const SizedBox(width: 4),
                              const Text(
                                "Puan Sistemi Yakında Eklenicektir",
                                style: TextStyle(
                                    color: Colors.orange, fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Etkinlik Listesi
  // ---------------------------------------------------------------------------
  Widget _buildActivityList() {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final userData = snapshot.data!.data() as Map<String, dynamic>?;
        if (userData == null) {
          return const Center(child: Text("Veri bulunamadı"));
        }

        // Firestore'dan `lastActivity` verisini alıyoruz
        final List<dynamic> activities = userData["lastActivity"] ?? [];

        if (activities.isEmpty) {
          return const Center(child: Text("Henüz bir aktivite bulunamadı."));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: activities.length,
          itemBuilder: (context, index) {
            final activity = activities[index]; // Dizideki her bir öğe

            return Card(
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0), // Köşe yuvarlaklığı
              ),
              elevation: 4.0, // Gölgelendirme
              child: Padding(
                padding: const EdgeInsets.all(
                    12.0), // İçerik ile kenarlar arasındaki boşluk
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // İkon
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.lightGreen
                            .withOpacity(0.2), // Arka plan rengi
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(12.0),
                      child: const Icon(
                        Icons.history,
                        color: Colors.lightGreen,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 12), // İkon ile metin arasında boşluk
                    // Metinler
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            activity.toString(), // Aktivite metni
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                              height:
                                  4), // Başlık ve alt başlık arasında boşluk
                          const Text(
                            "Zaman: Son Etkinliklerin Tarih Bilgisi Yakında Eklenicek",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildActivityItem(
      {required String title,
      required String subtitle,
      required IconData icon}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
          leading: Icon(icon), title: Text(title), subtitle: Text(subtitle)),
    );
  }
}
