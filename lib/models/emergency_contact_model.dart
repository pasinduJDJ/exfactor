class EmergencyContact {
  final int? emCId;
  final String name;
  final String mobileNumber;
  final String relationship;
  final int uId;

  EmergencyContact({
    this.emCId,
    required this.name,
    required this.mobileNumber,
    required this.relationship,
    required this.uId,
  });

  Map<String, dynamic> toMap() => {
        'name': name,
        'mobile_number': mobileNumber,
        'relationship': relationship,
        'u_id': uId,
      };

  factory EmergencyContact.fromMap(Map<String, dynamic> map) =>
      EmergencyContact(
        emCId: map['em_c_id'],
        name: map['name'] ?? '',
        mobileNumber: map['mobile_number'] ?? '',
        relationship: map['relationship'] ?? '',
        uId: map['u_id'],
      );
}
