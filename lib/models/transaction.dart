class TransactionModel {
  late String id;
  late String userId;
  late String transactionName;
  double? value1;
  String? reason;
  late String status;
  String? startDate;
  late String userBranch;
  String? paper;
  String? time;
  String? person;

  TransactionModel();

  TransactionModel.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    transactionName = json['transaction_name'];
    value1 = json['value'];
    reason = json['reason'];
    status = json['status'];
    startDate = json['startDate'];
    userBranch = json['user_branch'];
    paper = json['paper'];
    time = json['time'];
    person = json['person'];
  }

  toMap() {
    return {
      'user_id': userId,
      'transaction_name': transactionName,
      'value': value1,
      'reason': reason,
      'status': status,
      'startDate': startDate,
      'user_branch': userBranch,
      'id': id,
      'time': time,
      'person': person,
      'paper': paper,
    };
  }
}
