import 'package:exfactor/utils/colors.dart';
import 'package:exfactor/utils/validators.dart';
import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_text_field.dart';
import '../../widgets/common/responsive_layout.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _userNameconroller = TextEditingController();
  final _dobController = TextEditingController();
  final _joinDateController = TextEditingController();
  final _designationController = TextEditingController();
  final _profileImageController = TextEditingController();
  final _emergencyContactNameController = TextEditingController();
  final _emergencyContactNumberController = TextEditingController();
  final _emergencyContactRelationController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  String _selectedRole = 'Technician';
  String _selectedSupervisor = "ABD";
  bool _isLoading = false;
  DateTime? _selectedDOB;
  DateTime? _selectedJoinDate;
  DateTime? _selectedDesignationDate;

  final List<String> _roles = ['Technician', 'Supervisor', 'Admin'];
  final List<String> _supervisour = ["ABCD", "EFGH", "IJKL"];

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _userNameconroller.dispose();
    _dobController.dispose();
    _joinDateController.dispose();
    _designationController.dispose();
    _profileImageController.dispose();
    _emergencyContactNameController.dispose();
    _emergencyContactNumberController.dispose();
    _emergencyContactRelationController.dispose();

    super.dispose();
  }

  Future<void> _selectDOB() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDOB = pickedDate;
        _dobController.text = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _selectJoinDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2016),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedJoinDate = pickedDate;
        _joinDateController.text = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _selectDesignationDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDesignationDate = pickedDate;
        _designationController.text = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  File? _pickedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _pickedImage = File(image.path);
      });
    }
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // TODO: Implement user creation logic
      await Future.delayed(const Duration(seconds: 2)); // Simulated API call
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User created successfully!')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: KbgColor,
      child: ResponsiveBuilder(
        builder: (context, constraints, info) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: info.isMobile ? double.infinity : 600,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // First Name
                      CustomTextField(
                        label: "Enter First Name",
                        controller: _firstNameController,
                        textCapitalization: TextCapitalization.words,
                        validator: validateRequired,
                      ),
                      const SizedBox(height: AppConstants.defaultSpacing * 2),
                      //Last Name
                      CustomTextField(
                        label: 'Enter Last Name',
                        controller: _lastNameController,
                        textCapitalization: TextCapitalization.words,
                        validator: validateRequired,
                      ),
                      const SizedBox(height: AppConstants.defaultSpacing * 2),
                      //User Name
                      CustomTextField(
                        label: 'Enter User Name',
                        controller: _userNameconroller,
                        textCapitalization: TextCapitalization.words,
                        validator: validateRequired,
                      ),
                      const SizedBox(height: AppConstants.defaultSpacing * 2),
                      //Email
                      CustomTextField(
                        label: 'Enter Email Address',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: validateEmail,
                      ),
                      const SizedBox(height: AppConstants.defaultSpacing * 2),
                      // Phone Number
                      CustomTextField(
                        label: 'Enter Contact Number',
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        validator: validatePhoneNumber,
                      ),
                      const SizedBox(height: AppConstants.defaultSpacing * 2),
                      // Dob
                      CustomTextField(
                        label: 'Select Date of Birth',
                        controller: _dobController,
                        onTap: _selectDOB,
                        suffixIcon: const Icon(Icons.calendar_today),
                        validator: validateRequired,
                      ),
                      const SizedBox(height: AppConstants.defaultSpacing * 2),
                      //Profile Image
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Select Profile Image"),
                          GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                              height: 50,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                    AppConstants.defaultRadius),
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
                      // Joined Date
                      CustomTextField(
                        label: 'Select Joined Date',
                        controller: _joinDateController,
                        onTap: _selectJoinDate,
                        suffixIcon: const Icon(Icons.calendar_today),
                        validator: validateRequired,
                      ),
                      const SizedBox(height: AppConstants.defaultSpacing * 2),
                      // Designation Date
                      CustomTextField(
                        label: 'Select Designation Date',
                        controller: _designationController,
                        onTap: _selectDesignationDate,
                        suffixIcon: const Icon(Icons.calendar_today),
                        validator: validateRequired,
                      ),
                      const SizedBox(height: AppConstants.defaultSpacing * 3),
                      // Emergency Contact Name
                      CustomTextField(
                        label: 'Emergency Contact Name',
                        controller: _emergencyContactNameController,
                        textCapitalization: TextCapitalization.words,
                        validator: validateRequired,
                      ),
                      const SizedBox(height: AppConstants.defaultSpacing * 2),
                      // Emergency Contact Number
                      CustomTextField(
                        label: 'Emergency Contact Number',
                        controller: _emergencyContactNumberController,
                        keyboardType: TextInputType.phone,
                        validator: validateRequired,
                      ),
                      const SizedBox(height: AppConstants.defaultSpacing * 2),
                      // Emergency Contact Relation
                      CustomTextField(
                        label: 'RelationShip',
                        controller: _emergencyContactRelationController,
                        textCapitalization: TextCapitalization.words,
                        validator: validateRequired,
                      ),
                      const SizedBox(height: AppConstants.defaultSpacing * 3),
                      // Password
                      CustomTextField(
                        label: 'Enter Password',
                        controller: _passwordController,
                        obscureText: true,
                        validator: validatePassword,
                      ),
                      const SizedBox(height: AppConstants.defaultSpacing * 2),
                      // Select Supervisor
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Select Supervisor',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          const SizedBox(
                              height: AppConstants.defaultSpacing / 2),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppConstants.defaultPadding,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey[300]!),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _selectedSupervisor,
                                isExpanded: true,
                                items: _supervisour.map((String supervisor) {
                                  return DropdownMenuItem<String>(
                                    value: supervisor,
                                    child: Text(supervisor),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    setState(
                                        () => _selectedSupervisor = newValue);
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppConstants.defaultSpacing * 2),
                      // Select Permission Type
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Select Permission Type',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          const SizedBox(
                              height: AppConstants.defaultSpacing / 2),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppConstants.defaultPadding,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                AppConstants.defaultRadius,
                              ),
                              border: Border.all(color: Colors.grey[300]!),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _selectedRole,
                                isExpanded: true,
                                items: _roles.map((String role) {
                                  return DropdownMenuItem<String>(
                                    value: role,
                                    child: Text(role),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    setState(() => _selectedRole = newValue);
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppConstants.defaultSpacing * 2),
                      CustomButton(
                        text: 'Create User',
                        onPressed: _handleSubmit,
                        isLoading: _isLoading,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
