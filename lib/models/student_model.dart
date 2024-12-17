class Student {
  final String studentId;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String className;

  Student({
    required this.studentId,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.className,
  });

  Map<String, dynamic> toMap() {
    return {
      'studentId': studentId,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'className': className,
    };
  }

  static Student fromMap(Map<String, dynamic> map) {
    return Student(
      studentId: map['studentId'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      address: map['address'] ?? '',
      className: map['className'] ?? '',
    );
  }
}
