class UserModel {
  String firstName;
  String lastName;
  String email;
  String mobile;
  DateTime dob;
  DateTime joinDate;
  DateTime designationDate;
  String role;
  String? supervisorId;
  String profileImageUrl;
  Map<String, String> emergencyContact;
  String password;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobile,
    required this.dob,
    required this.joinDate,
    required this.designationDate,
    required this.role,
    this.supervisorId,
    required this.profileImageUrl,
    required this.emergencyContact,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'mobile': mobile,
      'birthday': dob,
      'join_date': joinDate,
      'designation_date': designationDate,
      'role': role,
      'supervisor_id': supervisorId ?? '',
      'profile_image_url': profileImageUrl,
      'emergency_contact': emergencyContact,
      'password': password,
    };
  }
}
