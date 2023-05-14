import 'package:flutter/material.dart';
import 'package:letsgo_food/provider/preferences_provider.dart';
import 'package:letsgo_food/theme/style.dart';
import 'package:letsgo_food/widget/favorite_button.dart';
import 'package:provider/provider.dart';

import '../widget/home_button.dart';

class SettingPage extends StatelessWidget {
  static const routeName = "/settings_page";

  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200),
        child: _buildCustomAppBar(),
      ),
      floatingActionButton: Wrap(
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.end,
        spacing: 8.0,
        children: const [
          HomeButton(),
          FavoriteButton(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            Material(
              child: Consumer<PreferencesProvider>(
                builder: (context, preferenceProvider, _) {
                  return ListTile(
                    title: const Text(
                      "Restaurant Notification",
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    subtitle: const Text(
                        "Enable notification"
                    ),
                    trailing: Switch.adaptive(
                      value: preferenceProvider.isNotificationActive,
                      onChanged: (value) {
                        preferenceProvider.setNotification(value);
                      },
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCustomAppBar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Card(
          color: accentColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              "Settings",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22
              ),
            ),
          ),
        ),
      ),
    );
  }

}
