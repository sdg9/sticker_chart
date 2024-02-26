// import 'package:flutter/material.dart';

// /// Displays detailed information about a SampleItem.
// class SampleItemDetailsView extends StatelessWidget {
//   const SampleItemDetailsView({super.key});

//   static const routeName = '/sample_item';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Stickers'),
//       ),
//       body: GridView.builder(
//         padding: const EdgeInsets.all(10.0),
//         itemCount: 20, // replace with your actual item count
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 5, // number of items in a row
//           crossAxisSpacing: 10.0,
//           mainAxisSpacing: 10.0,
//         ),
//         itemBuilder: (BuildContext context, int index) {
//           return GestureDetector(
//             onTap: () {
//               Navigator.pushNamed(context,
//                   '/new_page'); // replace '/new_page' with your actual route
//             },
//             child: Container(
//               color:
//                   Colors.blue, // replace with your actual item color or image
//               child: const Center(
//                 child: Text('Item'), // replace with your actual item widget
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// /// Displays detailed information about a SampleItem.
// class SampleItemDetailsView extends StatefulWidget {
//   const SampleItemDetailsView({super.key});

//   static const routeName = '/sample_item';

//   @override
//   _SampleItemDetailsViewState createState() => _SampleItemDetailsViewState();
// }

// class _SampleItemDetailsViewState extends State<SampleItemDetailsView> {
//   final List<IconData> _selectedIcons = List.filled(20, Icons.add);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Stickers'),
//       ),
//       body: GridView.builder(
//         padding: const EdgeInsets.all(10.0),
//         itemCount: 20,
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 5,
//           crossAxisSpacing: 10.0,
//           mainAxisSpacing: 10.0,
//         ),
//         itemBuilder: (BuildContext context, int index) {
//           return GestureDetector(
//             onTap: () async {
//               final IconData? selectedIcon = await showDialog<IconData>(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return SimpleDialog(
//                     title: const Text('Select icon'),
//                     children: <Widget>[
//                       ListTile(
//                         leading: const Icon(Icons.home),
//                         title: const Text('Home'),
//                         onTap: () {
//                           Navigator.pop(context, Icons.home);
//                         },
//                       ),
//                       ListTile(
//                         leading: const Icon(Icons.school),
//                         title: const Text('School'),
//                         onTap: () {
//                           Navigator.pop(context, Icons.school);
//                         },
//                       ),
//                       // Add more icons here
//                     ],
//                   );
//                 },
//               );

//               if (selectedIcon != null) {
//                 setState(() {
//                   _selectedIcons[index] = selectedIcon;
//                 });
//               }
//             },
//             child: Container(
//               color: Colors.blue,
//               child: Center(
//                 child: Icon(_selectedIcons[index]),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class SampleItemDetailsView extends StatefulWidget {
//   const SampleItemDetailsView({super.key});

//   static const routeName = '/sample_item';

//   @override
//   _SampleItemDetailsViewState createState() => _SampleItemDetailsViewState();
// }
class SampleItemDetailsView extends StatefulWidget {
  final String profileId;

  const SampleItemDetailsView({super.key, required this.profileId});

  static const routeName = '/sample_item';

  @override
  _SampleItemDetailsViewState createState() => _SampleItemDetailsViewState();
}

class _SampleItemDetailsViewState extends State<SampleItemDetailsView> {
  final List<IconData> _selectedIcons = List.filled(20, Icons.add);

  @override
  void initState() {
    super.initState();
    _loadSelections();
  }

  // Future<void> _loadSelections() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     for (int i = 0; i < _selectedIcons.length; i++) {
  //       _selectedIcons[i] = IconData(
  //           prefs.getInt('icon_$i') ?? Icons.add.codePoint,
  //           fontFamily: 'MaterialIcons');
  //     }
  //   });
  // }

  // Future<void> _saveSelection(int index, IconData icon) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setInt('icon_$index', icon.codePoint);
  // }
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
