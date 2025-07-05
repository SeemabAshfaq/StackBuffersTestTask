import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stack_buffer_test_task/core/colors.dart';
import 'package:stack_buffer_test_task/viewmodels/setting_viewmodel.dart';
import 'package:stack_buffer_test_task/viewmodels/theme_provider.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/reusable_button.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SettingViewModel>(context, listen: false);
    
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const CustomAppBar(title: 'Settings'),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            Text('Theme', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            Row(
              children: [
                Text('Dark Mode', style: Theme.of(context).textTheme.bodyLarge),
                const Spacer(),
                Consumer<ThemeProvider>(
                  builder: (context, themeProvider, _) {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
                      child: Switch(
                        key: ValueKey(themeProvider.isDarkMode),
                        value: themeProvider.isDarkMode,
                        onChanged: (val) => themeProvider.toggleTheme(),
                        activeColor: Theme.of(context).colorScheme.secondary,
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 32),
            Text('Account', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            ReusableButton(
              backgroundColor: mainGreenColor,
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
