import 'package:flutter/material.dart';
import 'package:todo/src/core/presentation/styles/styles.dart';

Future<void> skipDialog(
  BuildContext context, {
  required bool isDarkMode,
}) async {
  await showDialog<void>(
    context: context,
    barrierColor: isDarkMode
        ? Colors.white.withOpacity(0.4)
        : Colors.black.withOpacity(0.4),
    builder: (context) => Center(
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Note!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Text(
                "We won't be able to save your data "
                'if you skip the authentication process',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(
                      primary: Colors.red,
                    ),
                    child: const Text(
                      'Cancel',
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      primary: AppColors.primaryColor,
                    ),
                    child: const Text(
                      'Continue',
                    ),
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
