import 'package:flutter/material.dart';
import 'package:kitchen_memory/core/theme/theme_notifier.dart';
import 'package:kitchen_memory/views/widgets/next_button.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.read<ThemeNotifier>();

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 5),
        child: Column(
          children: [
            ReusableButton(
              label:
                  "Theme : ${context.watch<ThemeNotifier>().currentThemeName}",
              onPressed: () {
                if (themeProvider.isDark) {
                  themeProvider.setMode(AppThemeMode.light);
                } else {
                  themeProvider.setMode(AppThemeMode.dark);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
