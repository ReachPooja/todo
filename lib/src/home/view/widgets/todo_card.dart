import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/src/core/presentation/layout/layout.dart';
import 'package:todo/src/core/presentation/styles/styles.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          elevation: 0,
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
                      style: AppTypography.largeBodyTextStyle,
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
                verticalSpaceTiny,
                const Text(
                  'Todo description goes here!. And we can we gfed'
                  ' breifly',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
