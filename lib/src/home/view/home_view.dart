import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo/src/auth/auth.dart';
import 'package:todo/src/core/presentation/layout/layout.dart';
import 'package:todo/src/core/presentation/styles/styles.dart';
import 'package:todo/src/home/view/widgets/todo_card.dart';
import 'package:todo/todo/create_todo/view/create_todo_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  late TabController controller;
  bool isEmpty = false;

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
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    final user = context.read<AuthBloc>().state.user;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverAppBar(
              backgroundColor: Theme.of(context).cardColor,
              pinned: true,
              floating: true,
              forceElevated: innerBoxIsScrolled,
              title: Text(
                greeting(),
                style: TextStyle(
                  color: isLightMode ? Colors.grey : null,
                ),
              ),
              leading: Center(
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                labelColor: AppColors.accentColor,
                unselectedLabelColor: Colors.grey,
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
            ),
          ),
        ],
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller,
          children: [
            if (isEmpty)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    isLightMode
                        ? 'assets/images/no_todo.svg'
                        : 'assets/images/no_todo_dark.svg',
                    height: MediaQuery.of(context).size.height / 5,
                  ),
                  verticalSpaceMedium,
                  Text(
                    'No Tasks',
                    style: AppTypography.mediumTitleTextStyle.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ],
              )
            else
              Builder(
                builder: (context) {
                  return CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverOverlapInjector(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context,
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => const TodoCard(),
                          childCount: 7,
                        ),
                      ),
                    ],
                  );
                },
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
