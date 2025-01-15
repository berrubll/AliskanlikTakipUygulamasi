import 'package:flutter/material.dart';
import 'package:berrubulbulodev/apppage/homepage.dart';
import 'package:berrubulbulodev/apppage/addhabitpage.dart';
import 'package:berrubulbulodev/apppage/profilepage.dart';
import 'package:berrubulbulodev/apppage/settingpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExplorePage extends StatefulWidget {
  final String uid;

  const ExplorePage({Key? key, required this.uid}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _navBar(currentIndex: currentIndex),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopMenu(), // Üst menü
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildSuggestedGrid(), // Kutucuklar
              ],
            ),
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
  // Üst Menü
  // ---------------------------------------------------------------------------
  Widget _buildTopMenu() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 80,
          ),
          const Text(
            "Yeni Alışkanlıklar Keşfet",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Kutucuklar
  // ---------------------------------------------------------------------------
  Widget _buildSuggestedGrid() {
    // Örnek veri
    final List<Map<String, dynamic>> suggestedItems = [
      {"title": "Yürüyüş", "subtitle": "5.000 adım", "color": Colors.red[100]},
      {"title": "Yüzme", "subtitle": "45 dakika", "color": Colors.blue[100]},
      {
        "title": "Kitap Oku",
        "subtitle": "30 sayfa",
        "color": Colors.green[100]
      },
      {
        "title": "Meditasyon",
        "subtitle": "20 dakika",
        "color": Colors.purple[100]
      },
      {"title": "Su İç", "subtitle": "2.000 ml", "color": Colors.cyan[100]},
      {
        "title": "Egzersiz",
        "subtitle": "40 dakika",
        "color": Colors.orange[100]
      },
      {
        "title": "Ders Çalış",
        "subtitle": "3 saat",
        "color": Colors.yellow[100]
      },
      {
        "title": "Dil Öğren",
        "subtitle": "30 yeni kelime",
        "color": Colors.pink[100]
      },
      {"title": "Resim Yap", "subtitle": "1 saat", "color": Colors.brown[100]},
      {
        "title": "Günlük Yaz",
        "subtitle": "15 dakika",
        "color": Colors.indigo[100]
      },
      {"title": "Yoga", "subtitle": "30 dakika", "color": Colors.teal[100]},
      {"title": "Koşu", "subtitle": "5 km", "color": Colors.amber[100]},
      {"title": "Uyku", "subtitle": "8 saat", "color": Colors.grey[200]},
      {
        "title": "Protein Al",
        "subtitle": "100 gr",
        "color": Colors.blueGrey[100]
      },
      {
        "title": "Kahve Azalt",
        "subtitle": "1 fincan",
        "color": Colors.lightGreen[100]
      },
      {
        "title": "Sebze Tüket",
        "subtitle": "300 gr",
        "color": Colors.deepOrange[100]
      },
      {
        "title": "Şekerden Uzak Dur",
        "subtitle": "0 şeker",
        "color": Colors.deepPurple[100]
      },
      {
        "title": "Podcast Dinle",
        "subtitle": "20 dakika",
        "color": Colors.lime[100]
      },
      {
        "title": "Yeni Şarkı Dinle",
        "subtitle": "3 şarkı",
        "color": Colors.blueAccent[100]
      },
      {
        "title": "Doğa Fotoğrafı Çek",
        "subtitle": "10 fotoğraf",
        "color": Colors.greenAccent[100]
      },
      {
        "title": "Bisiklet Sür",
        "subtitle": "10 km",
        "color": Colors.purpleAccent[100]
      },
      {
        "title": "Tuz Tüketimini Azalt",
        "subtitle": "1 çay kaşığı",
        "color": Colors.lightBlue[100]
      },
      {
        "title": "Telefon Süresi",
        "subtitle": "2 saatten az",
        "color": Colors.orangeAccent[100]
      },
    ];

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3 sütun
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 3 / 2, // Kutu oranı
      ),
      itemCount: suggestedItems.length,
      itemBuilder: (context, index) {
        final item = suggestedItems[index];
        return GestureDetector(
          onTap: () {
            // BottomSheet'i açıyoruz
            showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${item["title"]} alışkanlığını eklemek ister misiniz?",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                            ),
                            onPressed: () {
                              // Vazgeç Butonu: BottomSheet'i kapatır
                              Navigator.pop(context);
                            },
                            child: const Text("Vazgeç"),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.greenAccent,
                            ),
                            onPressed: () async {
                              final title = item["title"];
                              try {
                                // HabitsProgress'a ekleme
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(widget.uid)
                                    .update({
                                  "habitsProgress.$title": 0,
                                  "selectedHabits.$title": 250,
                                  "lastActivity": FieldValue.arrayUnion(
                                    ["$title Alışkanlığı Eklendi"],
                                  ),
                                });

                                // SnackBar göster
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          Text("$title alışkanlığı eklendi"),
                                    ),
                                  );
                                }

                                // BottomSheet'i kapat
                                Navigator.pop(context);
                              } catch (e) {
                                // Hata durumunda SnackBar göster
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        "Bir hata oluştu: ${e.toString()}"),
                                  ),
                                );
                              }
                            },
                            child: const Text("Ekle"),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: item["color"],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item["title"],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    item["subtitle"],
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
