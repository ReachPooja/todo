import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/src/auth/auth.dart';
import 'package:todo/src/core/presentation/layout/layout.dart';
import 'package:todo/src/core/presentation/styles/styles.dart';
import 'package:todo/todo/create_todo/view/create_todo_view.dart';

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
    controller = TabController(length: 4, vsync: this);
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
      backgroundColor: Colors.grey.shade200,
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
              indicatorWeight: 3,
              indicatorColor: AppColors.accentColor,
              labelStyle: AppTypography.mediumBodyTextStyle,
              tabs: const [
                Tab(
                  text: 'All Tasks',
                ),
                Tab(
                  text: 'Personal',
                ),
                Tab(
                  text: 'Home',
                ),
                Tab(
                  text: 'Work',
                ),
              ],
            ),
          )
        ],
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller,
          children: [
            ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: 8,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Slidable(
                  key: UniqueKey(),
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    dismissible: DismissiblePane(
                      onDismissed: () {},
                    ),
                    children: [
                      SlidableAction(
                        flex: 2,
                        onPressed: (context) {},
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        icon: Icons.done,
                        label: 'Done',
                      ),
                    ],
                  ),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    dismissible: DismissiblePane(
                      onDismissed: () {},
                    ),
                    children: [
                      SlidableAction(
                        onPressed: (context) {},
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Todo name',
                                style: AppTypography.mediumTitleTextStyle,
                              ),
                              Row(
                                children: const [
                                  Icon(
                                    Icons.calendar_today,
                                    color: AppColors.accentColor,
                                    size: 18,
                                  ),
                                  horizontalSpaceTiny,
                                  Text(
                                    '22 Aug',
                                    style: AppTypography.smallBodyTextStyle,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          verticalSpaceSmall,
                          const Text(
                            'Todo description goes here!. And we can we gfed'
                            ' breifly',
                          ),
                          verticalSpaceSmall,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Center(
              child: Text('Pending view'),
            ),
            const Center(
              child: Text('Pending view'),
            ),
            const Center(
              child: Text('Pending view'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            shape: Constants.bottomSheetRadius,
            builder: (context) => const CreateTodoView(),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

String greeting() {
  final hour = DateTime.now().hour;

  if (hour < 12 && hour > 4) {
    return 'Good Morning!';
  }
  if (hour <= 16 && hour >= 12) {
    return 'Good Afternoon!';
  }
  return 'Good Evening!';
}
