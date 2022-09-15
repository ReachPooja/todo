import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/src/core/presentation/layout/layout.dart';
import 'package:todo/src/core/presentation/styles/styles.dart';
import 'package:todo/src/core/presentation/utils/extensions.dart';

class TodoCard extends StatefulWidget {
  const TodoCard({super.key});

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> with TickerProviderStateMixin {
  late AnimationController _controller;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Slidable(
        key: const ValueKey('value'),
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
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Todo name',
                      style: Theme.of(context).smallTitlePrimaryTextStyle,
                    ),
                    InkWell(
                      onTap: () {
                        if (isExpanded) {
                          _controller.reverse();
                        } else {
                          _controller.forward();
                        }
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                      borderRadius: Constants.circularBorderRadius,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: RotationTransition(
                          turns:
                              // ignore: prefer_int_literals
                              Tween(begin: 0.0, end: 0.5).animate(_controller),
                          child: Icon(
                            Icons.expand_more,
                            color: isExpanded ? AppColors.accentColor : null,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: Text(
                    'Todo description goes here!. And we can we gfed'
                    ' breifly',
                    style: Theme.of(context).smallBodySecondaryTextStyle,
                  ),
                ),
                verticalSpaceTiny,
                Text(
                  '22 Aug',
                  style: Theme.of(context).smallBodyTertiaryTextStyle,
                ),
                verticalSpaceSmall,
                AnimatedSwitcher(
                  duration: const Duration(
                    milliseconds: 200,
                  ),
                  transitionBuilder: (child, animation) => SizeTransition(
                    sizeFactor: animation,
                    child: FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  ),
                  child: isExpanded
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(
                            3,
                            (index) => CheckboxListTile(
                              activeColor: AppColors.accentColor,
                              contentPadding: EdgeInsets.zero,
                              controlAffinity: ListTileControlAffinity.leading,
                              visualDensity: VisualDensity.compact,
                              value: true,
                              onChanged: (value) {},
                              title: const Text('sub task'),
                            ),
                          ).toList(),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
