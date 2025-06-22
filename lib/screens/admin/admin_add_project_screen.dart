import 'package:flutter/material.dart';
import '../../widgets/common/custom_button.dart';
import '../../utils/colors.dart';
import '../../services/superbase_service.dart';
import '../../models/project_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AdminAddProjectScreen extends StatefulWidget {
  const AdminAddProjectScreen({Key? key}) : super(key: key);

  @override
  State<AdminAddProjectScreen> createState() => _AdminAddProjectScreenState();
}

class _AdminAddProjectScreenState extends State<AdminAddProjectScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _clientController = TextEditingController();
  final _contactPersonController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _countryController = TextEditingController();
  String? _selectedSupervisor;
  DateTime? _commencementDate;
  DateTime? _deliveryDate;
  bool _isLoading = false;
  List<Map<String, dynamic>> _supervisors = [];

  @override
  void initState() {
    super.initState();
    _loadSupervisors();
  }

  // Load supervisors from database
  Future<void> _loadSupervisors() async {
    try {
      final supervisors = await SupabaseService.getSupervisors();
      setState(() {
        _supervisors = supervisors;
      });
    } catch (e) {
      _showToast('Error loading supervisors: ${e.toString()}');
    }
  }

  // Handle project creation
  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) {
      _showToast('Please fill all required fields.');
      return;
    }
    if (_commencementDate == null || _deliveryDate == null) {
      _showToast('Please select both commencement and delivery dates.');
      return;
    }
    if (_selectedSupervisor == null) {
      _showToast('Please select a supervisor.');
      return;
    }

    setState(() => _isLoading = true);
    try {
      final project = ProjectModel(
        projectTitle: _titleController.text.trim(),
        projectDescription: _descController.text.trim(),
        clientName: _clientController.text.trim(),
        contactPerson: _contactPersonController.text.trim(),
        contactPersonEmail: _emailController.text.trim(),
        contactPersonPhone: _mobileController.text.trim(),
        clientCountry: _countryController.text.trim(),
        projectStartDate: _commencementDate!.toIso8601String(),
        projectEndDate: _deliveryDate!.toIso8601String(),
        supervisor: _selectedSupervisor!,
        projectStatus: 'pending', // Default status for new projects
      );

      await SupabaseService.insertProject(project);
      _showToast('Project created successfully!');
      Navigator.of(context).pop();
    } catch (e) {
      _showToast('Error creating project: ${e.toString()}');
    } finally {
      setState(() => _isLoading = false);
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KbgColor,
      appBar: AppBar(
        title: const Text('Manage Projects',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: kPrimaryColor,
        foregroundColor: kWhite,
        elevation: 1,
        iconTheme: const IconThemeData(color: kWhite),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              _buildTextField(_titleController, 'Enter Project Title'),
              const SizedBox(height: 12),
              _buildTextField(_descController, 'Enter Project Description'),
              const SizedBox(height: 12),
              _buildTextField(
                  _clientController, 'Enter Client Name or Company'),
              const SizedBox(height: 12),
              _buildTextField(
                  _contactPersonController, 'Enter Primary Contact Person'),
              const SizedBox(height: 12),
              _buildTextField(_emailController, 'Enter Contact Email',
                  keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 12),
              _buildTextField(_mobileController, 'Enter Contact  Mobile number',
                  keyboardType: TextInputType.phone),
              const SizedBox(height: 12),
              _buildTextField(_countryController, 'Enter Client Country'),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildDropdown(
                        'Select Supervisor',
                        _supervisors
                            .map((e) => '${e['first_name']} ${e['last_name']}')
                            .toList(),
                        _selectedSupervisor,
                        (val) => setState(() => _selectedSupervisor = val)),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: _loadSupervisors,
                    icon: const Icon(Icons.refresh),
                    tooltip: 'Refresh Supervisors',
                  ),
                ],
              ),
              if (_supervisors.isEmpty)
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    'No supervisors found. Please add supervisors first.',
                    style: TextStyle(color: Colors.orange, fontSize: 12),
                  ),
                ),
              const SizedBox(height: 12),
              _buildDateField('Select Commencement Date', _commencementDate,
                  (pickedDate) {
                setState(() {
                  _commencementDate = pickedDate;
                });
              }),
              const SizedBox(height: 12),
              _buildDateField('Select Expected Delivery Date', _deliveryDate,
                  (pickedDate) {
                setState(() {
                  _deliveryDate = pickedDate;
                });
              }),
              const SizedBox(height: 24),
              CustomButton(
                text: 'Create Project',
                backgroundColor: kPrimaryColor,
                onPressed: _handleSubmit,
                isLoading: _isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint,
      {TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      ),
      validator: (val) => val == null || val.isEmpty ? 'Required' : null,
    );
  }

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
      validator: (val) => val == null || val.isEmpty ? 'Required' : null,
    );
  }

  Widget _buildDateField(
      String label, DateTime? date, Function(DateTime) onDateSelected) {
    return GestureDetector(
      onTap: () async {
        //DateTime now = DateTime.now();
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2025),
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
}
