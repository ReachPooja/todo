import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:todo/app/app.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Home view'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.router.push(const CreateTodoRoute());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
