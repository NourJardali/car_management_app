import 'package:car_management_app/helper/database_helper.dart';
import 'package:car_management_app/modals/car_expert.dart';
import 'package:car_management_app/widgets/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class ExpertsMapPage extends StatefulWidget {
  @override
  _ExpertsMapPageState createState() => _ExpertsMapPageState();
}

class _ExpertsMapPageState extends State<ExpertsMapPage> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  final List<String> expertTypes = ['Mechanical', 'Electrical', 'Tires'];
  String _type;
  List<CarExpert> chosenExperts = [];
  GoogleMapController mapController;
  static const LatLng _center = LatLng(33.854721, 35.862285);
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  var placemark = <Placemark>[];
  LatLng _lastMapPosition = _center;
  final List<Widget> _widgets = [];

  @override
  Widget build(BuildContext context) {
    _widgets.add(displayMap());
    _widgets.add(expertTypeDropDownMenu());
    return Scaffold(
      body: Stack(
        children: _widgets,
      ),
    );
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  Widget expertTypeDropDownMenu() {
    return DropDownWidget(
      title: 'category',
      items: expertTypes,
      currentItem: _type,
      hinText: 'Category',
      itemCallBack: (String status) {
        _type = status;
        final dbFuture = databaseHelper.initializeDatabase();
        List<CarExpert> expertsList;
        chosenExperts.clear();
        dbFuture.then((database) {
          var expertsListFuture = databaseHelper.getExpertsList();
          expertsListFuture.then((experts) {
            setState(() {
              expertsList = experts;
              var count = expertsList.length;
              for (var i = 0; i < count; i++) {
                if (_type == expertsList[i].type) {
                  chosenExperts.add(expertsList[i]);
                }
              }
              _add();
            });
          });
        });
      },
    );
  }

  Widget displayMap() {
    return GoogleMap(
      initialCameraPosition: const CameraPosition(
        target: _center,
        zoom: 5.5,
      ),
      onCameraMove: _onCameraMove,
      markers: Set<Marker>.of(markers.values),
    );
  }

  Future<void> _add() async {
    setState(() {
      for (var i = 0; i < chosenExperts.length; i++) {
        var mark = Geolocator().placemarkFromAddress(chosenExperts[i].loca);
        mark.then((pm) {
          placemark.addAll(pm);
          markers.clear();
          for (final mark in placemark) {
            var markerIdVal = mark.name;
            final markerId = MarkerId(markerIdVal);
            final marker = Marker(
                markerId: markerId,
                position:
                    LatLng(mark.position.latitude, mark.position.longitude),
                infoWindow: InfoWindow(
                  title: chosenExperts[i].fName + ' ' + chosenExperts[i].lName,
                  snippet: mark.name,
                ),
                onTap: () {
                  _onMarkerTapped(markerId);
                });

            setState(() {
              markers[markerId] = marker;
              _lastMapPosition = marker.position;
            });
          }
        });
      }
    });
  }

  void _onMarkerTapped(MarkerId markerId) {}

  void check(CameraUpdate u, GoogleMapController c) async {
    c.animateCamera(u);
    mapController.animateCamera(u);
    var l1 = await c.getVisibleRegion();
    var l2 = await c.getVisibleRegion();
    print(l1.toString());
    print(l2.toString());
    if (l1.southwest.latitude == -90 || l2.southwest.latitude == -90) {
      check(u, c);
    }
  }
}
