import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stack_buffer_test_task/core/colors.dart';
import 'package:stack_buffer_test_task/viewmodels/setting_viewmodel.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/reusable_button.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SettingViewModel>(context, listen: false);
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: const CustomAppBar(title: 'Settings'),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            Text('Account', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            ReusableButton(
              text: 'Logout',
              onPressed: () async {
                await provider.logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
