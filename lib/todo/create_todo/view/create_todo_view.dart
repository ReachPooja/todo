import 'package:flutter/material.dart';
import 'package:todo/src/core/presentation/layout/layout.dart';
import 'package:todo/src/core/presentation/styles/typography.dart';

class CreateTodoView extends StatefulWidget {
  const CreateTodoView({super.key});

  @override
  State<CreateTodoView> createState() => _CreateTodoViewState();
}

class _CreateTodoViewState extends State<CreateTodoView> {
  DateTime? selectedDate;

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
              labelText: 'Todo',
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
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(
                        DateTime.now().year + 1,
                      ),
                    );
                    setState(() {
                      selectedDate = date;
                      _dateTextController.text = date!.toIso8601String();
                    });
                  }
                  if (value == 'Today') {
                    setState(() {
                      selectedDate = DateTime.now();

                      _dateTextController.text = value!;
                    });
                  }
                  if (value == 'Tomorrow') {
                    setState(() {
                      selectedDate = DateTime.now();
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
                    value: 'All',
                    child: Text('All'),
                  ),
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
                ],
                onChanged: (value) {
                  setState(() {
                    _categoryTextController.text = value!;
                  });
                },
              ),
            ),
          ),
          verticalSpaceRegular,
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.add_task_rounded,
            ),
            label: const Text(
              'Add Task',
              style: AppTypography.mediumBodyTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
