import 'package:car_management_app/modals/car_expert.dart';
import 'package:car_management_app/pages/expert_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget expertCustomListTile(CarExpert carExpert, BuildContext context) {
  return ListTile(
    title: Text(
      carExpert.firstName + ' ' + carExpert.lastName,
      textScaleFactor: 1.5,
    ),
    subtitle: Text(
      carExpert.description,
    ),
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExpertPage(userId: carExpert.id),
          ));
    },
  );
}
