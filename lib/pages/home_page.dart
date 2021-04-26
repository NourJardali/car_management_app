import 'package:car_management_app/pages/expert_list_page.dart';
import 'package:car_management_app/pages/experts_map.dart';
import 'package:car_management_app/pages/owner_profile.dart';
import 'package:flutter/material.dart';

class OwnerHomePage extends StatefulWidget {
  OwnerHomePage({Key key, @required this.id}) : super(key: key);

  final int id;

  @override
  _OwnerHomePageState createState() => _OwnerHomePageState();
}

class _OwnerHomePageState extends State<OwnerHomePage> {
  _OwnerHomePageState();

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
      OwnerProfilePage(
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
