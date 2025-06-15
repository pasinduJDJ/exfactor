import 'dart:ui';

import 'package:exfactor/models/task_model.dart';
import 'package:flutter/material.dart';

class TechnicalUserUtils {
  static Widget buildStatusCard(String label, Color color, int count) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(count.toString().padLeft(2, '0'),
              style: const TextStyle(fontSize: 20, color: Colors.white)),
          const SizedBox(height: 4),
          Text(label,
              style: const TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  static Widget buildExpandableGroup(String title, Color color, bool expanded,
      VoidCallback onToggle, List<Task> groupTasks) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Card(
        elevation: 3,
        child: Column(
          children: [
            GestureDetector(
              onTap: onToggle,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: color, // Move color inside decoration
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                ),
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 14)),
                    Icon(
                      expanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 300),
              firstChild: Container(),
              secondChild: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: groupTasks.length,
                itemBuilder: (context, index) {
                  final task = groupTasks[index];
                  return ListTile(
                    title: Text(task.title),
                    trailing: TextButton(
                      onPressed: () {
                        // TODO: Navigate to task detail
                      },
                      child: const Text("See more.."),
                    ),
                  );
                },
              ),
              crossFadeState: expanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
            )
          ],
        ),
      ),
    );
  }
}
