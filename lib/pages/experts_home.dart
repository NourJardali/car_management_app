import 'package:flutter/material.dart';

import 'expert_list_page.dart';
import 'experts_map.dart';
import 'experts_profile.dart';

class ExpertsHomePage extends StatefulWidget {
  ExpertsHomePage({Key key, @required this.id}) : super(key: key);

  final int id;
  @override
  _ExpertsHomePageState createState() => _ExpertsHomePageState();
}

class _ExpertsHomePageState extends State<ExpertsHomePage> {
  int menuSelected = 0;
  static List<Widget> _options;

  void _onItemTap(int index) {
    setState(() {
      menuSelected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    _options = <Widget>[
      ExpertListPage(),
      ExpertsMapPage(),
      ExpertsProfilePage(
        userId: widget.id,
      ),
    ];

    return Material(
      child: Scaffold(
        body: Center(
          child: _options.elementAt(menuSelected),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Colors.teal),
            BottomNavigationBarItem(
                icon: Icon(Icons.map),
                label: 'Map',
                backgroundColor: Colors.teal),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
              backgroundColor: Colors.cyan,
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: menuSelected,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          iconSize: 40,
          onTap: _onItemTap,
          elevation: 5,
        ),
      ),
    );
  }
}
