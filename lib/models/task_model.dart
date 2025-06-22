class TaskModel {
  final int? taskId;
  final String title;
  final String startDate;
  final String endDate;
  final String members; // Will store comma-separated member IDs
  final String status;
  final int pId; // Project ID

  TaskModel({
    this.taskId,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.members,
    required this.status,
    required this.pId,
  });

  Map<String, dynamic> toMap() {
    final map = {
      'title': title,
      'start_date': startDate,
      'end_date': endDate,
      'members': members,
      'status': status,
      'p_id': pId,
    };

    // Only include task_id if it's not null
    if (taskId != null) {
      map['task_id'] = taskId.toString();
    }

    return map;
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      taskId: map['task_id'] != null
          ? int.tryParse(map['task_id'].toString())
          : null,
      title: map['title'],
      startDate: map['start_date'],
      endDate: map['end_date'],
      members: map['members'],
      status: map['status'],
      pId: map['p_id'],
    );
  }
}
