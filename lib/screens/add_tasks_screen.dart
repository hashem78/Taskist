import 'package:Taskist/cubit/task_form/task_form_cubit.dart';
import 'package:Taskist/widgets/task_day_button.dart';
import 'package:flutter/material.dart';
import 'package:Taskist/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTaskScreen extends StatelessWidget {
  final TaskFormCubit _cubit = TaskFormCubit();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskFormCubit, TaskFormState>(
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
    );
  }

  Widget buildScreen(BuildContext context, dynamic state) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 20),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            const Text(
              "New Task",
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w900,
                color: kTextColor,
              ),
              textAlign: TextAlign.center,
            ),
            for (var field in kfieldList) field,
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
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
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: buildAddButton(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAddButton(BuildContext context) => ElevatedButton(
        focusNode: FocusNode(canRequestFocus: true),
        style: ElevatedButton.styleFrom(
          elevation: 3,
          primary: Colors.blue[600],
          minimumSize: Size(
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height / 8,
          ),
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
              fontSize: 25,
            ),
          ),
        ),
        onPressed: _cubit.submit,
      );
}
// Container(
//   child: RadioPriorityRow(),
//   padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
//   margin: EdgeInsets.only(bottom: 10, top: 10),
//   decoration: BoxDecoration(
//     border: Border.all(color: Colors.grey, width: 2),
//     borderRadius: BorderRadius.all(
//       Radius.circular(10),
//     ),
//   ),
// ),
