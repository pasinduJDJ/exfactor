class UserModel {
  final String? userId;
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
  final String emergencyName;
  final String emergencyMobileNumber;
  final String emergencyRelationship;

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
    required this.emergencyName,
    required this.emergencyMobileNumber,
    required this.emergencyRelationship,
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
      'emergency_name': emergencyName,
      'emergency_number': emergencyMobileNumber,
      'emergency_relationship': emergencyRelationship,
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
      emergencyName: map['emergency_name'] ?? '',
      emergencyMobileNumber: map['emergency_number'] ?? '',
      emergencyRelationship: map['emergency_relationship'] ?? '',
    );
  }

  UserModel copyWith({
    String? userId,
    String? firstName,
    String? lastName,
    String? email,
    String? mobile,
    DateTime? birthday,
    DateTime? joinDate,
    DateTime? designationDate,
    String? role,
    String? profileImage,
    String? supervisor,
    String? emergencyName,
    String? emergencyMobileNumber,
    String? emergencyRelationship,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      birthday: birthday ?? this.birthday,
      joinDate: joinDate ?? this.joinDate,
      designationDate: designationDate ?? this.designationDate,
      role: role ?? this.role,
      profileImage: profileImage ?? this.profileImage,
      supervisor: supervisor ?? this.supervisor,
      emergencyName: emergencyName ?? this.emergencyName,
      emergencyMobileNumber:
          emergencyMobileNumber ?? this.emergencyMobileNumber,
      emergencyRelationship:
          emergencyRelationship ?? this.emergencyRelationship,
    );
  }
}
