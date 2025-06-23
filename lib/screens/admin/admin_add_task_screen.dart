import 'package:exfactor/utils/constants.dart';
import 'package:flutter/material.dart';
import '../../widgets/common/custom_button.dart';
import '../../utils/colors.dart';
import '../../services/superbase_service.dart';
import '../../models/task_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AdminAddTaskScreen extends StatefulWidget {
  const AdminAddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AdminAddTaskScreen> createState() => _AdminAddTaskScreenState();
}

class _AdminAddTaskScreenState extends State<AdminAddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _taskTitleController = TextEditingController();
  String? _selectedProject;
  DateTime? _commencementDate;
  DateTime? _deliveryDate;
  List<String> _selectedMembers = [];
  bool _isLoading = false;

  List<Map<String, dynamic>> _projects = [];
  List<Map<String, dynamic>> _technicalMembers = [];

  @override
  void initState() {
    super.initState();
    _loadProjects();
    _loadTechnicalMembers();
  }

  // Load projects from database
  Future<void> _loadProjects() async {
    try {
      final projects = await SupabaseService.getProjects();
      setState(() {
        _projects = projects;
      });
    } catch (e) {
      _showToast('Error loading projects: ${e.toString()}');
    }
  }

  // Load technical members from database
  Future<void> _loadTechnicalMembers() async {
    try {
      final members = await SupabaseService.getTechnicalMembers();
      setState(() {
        _technicalMembers = members;
      });
    } catch (e) {
      _showToast('Error loading technical members: ${e.toString()}');
    }
  }

  // Handle task creation
  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) {
      _showToast('Please fill all required fields.');
      return;
    }
    if (_commencementDate == null || _deliveryDate == null) {
      _showToast('Please select both commencement and delivery dates.');
      return;
    }
    if (_selectedProject == null) {
      _showToast('Please select a project.');
      return;
    }
    if (_selectedMembers.isEmpty) {
      _showToast('Please select at least one member.');
      return;
    }

    setState(() => _isLoading = true);
    try {
      // Find the selected project ID
      final selectedProject = _projects.firstWhere(
        (project) =>
            '${project['title']} (ID: ${project['project_id']})' ==
            _selectedProject,
      );
      final projectId = selectedProject['project_id'];

      final task = TaskModel(
        title: _taskTitleController.text.trim(),
        startDate: _commencementDate!.toIso8601String(),
        endDate: _deliveryDate!.toIso8601String(),
        members: _selectedMembers.join(','), // Store as comma-separated IDs
        status: 'pending', // Default status for new tasks
        pId: projectId,
      );

      await SupabaseService.insertTask(task);
      _showToast('Task created successfully!');
      Navigator.of(context).pop();
    } catch (e) {
      _showToast('Error creating task: ${e.toString()}');
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
        title: const Text('Add New Tasks',
            style: TextStyle(fontWeight: FontWeight.bold)),
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
              const SizedBox(height: 16),
              _buildTextField(_taskTitleController, 'Enter Task Title'),
              const SizedBox(height: 12),
              _buildProjectDropdown(
                  'Select Project',
                  _projects,
                  _selectedProject,
                  (val) => setState(() => _selectedProject = val)),
              const SizedBox(height: 12),
              _buildDateField('Task Commencement Date', _commencementDate,
                  () => _pickDate(context, true)),
              const SizedBox(height: 12),
              _buildDateField('Task Expected Delivery Date', _deliveryDate,
                  () => _pickDate(context, false)),
              const SizedBox(height: 12),
              _buildMembersMultiSelect(
                  'Select Members', _technicalMembers, _selectedMembers),
              const SizedBox(height: 24),
              CustomButton(
                text: 'Submit New Task',
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

  Widget _buildTextField(TextEditingController? controller, String hint,
      {bool enabled = true, Widget? suffix}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(hint),
        TextFormField(
          controller: controller,
          enabled: enabled,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            suffixIcon: suffix,
          ),
          validator: (val) => val == null || val.isEmpty ? 'Required' : null,
        )
      ],
    );
  }

  Widget _buildProjectDropdown(String hint, List<Map<String, dynamic>> items,
      String? value, ValueChanged<String?> onChanged) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(hint),
        DropdownButtonFormField<String>(
          value: value,
          items: items
              .map((e) => DropdownMenuItem(
                  value: '${e['title']} (ID: ${e['project_id']})',
                  child: Text('${e['title']} (ID: ${e['project_id']})')))
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
          validator: (val) => val == null || val.isEmpty ? 'Required' : null,
        )
      ],
    );
  }

  Widget _buildDateField(String label, DateTime? date, VoidCallback onTap) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        GestureDetector(
          onTap: onTap,
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

  Widget _buildMembersMultiSelect(String hint, List<Map<String, dynamic>> items,
      List<String> selectedMembers) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(hint, style: TextStyle(fontSize: 16, color: Colors.grey[700])),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Column(
            children: [
              // Selected members display
              if (selectedMembers.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(12),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: selectedMembers.map((memberId) {
                      final member = items.firstWhere(
                        (item) => item['member_id'].toString() == memberId,
                        orElse: () =>
                            {'first_name': 'Unknown', 'last_name': 'Member'},
                      );
                      return Chip(
                        label: Text(
                            '${member['first_name']} ${member['last_name']}'),
                        deleteIcon: const Icon(Icons.close, size: 18),
                        onDeleted: () {
                          setState(() {
                            _selectedMembers.remove(memberId);
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
              // Add member dropdown
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: DropdownButtonFormField<String>(
                  hint: Text(selectedMembers.isEmpty
                      ? 'Select members'
                      : 'Add more members'),
                  value: null,
                  items: items
                      .where((item) =>
                          !selectedMembers.contains(item['id'].toString()))
                      .map((item) => DropdownMenuItem(
                            value: item['member_id'].toString(),
                            child: Text(
                                '${item['first_name']} ${item['last_name']}'),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedMembers.add(value);
                      });
                    }
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (selectedMembers.isEmpty)
          const Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: Text(
              'Please select at least one member',
              style: TextStyle(color: Colors.orange, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
