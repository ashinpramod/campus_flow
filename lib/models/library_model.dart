class LibraryModel {
  final String entryId;

  final String name;
  final String phoneNumber;
  final String bookTitle;
  final String borrowDate;
  final String returnDate;
  final String status; // "Borrowed", "Returned"

  LibraryModel({
    required this.entryId,
    required this.name,
    required this.phoneNumber,
    required this.bookTitle,
    required this.borrowDate,
    required this.returnDate,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'entryId': entryId,
      // 'studentId': studentId,
      'name': name,
      'phoneNumber': phoneNumber,
      'bookTitle': bookTitle,
      'borrowDate': borrowDate,
      'returnDate': returnDate,
      'status': status,
    };
  }

  static LibraryModel fromMap(Map<String, dynamic> map) {
    return LibraryModel(
      entryId: map['entryId'] ?? '',
      name: map['name'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      bookTitle: map['bookTitle'] ?? '',
      borrowDate: map['borrowDate'] ?? '',
      returnDate: map['returnDate'] ?? '',
      status: map['status'] ?? '',
    );
  }
}
