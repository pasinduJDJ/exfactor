class UserModel {
  final int? userId;
  final String firstName;
  final String lastName;
  final String email;
  final String mobile;
  final DateTime birthday;
  final DateTime joinDate;
  final DateTime designationDate;
  final String role;
  final String profileImage;
  final String? supervisor;

  UserModel({
    this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobile,
    required this.birthday,
    required this.joinDate,
    required this.designationDate,
    required this.role,
    required this.profileImage,
    this.supervisor,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': userId,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'mobile': mobile,
      'birthday': birthday.toIso8601String(),
      'join_date': joinDate.toIso8601String(),
      'designation_date': designationDate.toIso8601String(),
      'role': role,
      'profile_image': profileImage,
      'supervisor': supervisor,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['id'],
      firstName: map['first_name'] ?? '',
      lastName: map['last_name'] ?? '',
      email: map['email'] ?? '',
      mobile: map['mobile'] ?? '',
      birthday: DateTime.parse(map['birthday']),
      joinDate: DateTime.parse(map['join_date']),
      designationDate: DateTime.parse(map['designation_date']),
      role: map['role'] ?? '',
      profileImage: map['profile_image'] ?? '',
      supervisor: map['supervisor'],
    );
  }
}
