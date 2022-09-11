class User {
  late int id;
  late String name;
  late String email;
  late String mobile;
  late String gender;
  late String password;
  late String image;
  late String branchId;
  late String accountNumber;

  User();

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    gender = json['gender'];
    password = json['password'];
    image = json['image'];
    branchId = json['branch_id'];
    accountNumber = json['account_number'];
  }

  toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'mobile': mobile,
      'image': image,
      'gender': gender,
      'password': password,
      'branch_id': branchId,
      'account_number': accountNumber
    };
  }
}
