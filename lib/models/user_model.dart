class MyUser {
  final String uid;
  final String name;
  final String surname;
  final String email;
  final DateTime birthDate;
  final String gender;
  final List<String> selectedHabits;

  MyUser({
    required this.uid,
    required this.name,
    required this.surname,
    required this.email,
    required this.birthDate,
    required this.gender,
    required this.selectedHabits,
  });

  // Firestore'a yazmak / Firestore'dan okumak için yardımcı methodlar:
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'surname': surname,
      'email': email,
      'birthDate': birthDate.toIso8601String(),
      'gender': gender,
      'selectedHabits': selectedHabits,
    };
  }

  factory MyUser.fromMap(Map<String, dynamic> map) {
    return MyUser(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      surname: map['surname'] ?? '',
      email: map['email'] ?? '',
      birthDate: DateTime.parse(map['birthDate']),
      gender: map['gender'] ?? '',
      selectedHabits: List<String>.from(map['selectedHabits'] ?? []),
    );
  }
}
