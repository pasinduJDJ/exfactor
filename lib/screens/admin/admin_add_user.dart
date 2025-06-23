import 'package:exfactor/utils/colors.dart';
import 'package:exfactor/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../../utils/constants.dart';
import '../../widgets/common/custom_button.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import '../../models/user_model.dart';
import 'package:exfactor/services/superbase_auth.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emergencyContactNameController = TextEditingController();
  final _emergencyContactNumberController = TextEditingController();
  final _emergencyContactRelationController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  String _selectedRole = 'Select Role';
  String _selectedSupervisor = "Select Supervisor";
  bool _isLoading = false;
  DateTime? _selectedDOB;
  DateTime? _selectedJoinDate;
  DateTime? _selectedDesignationDate;
  File? _pickedImage;

  final List<String> _roles = [
    'Select Role',
    'Technician',
    'Supervisor',
    'Admin'
  ];
  final List<String> _supervisor = [
    'Select Supervisor',
    'ABCD',
    'EFGH',
    'IJKL'
  ];

  // Validate and pass data into database
  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) {
      _showToast('Please fill all required fields.');
      return;
    }
    if (_pickedImage == null) {
      _showToast('Please select a profile image.');
      return;
    }
    setState(() => _isLoading = true);
    try {
      // 1. Prepare user model (without userId and profileImage for now)
      final userModel = UserModel(
        userId: null, // will be set after Auth registration
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        email: _emailController.text.trim(),
        mobile: _phoneController.text.trim(),
        birthday: _selectedDOB!,
        joinDate: _selectedJoinDate!,
        designationDate: _selectedDesignationDate!,
        role: _selectedRole,
        profileImage: '', // will be set after image upload
        supervisor: _selectedSupervisor,
        emergencyName: _emergencyContactNameController.text.trim(),
        emergencyMobileNumber: _emergencyContactNumberController.text.trim(),
        emergencyRelationship: _emergencyContactRelationController.text.trim(),
      );

      // 2. Register user (handles Auth, image upload, and user table insert)
      final result = await SuperbaseAuth.registerUser(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        userModel: userModel,
        profileImageFile: _pickedImage!,
      );

      if (result['success'] == true) {
        _showToast('User created successfully!');
        Navigator.of(context).pop();
      } else {
        _showToast('Error: \\${result['message']}');
      }
    } catch (e) {
      _showToast('Error: \\${e.toString()}');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KbgColor,
      appBar: AppBar(
        title: Text("Add New Team Member"),
        backgroundColor: kPrimaryColor,
        foregroundColor: kWhite,
        elevation: 1,
        iconTheme: const IconThemeData(color: kWhite),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(_firstNameController, "Enter First Name"),
              const SizedBox(height: AppConstants.defaultSpacing * 2),
              _buildTextField(_lastNameController, "Enter Last Name"),
              const SizedBox(height: AppConstants.defaultSpacing * 2),
              _buildTextEmailField(_emailController, "Enter Email Address"),
              const SizedBox(height: AppConstants.defaultSpacing * 2),
              _buildNumberField(_phoneController, "Enter Contact Number"),
              const SizedBox(height: AppConstants.defaultSpacing * 2),
              _buildDOBDateField("Select Date Of Birth", _selectedDOB,
                  (pickedDate) {
                setState(() {
                  _selectedDOB = pickedDate;
                });
              }),
              const SizedBox(height: AppConstants.defaultSpacing * 2),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Select Profile Image"),
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(AppConstants.defaultRadius),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.image, color: Colors.grey),
                          const SizedBox(width: 10),
                          Text(
                            _pickedImage != null
                                ? "Image Selected"
                                : "Tap to pick image",
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppConstants.defaultSpacing * 2),
              _buildJoinDateField("Select Join Date", _selectedJoinDate,
                  (pickedDate) {
                setState(() {
                  _selectedJoinDate = pickedDate;
                });
              }),
              const SizedBox(height: AppConstants.defaultSpacing * 2),
              _buildDesignationDateField(
                  "Select Designation Date", _selectedDesignationDate,
                  (pickedDate) {
                setState(() {
                  _selectedDesignationDate = pickedDate;
                });
              }),
              const SizedBox(height: AppConstants.defaultSpacing * 3),
              _buildTextField(_emergencyContactNameController,
                  "Enter Emergency Contact Name"),
              const SizedBox(height: AppConstants.defaultSpacing * 2),
              _buildNumberField(_emergencyContactNumberController,
                  "Enter Emergency Contact Number"),
              const SizedBox(height: AppConstants.defaultSpacing * 2),
              _buildTextField(
                  _emergencyContactRelationController, "Enter Relation ship"),
              const SizedBox(height: AppConstants.defaultSpacing * 3),
              _buildTextField(_passwordController, "Enter Password"),
              const SizedBox(height: AppConstants.defaultSpacing * 2),
              _buildDropdown(
                "Select Supervisor",
                _supervisor,
                _selectedSupervisor,
                (val) => setState(
                    () => _selectedSupervisor = val ?? "Select Supervisor"),
              ),
              const SizedBox(height: AppConstants.defaultSpacing * 2),
              _buildDropdown(
                "Select Position",
                _roles,
                _selectedRole,
                (val) => setState(() => _selectedRole = val ?? "Select Role"),
              ),
              const SizedBox(height: AppConstants.defaultSpacing * 2),
              CustomButton(
                text: 'Create User',
                onPressed: _handleSubmit,
                isLoading: _isLoading,
              ),
              const SizedBox(height: AppConstants.defaultSpacing * 2),
            ],
          ),
        ),
      ),
    );
  }

  // Image Picker Field
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      print("Picked image path: ${image.path}");
      setState(() {
        _pickedImage = File(image.path);
      });
    }
  }

  // Text Field with Requiered Validation
  Widget _buildTextField(TextEditingController? controller, String hint,
      {bool enabled = true, Widget? suffix}) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        suffixIcon: suffix,
      ),
      validator: validateRequired,
    );
  }

  // Text Feild with Email Validation
  Widget _buildTextEmailField(TextEditingController? controller, String hint,
      {bool enabled = true, Widget? suffix}) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        suffixIcon: suffix,
      ),
      validator: validateEmail,
    );
  }

  //Number Field with Number Validation
  Widget _buildNumberField(TextEditingController? controller, String hint,
      {bool enabled = true, Widget? suffix}) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        suffixIcon: suffix,
      ),
      validator: validateNumber,
    );
  }

  //DropDown with Validate
  Widget _buildDropdown(String hint, List<String> items, String? value,
      ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      hint: Text(hint),
      items:
          items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      ),
      validator: (val) {
        if (val == null ||
            val.isEmpty ||
            val == 'Select Role' ||
            val == 'Select Supervisor') {
          return 'This field is required';
        }
        return null;
      },
    );
  }

  // Text Field with DOB Validation
  Widget _buildDOBDateField(
      String label, DateTime? date, Function(DateTime) onDateSelected) {
    return GestureDetector(
      onTap: () async {
        //DateTime now = DateTime.now();
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (picked != null) {
          onDateSelected(picked);
        }
      },
      child: AbsorbPointer(
        child: TextFormField(
          decoration: InputDecoration(
            hintText: label,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            suffixIcon: const Icon(Icons.calendar_today, size: 20),
          ),
          controller: TextEditingController(
              text: date == null
                  ? ''
                  : '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}'),
          validator: (val) => val == null || val.isEmpty ? 'Required' : null,
        ),
      ),
    );
  }

  // Join Date Field with Validation
  Widget _buildJoinDateField(
      String label, DateTime? date, Function(DateTime) onDateSelected) {
    return GestureDetector(
      onTap: () async {
        //DateTime now = DateTime.now();
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2016),
          lastDate: DateTime.now(),
        );
        if (picked != null) {
          onDateSelected(picked);
        }
      },
      child: AbsorbPointer(
        child: TextFormField(
          decoration: InputDecoration(
            hintText: label,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            suffixIcon: const Icon(Icons.calendar_today, size: 20),
          ),
          controller: TextEditingController(
              text: date == null
                  ? ''
                  : '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}'),
          validator: (val) => val == null || val.isEmpty ? 'Required' : null,
        ),
      ),
    );
  }

  // Designation Date Field with Validation
  Widget _buildDesignationDateField(
      String label, DateTime? date, Function(DateTime) onDateSelected) {
    return GestureDetector(
      onTap: () async {
        //DateTime now = DateTime.now();
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2030),
        );
        if (picked != null) {
          onDateSelected(picked);
        }
      },
      child: AbsorbPointer(
        child: TextFormField(
          decoration: InputDecoration(
            hintText: label,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            suffixIcon: const Icon(Icons.calendar_today, size: 20),
          ),
          controller: TextEditingController(
              text: date == null
                  ? ''
                  : '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}'),
          validator: (val) => val == null || val.isEmpty ? 'Required' : null,
        ),
      ),
    );
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: message.toLowerCase().contains('error') ||
              message.toLowerCase().contains('failed') ||
              message.toLowerCase().contains('please')
          ? Colors.red
          : Colors.green,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }
}
