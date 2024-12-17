class FeeRecordModel {
  final String recordId;

  final String name;
  final String mobileNumber; // New field
  final double amount;
  final String dueDate;
  final String status; //  "Paid", "Pending"

  FeeRecordModel({
    required this.recordId,
    required this.name,
    required this.mobileNumber,
    required this.amount,
    required this.dueDate,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'recordId': recordId,
      'name': name,
      'mobileNumber': mobileNumber,
      'amount': amount,
      'dueDate': dueDate,
      'status': status,
    };
  }

  static FeeRecordModel fromMap(Map<String, dynamic> map) {
    return FeeRecordModel(
      recordId: map['recordId'] ?? '',
      name: map['name'] ?? '',
      mobileNumber: map['mobileNumber'] ?? '',
      amount: map['amount'] ?? 0.0,
      dueDate: map['dueDate'] ?? '',
      status: map['status'] ?? '',
    );
  }
}
