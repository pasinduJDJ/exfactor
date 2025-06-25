import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:exfactor/models/project_model.dart';
import 'package:exfactor/models/notification_model.dart';
import 'package:exfactor/models/task_model.dart';
import 'package:exfactor/models/task_status_request_model.dart';

class SupabaseService {
  static final SupabaseClient _client = Supabase.instance.client;

  // Project Management ////////////////////////////////////////////////////////////////////////////////////////////////////
  // INSERT PROJECT
  static Future<void> insertProject(ProjectModel project) async {
    final projectData = project.toMap();
    // Remove project_id if it's null to let database handle auto-increment
    if (projectData['project_id'] == null) {
      projectData.remove('project_id');
    }
    await _client.from('project').insert(projectData);
  }

  // GET PROJECTS (for task assignment)
  static Future<List<Map<String, dynamic>>> getProjects() async {
    final response = await _client
        .from('project')
        .select('project_id, title')
        .eq('status', 'pending'); // Only get active/pending projects

    return List<Map<String, dynamic>>.from(response);
  }

  // GET ALL PROJECTS
  static Future<List<Map<String, dynamic>>> getAllProjects() async {
    final response = await _client.from('project').select();
    return List<Map<String, dynamic>>.from(response);
  }

  // Supervisor ////////////////////////////////////////////////////////////////////////////////////////////////////
  // GET SUPERVISORS (users with supervisor role)
  static Future<List<Map<String, dynamic>>> getSupervisors() async {
    final response = await _client
        .from('user')
        .select('member_id, first_name, last_name')
        .eq('role', 'Supervisor');

    return List<Map<String, dynamic>>.from(response);
  }

  // Notification Management  ////////////////////////////////////////////////////////////////////////////////////////////////////
  // INSERT NOTIFICATION
  static Future<void> insertNotification(NotificationModel notification) async {
    final notificationData = notification.toMap();
    // Remove notification_id if it's null to let database handle auto-increment
    if (notificationData['notification_id'] == null) {
      notificationData.remove('notification_id');
    }
    await _client.from('notification').insert(notificationData);
  }

  // GET ALL NOTIFICATIONS
  static Future<List<Map<String, dynamic>>> getAllNotifications() async {
    final response = await _client.from('notification').select();
    return List<Map<String, dynamic>>.from(response);
  }

  // DELETE NOTIFICATION
  static Future<void> deleteNotification(int notificationId) async {
    await _client
        .from('notification')
        .delete()
        .eq('notification_id', notificationId);
  }

  // Task Management  ////////////////////////////////////////////////////////////////////////////////////////////////////
  // GET SUPERVISOR FOR PROJECT
  static Future<int?> getSupervisorForProject(int projectId) async {
    final response = await _client
        .from('project')
        .select('supervisor_id')
        .eq('project_id', projectId)
        .maybeSingle();
    if (response == null) return null;
    return response['supervisor_id'] is int
        ? response['supervisor_id']
        : int.tryParse(response['supervisor_id'].toString());
  }

  // INSERT TASK (auto-assign supervisor_id from project)
  static Future<void> insertTask(TaskModel task) async {
    final taskData = task.toMap();
    // Remove task_id if it's null to let database handle auto-increment
    if (taskData['task_id'] == null) {
      taskData.remove('task_id');
    }
    // Fetch supervisor_id from project if not provided
    int? supervisorId = task.supervisorId;
    if (supervisorId == null) {
      supervisorId = await getSupervisorForProject(task.pId);
      if (supervisorId != null) {
        taskData['supervisor_id'] = supervisorId;
      }
    }
    await _client.from('task').insert(taskData);
  }

  // GET ALL TASKS
  static Future<List<Map<String, dynamic>>> getAllTasks() async {
    final response = await _client.from('task').select();
    return List<Map<String, dynamic>>.from(response);
  }

  // GET TASKS FOR A PROJECT
  static Future<List<Map<String, dynamic>>> getTasksForProject(
      int projectId) async {
    final response = await _client.from('task').select().eq('p_id', projectId);
    return List<Map<String, dynamic>>.from(response);
  }

  // Technical  ////////////////////////////////////////////////////////////////////////////////////////////////////
  // GET TECHNICAL MEMBERS (users with technician role)
  static Future<List<Map<String, dynamic>>> getTechnicalMembers() async {
    final response = await _client
        .from('user')
        .select('member_id, first_name, last_name')
        .eq('role', 'Technician');

    return List<Map<String, dynamic>>.from(response);
  }

  // Users Management ////////////////////////////////////////////////////////////////////////////////////////////////////
  // GET ALL USERS
  static Future<List<Map<String, dynamic>>> getAllUsers() async {
    final response = await _client.from('user').select();
    return List<Map<String, dynamic>>.from(response);
  }

  // DELETE USER
  static Future<void> deleteUser(int userId) async {
    await _client.from('user').delete().eq('member_id', userId);
  }

  // DELETE EMERGENCY CONTACTS BY USER ID
  static Future<void> deleteEmergencyContactsByUserId(int userId) async {
    await _client.from('emergency_contact').delete().eq('u_id', userId);
  }

  // GET USER BY EMAIL
  static Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final response =
        await _client.from('user').select().eq('email', email).maybeSingle();
    if (response == null) return null;
    return Map<String, dynamic>.from(response);
  }

  // GET USER PROFILE
  static Future<PostgrestMap?> getUserProfile(int userId) async {
    return await _client.from('user').select().eq('id', userId).maybeSingle();
  }

  // INSERT USER METADATA AFTER SIGN UP
  static Future<void> insertUserMetaData(Map<String, dynamic> userData) async {
    await _client.from('user').insert(userData);
  }

  // Insert a new status change request
  static Future<void> insertStatusRequest(
      int taskId, int technicianId, String requestedStatus) async {
    final request = TaskStatusRequestModel(
      taskId: taskId,
      technicianId: technicianId,
      requestedStatus: requestedStatus,
      approved: false,
      createdAt: DateTime.now(),
    );
    await _client.from('task_status_request').insert(request.toMap());
  }

  // Get all pending status requests for a supervisor's tasks
  static Future<List<Map<String, dynamic>>> getPendingStatusRequests(
      int supervisorId) async {
    // Get all tasks for this supervisor
    final tasks = await _client
        .from('task')
        .select('task_id')
        .eq('supervisor_id', supervisorId);
    final taskIds = List<int>.from(tasks.map((t) => t['task_id']));
    if (taskIds.isEmpty) return [];
    // Get all unapproved requests for these tasks
    final requests = await _client
        .from('task_status_request')
        .select()
        .inFilter('task_id', taskIds)
        .eq('approved', false);
    return List<Map<String, dynamic>>.from(requests);
  }

  // Approve a status request and update the task's status
  static Future<void> approveStatusRequest(int requestId) async {
    // Get the request
    final request = await _client
        .from('task_status_request')
        .select()
        .eq('request_id', requestId)
        .maybeSingle();
    if (request == null) return;
    final taskId = request['task_id'];
    final requestedStatus = request['requested_status'];
    // Update the request as approved
    await _client
        .from('task_status_request')
        .update({'approved': true}).eq('request_id', requestId);
    // Update the task's status
    await _client
        .from('task')
        .update({'status': requestedStatus}).eq('task_id', taskId);
  }

  // Get a project by project_id
  static Future<Map<String, dynamic>?> getProjectById(int projectId) async {
    final response = await _client
        .from('project')
        .select()
        .eq('project_id', projectId)
        .maybeSingle();
    return response;
  }

  // Get a user by member_id
  static Future<Map<String, dynamic>?> getUserByMemberId(int memberId) async {
    final response = await _client
        .from('user')
        .select()
        .eq('member_id', memberId)
        .maybeSingle();
    return response;
  }
}
