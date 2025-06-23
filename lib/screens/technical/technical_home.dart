import 'package:exfactor/models/user_model.dart';
import 'package:exfactor/utils/colors.dart';
import 'package:exfactor/widgets/utils_widget.dart';
import 'package:flutter/material.dart';

class TechnicalHome extends StatefulWidget {
  final UserModel user;
  const TechnicalHome({Key? key, required this.user}) : super(key: key);

  @override
  State<TechnicalHome> createState() => _TechnicalHomeState();
}

class _TechnicalHomeState extends State<TechnicalHome> {
  bool showPending = false;
  bool showProgress = true;
  bool showOverdue = false;
  bool showComplete = false;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> statusItems = [
      {'label': 'OVER DUE', 'count': 0, 'color': cardRed},
      {'label': 'PENDING', 'count': 5, 'color': cardYellow},
      {'label': 'ON PROGRESS', 'count': 15, 'color': cardGreen},
      {'label': 'Complete', 'count': 2, 'color': cardLightBlue},
    ];
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(children: [
        SizedBox(height: 20),
        Text('Welcome, \\${widget.user.firstName}'),
        Text('Position: \\${widget.user.role}'),
        UserUtils.buildStatusSummaryCard(statusItems),
        const SizedBox(height: 30),
      ]),
    );
  }
}
