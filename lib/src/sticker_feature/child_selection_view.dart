import 'package:flutter/material.dart';

import '../settings/settings_view.dart';
import 'child_profile.dart';
import 'sticker_selection_grid_view.dart';

/// Displays a list of SampleItems.
class ChildSelectionView extends StatelessWidget {
  const ChildSelectionView({
    super.key,
    this.items = const [
      ChildProfile(1, 'Jameson', Icons.boy),
      ChildProfile(2, 'Avery', Icons.girl_outlined),
      // SampleItem(3, 'Kid 3', Icons.child_care),
    ],
  });

  static const routeName = '/';

  final List<ChildProfile> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profiles'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),

      // To work with lists that may contain a large number of items, it’s best
      // to use the ListView.builder constructor.
      //
      // In contrast to the default ListView constructor, which requires
      // building all Widgets up front, the ListView.builder constructor lazily
      // builds Widgets as they’re scrolled into view.
      body: ListView.builder(
        // Providing a restorationId allows the ListView to restore the
        // scroll position when a user leaves and returns to the app after it
        // has been killed while running in the background.
        restorationId: 'sampleItemListView',
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];

          return ListTile(
              title: Text(item.name),
              leading: CircleAvatar(
                child: Icon(item.icon),
                //   foregroundImage: AssetImage('assets/images/flutter_logo.png'),
              ),
              onTap: () {
                // Navigate to the details page. If the user leaves and returns to
                // the app after it has been killed while running in the
                // background, the navigation stack is restored.
                Navigator.restorablePushNamed(
                    context, StickerSelectionGridView.routeName,
                    arguments: 'profile_${item.id}');
              });
        },
      ),
    );
  }
}
