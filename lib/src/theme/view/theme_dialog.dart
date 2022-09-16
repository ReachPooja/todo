import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/core/presentation/styles/styles.dart';
import 'package:todo/src/theme/cubit/theme_cubit.dart';

Future<void> themeDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (context) => Center(
      child: Card(
        margin: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Choose theme',
                style: AppTypography.smallTitleTextStyle,
              ),
              BlocBuilder<ThemeCubit, ThemeMode>(
                builder: (context, state) {
                  return RadioListTile<ThemeMode>(
                    value: ThemeMode.system,
                    groupValue: state,
                    activeColor: AppColors.accentColor,
                    onChanged: (value) {
                      if (value != null) {
                        context.read<ThemeCubit>().themeModeChanged(
                              value,
                            );
                      }
                    },
                    title: const Text(
                      'System default',
                    ),
                  );
                },
              ),
              BlocBuilder<ThemeCubit, ThemeMode>(
                builder: (context, state) {
                  return RadioListTile<ThemeMode>(
                    value: ThemeMode.light,
                    groupValue: state,
                    activeColor: AppColors.accentColor,
                    onChanged: (value) {
                      if (value != null) {
                        context.read<ThemeCubit>().themeModeChanged(
                              value,
                            );
                      }
                    },
                    title: const Text('Light'),
                  );
                },
              ),
              BlocBuilder<ThemeCubit, ThemeMode>(
                builder: (context, state) {
                  return RadioListTile<ThemeMode>(
                    value: ThemeMode.dark,
                    groupValue: state,
                    activeColor: AppColors.accentColor,
                    onChanged: (value) {
                      if (value != null) {
                        context.read<ThemeCubit>().themeModeChanged(
                              value,
                            );
                      }
                    },
                    title: const Text('Dark'),
                  );
                },
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    context.router.pop();
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.accentColor,
                  ),
                  child: const Text('Ok'),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
