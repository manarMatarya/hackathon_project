class UserModel {
  String? id;
  String? name;
  String? email;
  String? mobile;
  String? gender;
  String? password;
  String? image;
  String? branchId;
  String? accountNumber;
  String? birthday;
  String? nationality;
  String? address;
  String? city;
  String? status;
  String? education;

  UserModel();

  UserModel.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    gender = json['gender'];
    password = json['password'];
    branchId = json['branch_id'];
    accountNumber = json['account_number'];
    image = json['image'];
    birthday = json['birthday'];
    nationality = json['nationality'];
    address = json['address'];
    city = json['city'];
    status = json['status'];
    education = json['education'];
  }

  toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'mobile': mobile,
      'gender': gender,
      'password': password,
      'branch_id': branchId,
      'account_number': accountNumber,
      'image': image,
      'birthday': birthday,
      'nationality': nationality,
      'address': address,
      'city': city,
      'status': status,
      'education': education,
    };
  }
}
