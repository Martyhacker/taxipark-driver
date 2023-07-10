import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxipark_driver/core/api/providers/auth_provider.dart';
import 'package:taxipark_driver/ui/widgets/main_button.dart';

class AvailibilityButton extends StatelessWidget {
  final VoidCallback onTap;
  const AvailibilityButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MainButton(
          onTap: onTap,
          text: context.watch<AuthProvider>().model?.isAvailable ?? true
              ? 'Свободный'
              : 'Не свободный',
          padding: const EdgeInsets.all(15),
        ),
      ],
    );
  }
}
