import 'package:car_management_app/helper/database_helper.dart';
import 'package:car_management_app/modals/car_owner.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key key, this.scaffoldKey}) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController mapController;
  static const LatLng _center = LatLng(45.521563, -122.677433);
  final Set<Marker> _markers = {};
  LatLng _lastMapPosition = _center;
  SharedPreferences localStorage;

  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
          //This marker id can be anything that uniquely identifies each marker
          markerId: MarkerId(_lastMapPosition.toString()),
          position: _lastMapPosition,
          infoWindow: InfoWindow(
            title: 'Title marker',
            snippet: 'Decription marker',
          ),
          icon: BitmapDescriptor.defaultMarker,
          onTap: () {}));
      var userType = localStorage.getString('userType');
      var userId = localStorage.getInt('userId');
      var databaseHelper = DatabaseHelper();
      final dbFuture = databaseHelper.initializeDatabase();
      if (userType == 'owner') {
        List<CarOwner> ownersList;
        dbFuture.then((database) {
          var ownersListFuture = databaseHelper.getOwnersList();
          ownersListFuture.then((owners) {
            setState(() async {
              ownersList = owners;
              var count = ownersList.length;
              for (var i = 0; i < count; i++) {
                if (userId == ownersList[i].id) {
                  ownersList[i].longitude =
                      _lastMapPosition.longitude as String;
                  ownersList[i].latitude = _lastMapPosition.latitude as String;
                  var result =
                      await databaseHelper.updateCarOwner(ownersList[i]);
                  if (result != 0) {
                    // Success
                    _showAlertDialog('Status', 'Saved Successfully');
                  } else {
                    // Failure
                    _showAlertDialog('Status', 'Problem Saving');
                  }
                }
              }
            });
          });
        });
      }
    });
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: const CameraPosition(
                target: _center,
                zoom: 5.5,
              ),
              markers: _markers,
              onCameraMove: _onCameraMove,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: <Widget>[
                    FloatingActionButton(
                      onPressed: _onAddMarkerButtonPressed,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      backgroundColor: Colors.green,
                      child: const Icon(Icons.add_location, size: 36.0),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future init() async {
    localStorage = await SharedPreferences.getInstance();
  }

  void _showAlertDialog(String title, String message) {
    var alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
