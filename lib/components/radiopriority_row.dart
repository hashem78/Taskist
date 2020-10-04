import 'package:Taskist/constants.dart';
import 'package:Taskist/models/radiopriority_model.dart';
import 'package:Taskist/models/taskpriority_model.dart';
import 'package:flutter/material.dart';
import 'package:Taskist/widgets/taskist_radio.dart';
import 'package:provider/provider.dart';

class RadioPriorityRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 8,
      ),
      child: Column(
        children: [
          const Text(
            "Priority",
            style: const TextStyle(
              color: kTextColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TaskistRadio(
                HighTaskPriorityPredicate(),
                "High",
              ),
              TaskistRadio(
                MediumTaskPriorityPredicate(),
                "Medium",
              ),
              TaskistRadio(
                LowTaskPriorityPredicate(),
                "Low",
              ),
              TaskistRadio(
                Provider.of<RadioPriorityRowModel>(context, listen: false)
                    .priority,
                "None",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
