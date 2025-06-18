class UserModel {
  final String firstName;
  final String lastName;
  final String email;
  final String contactNumber;
  final DateTime dob;
  final DateTime joinDate;
  final DateTime designationDate;
  final String role;
  final String? supervisorId;
  final String profileImageUrl;
  final Map<String, String> emergencyContact;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.contactNumber,
    required this.dob,
    required this.joinDate,
    required this.designationDate,
    required this.role,
    this.supervisorId,
    required this.profileImageUrl,
    required this.emergencyContact,
  });

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'contactNumber': contactNumber,
      'dob': dob.toIso8601String(),
      'joinDate': joinDate.toIso8601String(),
      'designationDate': designationDate.toIso8601String(),
      'role': role,
      'supervisorId': supervisorId,
      'profileImageUrl': profileImageUrl,
      'emergencyContact': emergencyContact,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      contactNumber: map['contactNumber'],
      dob: DateTime.parse(map['dob']),
      joinDate: DateTime.parse(map['joinDate']),
      designationDate: DateTime.parse(map['designationDate']),
      role: map['role'],
      supervisorId: map['supervisorId'],
      profileImageUrl: map['profileImageUrl'],
      emergencyContact: Map<String, String>.from(map['emergencyContact']),
    );
  }
}
