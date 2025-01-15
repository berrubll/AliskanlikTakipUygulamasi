import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:berrubulbulodev/apppage/explorerpage.dart';
import 'package:berrubulbulodev/apppage/addhabitpage.dart';
import 'package:berrubulbulodev/apppage/profilepage.dart';
import 'package:berrubulbulodev/apppage/settingpage.dart';

class HomePage extends StatefulWidget {
  final String uid;

  const HomePage({Key? key, required this.uid}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int totalDailyGoal = 0;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _fetchTotalHabits();
  }

  Future<void> _fetchTotalHabits() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uid)
        .get();

    final data = docSnapshot.data();
    if (data != null && data.containsKey('selectedHabits')) {
      setState(() {
        totalDailyGoal = (data['selectedHabits'] as List).length;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _navBar(currentIndex: currentIndex),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            _buildDailyGoalsCard(),
            _buildHabitsSection(),
          ],
        ),
      ),
    );
  }

  // Navbar
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

  // Kullanıcı Profili
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          final userData = snapshot.data!.data() as Map<String, dynamic>?;
          if (userData == null)
            return const Text("Kullanıcı bilgisi bulunamadı");

          final userName = userData["name"] ?? "User";

          return Row(
            children: [
              const SizedBox(height: 80),
              Text(
                "Hoşgeldin, $userName 👋",
                style: const TextStyle(fontSize: 20),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHabitsSection() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Alışkanlıklar",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(widget.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();

            final userData = snapshot.data!.data() as Map<String, dynamic>?;
            if (userData == null) return const Text("Veri bulunamadı");

            // `habitsProgress` ve `selectedHabits` verilerini çekiyoruz
            final habitsProgress = userData["habitsProgress"] ?? {};
            final selectedHabits = userData["selectedHabits"] ?? {};

            // Tik işaretli alışkanlıkların sayısını hesaplamak için değişken
            int completedHabits = 0;

            // `selectedHabits` Map olduğu için, key-value döngüsüne uygun hale getiriyoruz
            if (selectedHabits is Map) {
              final habitKeys = selectedHabits.keys.toList();

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: habitKeys.length,
                itemBuilder: (context, index) {
                  final habitId = habitKeys[index];
                  final habitTarget =
                      selectedHabits[habitId] ?? 0; // Hedef değeri
                  final currentValue = habitsProgress[habitId] ?? 0; // İlerleme

                  // Alışkanlık tamamlanmış mı?
                  final isCompleted = currentValue >= habitTarget;
                  if (isCompleted) {
                    completedHabits++; // Tamamlanan alışkanlıkları say
                  }

                  return ListTile(
                    leading: Icon(
                      Icons.check_circle,
                      color: isCompleted ? Colors.green : Colors.grey,
                    ),
                    title: Text(habitId), // Alışkanlık adı
                    subtitle: Text(
                        "$currentValue / $habitTarget"), // İlerleme / Hedef
                    trailing: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () async {
                        // Yeni değer
                        final newValue = currentValue + 250;

                        // `habitsProgress` ve `lastActivity` güncellemesi
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(widget.uid)
                            .update({
                          "habitsProgress.$habitId": newValue,
                          "lastActivity": FieldValue.arrayUnion([habitId]),
                        });
                      },
                    ),
                  );
                },
              );
            } else {
              return const Text("Alışkanlık verisi bulunamadı.");
            }
          },
        ),
      ],
    );
  }

  Widget _buildDailyGoalsCard() {
    return Card(
      color: Colors.blueAccent,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(widget.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();

            final userData = snapshot.data!.data() as Map<String, dynamic>?;
            if (userData == null) return const Text("Veri bulunamadı");

            // `selectedHabits` Map'ten alınan hedef sayısı
            final selectedHabits =
                userData["selectedHabits"] as Map<String, dynamic>? ?? {};
            final totalDailyGoal = selectedHabits.keys.length;

            // Tamamlanan alışkanlıkları hesaplamak
            final habitsProgress = userData["habitsProgress"] ?? {};
            int completedHabits = 0;

            selectedHabits.forEach((key, value) {
              if ((habitsProgress[key] ?? 0) >= value) {
                completedHabits++;
              }
            });

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Günlük Hedef Durumun 🔥",
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  "$completedHabits / $totalDailyGoal Tamamlandı.",
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: totalDailyGoal > 0
                      ? completedHabits / totalDailyGoal
                      : 0, // Eğer totalDailyGoal 0 ise, hata almamak için 0 döneriz
                  backgroundColor: Colors.white12,
                  color: Colors.white,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
