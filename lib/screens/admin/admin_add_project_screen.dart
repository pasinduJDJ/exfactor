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
  String? _selectedCountry;
  int? _selectedSupervisor;
  DateTime? _commencementDate;
  DateTime? _deliveryDate;
  bool _isLoading = false;
  List<Map<String, dynamic>> _supervisors = [];

  // List of all countries
  static const List<String> _countries = [
    'Afghanistan',
    'Albania',
    'Algeria',
    'Andorra',
    'Angola',
    'Antigua and Barbuda',
    'Argentina',
    'Armenia',
    'Australia',
    'Austria',
    'Azerbaijan',
    'Bahamas',
    'Bahrain',
    'Bangladesh',
    'Barbados',
    'Belarus',
    'Belgium',
    'Belize',
    'Benin',
    'Bhutan',
    'Bolivia',
    'Bosnia and Herzegovina',
    'Botswana',
    'Brazil',
    'Brunei',
    'Bulgaria',
    'Burkina Faso',
    'Burundi',
    'Cabo Verde',
    'Cambodia',
    'Cameroon',
    'Canada',
    'Central African Republic',
    'Chad',
    'Chile',
    'China',
    'Colombia',
    'Comoros',
    'Congo (Congo-Brazzaville)',
    'Costa Rica',
    'Croatia',
    'Cuba',
    'Cyprus',
    'Czechia (Czech Republic)',
    'Democratic Republic of the Congo',
    'Denmark',
    'Djibouti',
    'Dominica',
    'Dominican Republic',
    'Ecuador',
    'Egypt',
    'El Salvador',
    'Equatorial Guinea',
    'Eritrea',
    'Estonia',
    'Eswatini (fmr. "Swaziland")',
    'Ethiopia',
    'Fiji',
    'Finland',
    'France',
    'Gabon',
    'Gambia',
    'Georgia',
    'Germany',
    'Ghana',
    'Greece',
    'Grenada',
    'Guatemala',
    'Guinea',
    'Guinea-Bissau',
    'Guyana',
    'Haiti',
    'Holy See',
    'Honduras',
    'Hungary',
    'Iceland',
    'India',
    'Indonesia',
    'Iran',
    'Iraq',
    'Ireland',
    'Israel',
    'Italy',
    'Jamaica',
    'Japan',
    'Jordan',
    'Kazakhstan',
    'Kenya',
    'Kiribati',
    'Kuwait',
    'Kyrgyzstan',
    'Laos',
    'Latvia',
    'Lebanon',
    'Lesotho',
    'Liberia',
    'Libya',
    'Liechtenstein',
    'Lithuania',
    'Luxembourg',
    'Madagascar',
    'Malawi',
    'Malaysia',
    'Maldives',
    'Mali',
    'Malta',
    'Marshall Islands',
    'Mauritania',
    'Mauritius',
    'Mexico',
    'Micronesia',
    'Moldova',
    'Monaco',
    'Mongolia',
    'Montenegro',
    'Morocco',
    'Mozambique',
    'Myanmar (formerly Burma)',
    'Namibia',
    'Nauru',
    'Nepal',
    'Netherlands',
    'New Zealand',
    'Nicaragua',
    'Niger',
    'Nigeria',
    'North Korea',
    'North Macedonia',
    'Norway',
    'Oman',
    'Pakistan',
    'Palau',
    'Palestine State',
    'Panama',
    'Papua New Guinea',
    'Paraguay',
    'Peru',
    'Philippines',
    'Poland',
    'Portugal',
    'Qatar',
    'Romania',
    'Russia',
    'Rwanda',
    'Saint Kitts and Nevis',
    'Saint Lucia',
    'Saint Vincent and the Grenadines',
    'Samoa',
    'San Marino',
    'Sao Tome and Principe',
    'Saudi Arabia',
    'Senegal',
    'Serbia',
    'Seychelles',
    'Sierra Leone',
    'Singapore',
    'Slovakia',
    'Slovenia',
    'Solomon Islands',
    'Somalia',
    'South Africa',
    'South Korea',
    'South Sudan',
    'Spain',
    'Sri Lanka',
    'Sudan',
    'Suriname',
    'Sweden',
    'Switzerland',
    'Syria',
    'Tajikistan',
    'Tanzania',
    'Thailand',
    'Timor-Leste',
    'Togo',
    'Tonga',
    'Trinidad and Tobago',
    'Tunisia',
    'Turkey',
    'Turkmenistan',
    'Tuvalu',
    'Uganda',
    'Ukraine',
    'United Arab Emirates',
    'United Kingdom',
    'United States of America',
    'Uruguay',
    'Uzbekistan',
    'Vanuatu',
    'Venezuela',
    'Vietnam',
    'Yemen',
    'Zambia',
    'Zimbabwe'
  ];

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
        clientCountry: _selectedCountry ?? '',
        projectStartDate: _commencementDate!.toIso8601String(),
        projectEndDate: _deliveryDate!.toIso8601String(),
        supervisorId: _selectedSupervisor!,
        projectStatus: 'pending',
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
                  keyboardType: TextInputType.emailAddress, validator: (val) {
                if (val == null || val.isEmpty) return 'Required';
                final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
                if (!emailRegex.hasMatch(val))
                  return 'Enter a valid email address';
                return null;
              }),
              const SizedBox(height: 12),
              _buildTextField(_mobileController, 'Enter Contact  Mobile number',
                  keyboardType: TextInputType.phone, validator: (val) {
                if (val == null || val.isEmpty) return 'Required';
                final mobileRegex = RegExp(r'^(?:7|0|(?:\+94))[0-9]{9,10}$');
                if (!mobileRegex.hasMatch(val))
                  return 'Enter a valid mobile number';
                return null;
              }),
              const SizedBox(height: 12),
              const Text('Select Country'),
              DropdownButtonFormField<String>(
                value: _selectedCountry,
                items: _countries
                    .map((country) => DropdownMenuItem(
                          value: country,
                          child: Text(country),
                        ))
                    .toList(),
                onChanged: (val) => setState(() => _selectedCountry = val),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                ),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildDropdown(
                        'Select Supervisor',
                        _supervisors
                            .map((e) => {
                                  'id': e['member_id'],
                                  'name': '${e['first_name']} ${e['last_name']}'
                                })
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
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint,
      {TextInputType keyboardType = TextInputType.text,
      String? Function(String?)? validator}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(hint),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          ),
          validator: validator,
        )
      ],
    );
  }

  Widget _buildDropdown(String hint, List<Map<String, dynamic>> items,
      int? value, ValueChanged<int?> onChanged) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(hint),
      DropdownButtonFormField<int>(
        value: value,
        items: items
            .map((e) => DropdownMenuItem<int>(
                value: e['id'] as int, child: Text(e['name'])))
            .toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        ),
        validator: (val) => val == null ? 'Required' : null,
      )
    ]);
  }

  Widget _buildDateField(
      String label, DateTime? date, Function(DateTime) onDateSelected) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        GestureDetector(
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
              validator: (val) =>
                  val == null || val.isEmpty ? 'Required' : null,
            ),
          ),
        )
      ],
    );
  }
}
