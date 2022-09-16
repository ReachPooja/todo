import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:todo/app/router/router.dart';
import 'package:todo/src/auth/auth.dart';
import 'package:todo/src/core/presentation/layout/layout.dart';
import 'package:todo/src/core/presentation/styles/styles.dart';
import 'package:todo/src/home/view/widgets/todo_card.dart';
import 'package:todo/src/theme/view/theme_dialog.dart';
import 'package:todo/src/todo/create_todo/view/create_todo_view.dart';

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
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          previous.logoutStatus != current.logoutStatus,
      listener: (context, state) {
        state.logoutStatus.maybeWhen(
          loading: () {
            showDialog<void>(
              context: context,
              builder: (context) => const Material(
                color: Colors.black12,
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.accentColor,
                  ),
                ),
              ),
            );
          },
          success: () {
            context.router
                .popUntil((route) => route.settings.name == HomeRoute.name);
            context.router.replace(const StartupRoute());
          },
          orElse: () {},
        );
      },
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                pinned: true,
                floating: true,
                forceElevated: innerBoxIsScrolled,
                title: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(greeting()),
                    Text(
                      DateFormat.yMMMEd().format(
                        DateTime.now(),
                      ),
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                leading: Center(
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: user.profileUrl.isEmpty
                        ? Text(
                            user.name.isEmpty
                                ? user.email.substring(0, 1).toUpperCase()
                                : user.name.substring(0, 1).toUpperCase(),
                            style: const TextStyle(
                              color: AppColors.primaryColor,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              user.profileUrl,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ),
                actions: [
                  PopupMenuButton<String>(
                    itemBuilder: (context) {
                      return [
                        const PopupMenuItem(
                          child: Text(
                            'Completed tasks',
                          ),
                        ),
                        PopupMenuItem(
                          onTap: () {
                            Future.delayed(
                              const Duration(microseconds: 1),
                              () => themeDialog(context),
                            );
                          },
                          child: const Text(
                            'Theme mode',
                          ),
                        ),
                        PopupMenuItem(
                          onTap: () {
                            Future.delayed(
                              const Duration(microseconds: 1),
                              () => logoutDialog(context),
                            );
                          },
                          child: const Text('Logout'),
                        ),
                      ];
                    },
                  )
                ],
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
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                            context,
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) => TodoCard(
                              key: ValueKey(index),
                            ),
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

Future<void> logoutDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (context) => Center(
      child: Card(
        margin: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Are you sure?'),
              verticalSpaceSmall,
              const Text(
                'You are about to logout',
                style: AppTypography.smallBodyTextStyle,
              ),
              verticalSpaceSmall,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      context.router.pop();
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red,
                    ),
                    child: const Text('Cancel'),
                  ),
                  horizontalSpaceRegular,
                  TextButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(LoggedOut());
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.accentColor,
                    ),
                    child: const Text('Logout'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
