class TransactionModel {
  late String userId;
  late String transactionName;
  late double value;
  late String reason;
  late String status;
  late String startDate;
  String? endDate;

  TransactionModel();

  TransactionModel.fromMap(Map<String, dynamic> json) {
    userId = json['user_id'];
    transactionName = json['transaction_name'];
    value = json['value'];
    reason = json['reason'];
    status = json['status'];
    startDate = json['startDate'];
    endDate = json['endDate'];
  }

  toMap() {
    return {
      'user_id': userId,
      'transaction_name': transactionName,
      'value': value,
      'reason': reason,
      'status': status,
      'startDate': startDate,
      'endDate': endDate,
    };
  }
}
