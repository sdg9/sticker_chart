import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StickerSelectionGridView extends StatefulWidget {
  final String profileId;

  const StickerSelectionGridView({super.key, required this.profileId});

  static const routeName = '/sticker_selection';

  @override
  _StickerSelectionGridViewState createState() =>
      _StickerSelectionGridViewState();
}

class _StickerSelectionGridViewState extends State<StickerSelectionGridView> {
  final List<IconData> _selectedIcons = List.filled(20, Icons.add);

  @override
  void initState() {
    super.initState();
    _loadSelections();
  }

  Future<void> _loadSelections() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      for (int i = 0; i < _selectedIcons.length; i++) {
        _selectedIcons[i] = IconData(
            prefs.getInt('icon_${widget.profileId}_$i') ?? Icons.add.codePoint,
            fontFamily: 'MaterialIcons');
      }
    });
  }

  Future<void> _saveSelection(int index, IconData icon) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('icon_${widget.profileId}_$index', icon.codePoint);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stickers'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: 20,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () async {
              final IconData? selectedIcon = await showDialog<IconData>(
                context: context,
                builder: (BuildContext context) {
                  return SimpleDialog(
                    title: const Text('Select icon'),
                    children: <Widget>[
                      ListTile(
                        leading: const Icon(Icons.home),
                        title: const Text('Home'),
                        onTap: () {
                          Navigator.pop(context, Icons.home);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.school),
                        title: const Text('School'),
                        onTap: () {
                          Navigator.pop(context, Icons.school);
                        },
                      ),
                      // Add more icons here
                    ],
                  );
                },
              );

              if (selectedIcon != null) {
                setState(() {
                  _selectedIcons[index] = selectedIcon;
                });
                _saveSelection(index, selectedIcon);
              }
            },
            child: Container(
              color: Colors.blue,
              child: Center(
                child: Icon(_selectedIcons[index]),
              ),
            ),
          );
        },
      ),
    );
  }
}
