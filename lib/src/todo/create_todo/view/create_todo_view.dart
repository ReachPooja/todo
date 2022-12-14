import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/src/core/presentation/layout/layout.dart';
import 'package:todo/src/core/presentation/styles/typography.dart';

class CreateTodoView extends StatefulWidget {
  const CreateTodoView({super.key});

  @override
  State<CreateTodoView> createState() => _CreateTodoViewState();
}

class _CreateTodoViewState extends State<CreateTodoView> {
  DateTime? selectedDate;
  final currentDay = DateTime.now();

  late TextEditingController _dateTextController;
  late TextEditingController _categoryTextController;

  @override
  void initState() {
    super.initState();
    _dateTextController = TextEditingController();
    _categoryTextController = TextEditingController();
  }

  @override
  void dispose() {
    _dateTextController.dispose();
    _categoryTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        16,
        12,
        16,
        16 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Create Task',
                style: AppTypography.mediumTitleTextStyle,
              ),
              CloseButton(),
            ],
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Task',
            ),
          ),
          verticalSpaceRegular,
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Description',
            ),
          ),
          verticalSpaceRegular,
          TextFormField(
            readOnly: true,
            controller: _dateTextController,
            decoration: InputDecoration(
              labelText: 'Due Date',
              suffixIcon: DropdownButton<String>(
                underline: const SizedBox.shrink(),
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Today',
                    child: Text('Today'),
                  ),
                  DropdownMenuItem(
                    value: 'Tomorrow',
                    child: Text('Tomorrow'),
                  ),
                  DropdownMenuItem(
                    value: 'Pick a date',
                    child: Text('Pick a date'),
                  ),
                ],
                onChanged: (value) async {
                  if (value == 'Pick a date') {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: currentDay,
                      firstDate: currentDay,
                      lastDate: DateTime(
                        currentDay.year + 1,
                      ),
                    );
                    setState(() {
                      selectedDate = date;
                      _dateTextController.text =
                          DateFormat.yMMMd().format(date!);
                    });
                  }
                  if (value == 'Today') {
                    setState(() {
                      selectedDate = currentDay;

                      _dateTextController.text = value!;
                    });
                  }
                  if (value == 'Tomorrow') {
                    setState(() {
                      selectedDate = DateTime(
                        currentDay.year,
                        currentDay.month,
                        currentDay.day + 1,
                      );

                      _dateTextController.text = value!;
                    });
                  }
                },
              ),
            ),
          ),
          verticalSpaceRegular,
          TextFormField(
            readOnly: true,
            controller: _categoryTextController,
            decoration: InputDecoration(
              labelText: 'Category',
              suffixIcon: DropdownButton<String>(
                underline: const SizedBox.shrink(),
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Personal',
                    child: Text('Personal'),
                  ),
                  DropdownMenuItem(
                    value: 'Home',
                    child: Text('Home'),
                  ),
                  DropdownMenuItem(
                    value: 'Work',
                    child: Text('Work'),
                  ),
                  DropdownMenuItem(
                    value: 'Add new category',
                    child: Text('Add new category'),
                  ),
                ],
                onChanged: (value) {
                  if (value == 'Add new category') {
                    showDialog<void>(
                      context: context,
                      builder: (context) => Center(
                        child: Card(
                          margin: const EdgeInsets.all(20),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: 'New Category',
                                  ),
                                ),
                                verticalSpaceRegular,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.grey,
                                      ),
                                      onPressed: () {
                                        context.router.pop();
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {},
                                      child: const Text('Done'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    setState(() {
                      _categoryTextController.text = value!;
                    });
                  }
                },
              ),
            ),
          ),
          verticalSpaceRegular,
          Row(
            children: [
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add),
                label: const Text('Add subtask'),
              ),
              horizontalSpaceRegular,
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.add_task_rounded,
                  ),
                  label: const Text(
                    'Add Task',
                    style: AppTypography.mediumBodyTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
