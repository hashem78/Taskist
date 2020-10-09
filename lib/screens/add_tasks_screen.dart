import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Taskist/constants.dart';
import 'package:Taskist/cubit/task_form/task_form_cubit.dart';
import 'package:Taskist/models/task_predicate.dart';
import 'package:Taskist/widgets/task_day_button.dart';
import 'package:Taskist/widgets/taskist_radio.dart';

class AddTaskScreen extends StatelessWidget {
  final TaskFormCubit _cubit = TaskFormCubit();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kprimaryDarkColor,
        title: const Text(
          "New Task",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: kTextColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: BlocConsumer<TaskFormCubit, TaskFormState>(
        cubit: _cubit,
        builder: (context, state) {
          if (state is TaskFormInitial) {
            return buildScreen(context, state);
          } else if (state is TaskFormUpdate) {
            return buildScreen(context, state);
          } else if (state is TaskFormSubmitted) {
            Navigator.of(context).pop(state.taskFormModel);
            //return Container();
          }
          return Container();
        },
        listener: (context, state) {},
      ),
    );
  }

  Widget buildScreen(BuildContext context, dynamic state) {
    return Material(
      //height: MediaQuery.of(context).size.height,
      color: kprimaryDarkColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (var field in kfieldList) field,
          OutLinedContainer(
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
                buildRadioRow(state),
              ],
            ),
          ),
          OutLinedContainer(
            child: Column(
              children: [
                const Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: const Text(
                    "Repeat on",
                    style: const TextStyle(
                      color: kTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (int i = 0; i < 7; ++i)
                      TaskDayButton(
                        title: kdayTitles[i],
                        isActive: state.taskFormModel.repeats[i],
                        onTap: () => _cubit.updateDayButtons(i),
                      ),
                  ],
                ),
              ],
            ),
          ),
          buildAddButton(context),
        ],
      ),
    );
  }

  Row buildRadioRow(state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TaskistRadio(
          groupValue: state.taskFormModel.priorityPredicate,
          taskPriority: HighTaskPriorityPredicate(),
          title: "High",
          onChanged: (predicate) => _cubit.updatePredicate(predicate),
        ),
        TaskistRadio(
          groupValue: state.taskFormModel.priorityPredicate,
          taskPriority: MediumTaskPriorityPredicate(),
          title: "Medium",
          onChanged: (predicate) => _cubit.updatePredicate(predicate),
        ),
        TaskistRadio(
          groupValue: state.taskFormModel.priorityPredicate,
          taskPriority: LowTaskPriorityPredicate(),
          title: "Low",
          onChanged: (predicate) => _cubit.updatePredicate(predicate),
        ),
        TaskistRadio(
          groupValue: state.taskFormModel.priorityPredicate,
          taskPriority: NoPriorityPredicate(),
          title: "None",
          onChanged: (predicate) => _cubit.updatePredicate(predicate),
        ),
      ],
    );
  }

  Widget buildAddButton(BuildContext context) => Align(
        alignment: Alignment.bottomCenter,
        child: ElevatedButton(
          focusNode: FocusNode(canRequestFocus: true),
          style: ElevatedButton.styleFrom(
            elevation: 3,
            primary: Colors.blue[600],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: const Text(
              "Add Task",
              style: const TextStyle(
                color: kTextColor,
                fontSize: 15,
              ),
            ),
          ),
          onPressed: _cubit.submit,
        ),
      );
}

class OutLinedContainer extends StatelessWidget {
  final Widget child;
  const OutLinedContainer({this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 2),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
    );
  }
}
