import 'package:car_management_app/helper/database_helper.dart';
import 'package:car_management_app/modals/car_expert.dart';
import 'package:car_management_app/widgets/customappbar.dart';
import 'package:car_management_app/widgets/dropdown.dart';
import 'package:car_management_app/widgets/expert_custom_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ExpertListPage extends StatefulWidget {
  @override
  _ExpertListPageState createState() => _ExpertListPageState();
}

class _ExpertListPageState extends State<ExpertListPage> {
  bool checkBoxValue = false;
  double _height;
  double _width;
  DatabaseHelper databaseHelper = DatabaseHelper();
  final List<String> expertTypes = ['Mechanical', 'Electrical', 'Tires'];
  String _type;
  final _widgets = <Widget>[];

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: _height,
        width: _width,
        margin: EdgeInsets.only(bottom: 5),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Opacity(opacity: 0.88, child: CustomAppBar()),
              expertTypeDropDownMenu(),
              expertListTile(),
            ],
          ),
        ),
      ),
    );
  }

  Widget expertListTile() {
    return Column(
      children: _widgets,
    );
  }

  Widget expertTypeDropDownMenu() {
    return DropDownWidget(
      title: 'category',
      items: expertTypes,
      currentItem: _type,
      hinText: 'Category',
      itemCallBack: (String status) {
        _type = status;
        setState(() {
          final dbFuture = databaseHelper.initializeDatabase();
          List<CarExpert> expertsList;
          _widgets.clear();
          dbFuture.then((database) {
            var expertsListFuture = databaseHelper.getExpertsList();
            expertsListFuture.then((experts) {
              setState(() {
                expertsList = experts;
                var count = expertsList.length;
                String email;
                FirebaseAuth.instance.currentUser().then((value) {
                  email = value.email;
                  for (var i = 0; i < count; i++) {
                    if (_type == expertsList[i].type &&
                        expertsList[i].emailAdd != email) {
                      _widgets
                          .add(expertCustomListTile(expertsList[i], context));
                    }
                  }
                });
              });
            });
          });
        });
      },
    );
  }
}
