class Student {
  int? id;
  String name;
  String studentId;
  String phone;
  String email;
  String location;

  Student({
    this.id,
    required this.name,
    required this.studentId,
    required this.phone,
    required this.email,
    required this.location,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'studentId': studentId,
      'phone': phone,
      'email': email,
      'location': location,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      name: map['name'],
      studentId: map['studentId'],
      phone: map['phone'],
      email: map['email'],
      location: map['location'],
    );
  }
}
