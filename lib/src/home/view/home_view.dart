import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/app/app.dart';
import 'package:todo/src/auth/auth.dart';
import 'package:todo/src/core/presentation/styles/styles.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthBloc>().state.user;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            pinned: true,
            floating: true,
            title: Text(greeting()),
            leading: Center(
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
                child: Text(
                  user.name.isEmpty
                      ? user.email.substring(0, 1).toUpperCase()
                      : user.name.substring(0, 1).toUpperCase(),
                  style: const TextStyle(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
            bottom: TabBar(
              controller: controller,
              indicatorColor: AppColors.accentColor,
              labelStyle: AppTypography.mediumBodyTextStyle,
              tabs: const [
                Tab(
                  text: 'Ongoing',
                ),
                Tab(
                  text: 'Pending',
                ),
              ],
            ),
          )
        ],
        body: TabBarView(
          controller: controller,
          children: const [
            Center(
              child: Text('Ongoing view'),
            ),
            Center(
              child: Text('Pending view'),
            ),
          ],
        ),
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

String greeting() {
  final hour = DateTime.now().hour;

  if (hour < 12 && hour > 4) {
    return 'Good Morning!';
  }
  if (hour < 16 && hour >= 12) {
    return 'Good Afternoon!';
  }
  return 'Good Evening!';
}
