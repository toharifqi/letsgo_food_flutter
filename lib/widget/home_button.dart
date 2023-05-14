import 'package:flutter/material.dart';
import 'package:letsgo_food/ui/list_page.dart';

import '../common/navigation.dart';
import '../theme/style.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: "homeButton",
      onPressed: () {
        Navigation.navigateReplace(ListPage.routeName);
      },
      label: const Text("Home"),
      icon: const Icon(Icons.home_rounded),
      backgroundColor: secondaryColor,
    );
  }

}
