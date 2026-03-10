class Account {
  const Account({
    required this.userId,
    required this.userLogin,
    required this.password,
    required this.mail,
    required this.status,
  });

  final String userId;
  final String userLogin;
  final String password;
  final String mail;
  final String status;

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userLogin': userLogin,
      'password': password,
      'mail': mail,
      'status': status,
    };
  }

  factory Account.fromJson(Map<dynamic, dynamic> json) {
    return Account(
      userId: (json['userId'] ?? '').toString(),
      userLogin: (json['userLogin'] ?? '').toString(),
      password: (json['password'] ?? '').toString(),
      mail: (json['mail'] ?? '').toString(),
      status: (json['status'] ?? '').toString(),
    );
  }
}