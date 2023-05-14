import 'package:flutter/material.dart';

import '../common/navigation.dart';
import '../ui/favorite_page.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: "favoriteButton",
      onPressed: () {
        Navigation.navigateReplace(FavoritePage.routeName);
      },
      label: const Text("Favorites"),
      icon: const Icon(Icons.favorite),
      backgroundColor: Colors.pink,
    );
  }

}
