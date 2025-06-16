import 'package:flutter/material.dart';
import '../../widgets/common/custom_button.dart';
import '../../utils/colors.dart';

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
  String? _selectedTeam;
  String? _selectedSupervisor;
  DateTime? _commencementDate;
  DateTime? _deliveryDate;

  final List<String> _teamMembers = ['Team A', 'Team B', 'Team C'];
  final List<String> _supervisors = ['Supervisor 1', 'Supervisor 2'];

  Future<void> _pickDate(BuildContext context, bool isCommencement) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isCommencement) {
          _commencementDate = picked;
        } else {
          _deliveryDate = picked;
        }
      });
    }
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
              _buildDropdown('Select Team members', _teamMembers, _selectedTeam,
                  (val) => setState(() => _selectedTeam = val)),
              const SizedBox(height: 12),
              _buildDropdown(
                  'Select Supervisor',
                  _supervisors,
                  _selectedSupervisor,
                  (val) => setState(() => _selectedSupervisor = val)),
              const SizedBox(height: 12),
              _buildDateField('Select Commencement Date', _commencementDate,
                  () => _pickDate(context, true)),
              const SizedBox(height: 12),
              _buildDateField('Select Expected Delivery Date', _deliveryDate,
                  () => _pickDate(context, false)),
              const SizedBox(height: 24),
              CustomButton(
                text: 'Create Project',
                backgroundColor: kPrimaryColor,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // TODO: Handle create project
                  }
                },
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

  Widget _buildDateField(String label, DateTime? date, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
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
