import 'package:flutter/material.dart';
import 'package:letsgo_food/ui/settings_page.dart';

import '../common/navigation.dart';
import '../theme/style.dart';

class SettingButton extends StatelessWidget {
  const SettingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: "settingButton",
      onPressed: () {
        Navigation.navigateReplace(SettingPage.routeName);
      },
      label: const Text("Settings"),
      icon: const Icon(Icons.settings),
      backgroundColor: accentColor,
    );
  }

}
