import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateCustomHabitPage extends StatefulWidget {
  final String uid;

  const CreateCustomHabitPage({Key? key, required this.uid}) : super(key: key);

  @override
  State<CreateCustomHabitPage> createState() => _CreateCustomHabitPageState();
}

class _CreateCustomHabitPageState extends State<CreateCustomHabitPage> {
  final TextEditingController _habitNameController = TextEditingController();
  String _selectedIcon = "Walking";
  String _selectedColor = "Orange";
  int _goalTimes = 1;
  bool _daily = true;
  bool _reminderEnabled = true;
  TimeOfDay _reminderTime = const TimeOfDay(hour: 9, minute: 30);
  String _habitType = "Build";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yeni Alışkanlık Oluştur"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name Field
            const Text("Alışkanlık İsmi"),
            const SizedBox(height: 8),
            TextField(
              controller: _habitNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Alışkanlık İsmi",
              ),
            ),
            const SizedBox(height: 16),

            // Goal Section
            const Text("Hedef"),
            const SizedBox(height: 8),
            Card(
              child: ListTile(
                title: const Text("Günde 1 Defa"),
                subtitle: Text(_daily ? "Günlük" : "Her Gün"),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            "Sıklık Değiştirme Özelliği Yakında Eklenicek")));
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Add Habit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final String habitName = _habitNameController.text.trim();

                  if (habitName.isEmpty) {
                    // Alışkanlık ismi boşsa uyarı göster
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Lütfen bir alışkanlık ismi giriniz.")));
                    return;
                  }

                  try {
                    // Firestore güncellemeleri
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(widget.uid)
                        .update({
                      "habitsProgress.$habitName": 0, // habitsProgress
                      "selectedHabits.$habitName": 250, // selectedHabits
                      "lastActivity": FieldValue.arrayUnion(
                          ["$habitName Alışkanlığı Eklendi"]), // lastActivity
                    });

                    // Başarı mesajı
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("$habitName başarıyla oluşturuldu!"),
                      ));
                    }

                    // Bir önceki sayfaya dön
                    Navigator.pop(context);
                  } catch (e) {
                    // Hata mesajı
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                          Text("Alışkanlık oluşturulurken bir hata oluştu: $e"),
                    ));
                  }
                },
                child: const Text("Alışkanlık Ekle"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
