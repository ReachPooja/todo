import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo/src/core/presentation/layout/spacing.dart';

class CreateTodoView extends StatelessWidget {
  const CreateTodoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create todo'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.done),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
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
                onTap: () async {
                  final value = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(
                      const Duration(days: 30),
                    ),
                  );
                  log(value.toString());
                },
                decoration: const InputDecoration(
                  labelText: 'Dates',
                  suffixIcon: Icon(
                    Icons.calendar_today_outlined,
                  ),
                ),
              ),
              verticalSpaceRegular,
              DropdownButtonFormField<String>(
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                ),
                items: List.generate(
                  status.length,
                  (index) => DropdownMenuItem(
                    value: status[index],
                    child: Text(status[index]),
                  ),
                ),
                onChanged: (value) {},
                decoration: const InputDecoration(
                  labelText: 'Status',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final status = [
  'Todo',
  'In progress',
  'Done',
];
