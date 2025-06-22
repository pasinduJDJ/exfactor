import 'dart:ui';

import 'package:exfactor/models/task_model.dart';
import 'package:flutter/material.dart';

class UserUtils {
  // Summary card
  static Widget buildStatusSummaryCard(List<Map<String, dynamic>> items) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: items.map((item) {
            return Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: item['color'],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 6,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      item['count'].toString().padLeft(2, '0'),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item['label'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  )
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // Expandeble Group Widget
  // static Widget buildExpandableGroup(
  //     String title,
  //     Color color,
  //     bool expanded,
  //     VoidCallback onToggle,
  //     List<Task> groupTasks,
  //     ValueChanged<Task> onSeeMore) {
  //   return Card(
  //     elevation: 3,
  //     child: Column(
  //       children: [
  //         GestureDetector(
  //           onTap: onToggle,
  //           child: Container(
  //             width: double.infinity,
  //             decoration: BoxDecoration(
  //               color: color,
  //               borderRadius: BorderRadius.circular(12),
  //             ),
  //             padding: const EdgeInsets.all(12),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text(title,
  //                     style:
  //                         const TextStyle(color: Colors.white, fontSize: 14)),
  //                 Icon(
  //                   expanded
  //                       ? Icons.keyboard_arrow_up
  //                       : Icons.keyboard_arrow_down,
  //                   color: Colors.white,
  //                 )
  //               ],
  //             ),
  //           ),
  //         ),
  //         AnimatedCrossFade(
  //           duration: const Duration(milliseconds: 300),
  //           firstChild: Container(),
  //           secondChild: ListView.builder(
  //             shrinkWrap: true,
  //             physics: const NeverScrollableScrollPhysics(),
  //             itemCount: groupTasks.length,
  //             itemBuilder: (context, index) {
  //               final task = groupTasks[index];
  //               return ListTile(
  //                 title: Text(task.title),
  //                 trailing: TextButton(
  //                   onPressed: () => onSeeMore(task),
  //                   child: const Text("See more.."),
  //                 ),
  //               );
  //             },
  //           ),
  //           crossFadeState:
  //               expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
  //         )
  //       ],
  //     ),
  //   );
  // }

  //Static Group weight
  // static Widget buildGroup(String title, Color color, List<Task> groupTasks,
  //     ValueChanged<Task> onSeeMore) {
  //   return Card(
  //     elevation: 3,
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  //     margin: const EdgeInsets.symmetric(
  //       vertical: 8,
  //     ),
  //     child: Column(
  //       children: [
  //         Container(
  //           width: double.infinity,
  //           decoration: BoxDecoration(
  //             color: color,
  //             borderRadius:
  //                 const BorderRadius.vertical(top: Radius.circular(12)),
  //           ),
  //           padding: const EdgeInsets.all(12),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Text(
  //                 title,
  //                 style: const TextStyle(
  //                     color: Colors.white,
  //                     fontSize: 14,
  //                     fontWeight: FontWeight.bold),
  //               ),
  //             ],
  //           ),
  //         ),
  //         ListView.builder(
  //           shrinkWrap: true,
  //           physics: const NeverScrollableScrollPhysics(),
  //           itemCount: groupTasks.length,
  //           itemBuilder: (context, index) {
  //             final task = groupTasks[index];
  //             return ListTile(
  //               title: Text(task.title),
  //               trailing: TextButton(
  //                 onPressed: () => onSeeMore(task),
  //                 child: const Text("See more.."),
  //               ),
  //             );
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
