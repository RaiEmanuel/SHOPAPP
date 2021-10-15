import 'dart:async';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shoapp/Address.dart';
import 'package:shoapp/connection/Connection.dart';

class RouteMyPuchases extends StatefulWidget {
  const RouteMyPuchases({Key? key}) : super(key: key);

  @override
  _RouteMyPuchasesState createState() => _RouteMyPuchasesState();
}

class _RouteMyPuchasesState extends State<RouteMyPuchases> {
  double _zoom = 0, _tilt = 0, _bearing = 0;
  LatLng _target = LatLng(-5.659460, -37.800060);
  Set<Marker> _setMarker = {};
  MapType _mapType = MapType.normal;
  Completer<GoogleMapController> _completerGoogle = Completer();
  List<Placemark> locais = [];
  Address? address;
  List<dynamic> listPurchases = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _zoom = 25;
    setState(() {
      _target = LatLng(-5.659460, -37.800060);
    });
    Connection.getAllPurchases().then(
          (value) {
        setState(() {
          listPurchases = jsonDecode(value);
        });
      },
    );
  }

  Future<List<Placemark>> getAddress(LatLng latlng) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latlng.latitude, latlng.longitude);
    return placemarks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Minhas compras", style: TextStyle(color: Colors.teal)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.teal,
          ),
          iconSize: 30,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Column(
          children: [
            /*ElevatedButton(
                onPressed: () {
                  Connection.getAllPurchases().then(
                    (value) {
                      setState(() {
                        listPurchases = jsonDecode(value);
                      });
                    },
                  );
                },
                child: Text("get")),*/
            /*Container(
              width: double.infinity,
              height: 500,
              color: Colors.teal,
              child: Column(
                children: [
                  Container(
                    height: 480,
                    width: double.infinity,
                    //color: Colors.greenAccent,
                    child: ListView.builder(
                      itemCount: locais.length,
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              title: Text(locais[index].street!),
                              subtitle: Text(locais[index].name!),
                              leading: Icon(Icons.satellite),

                              //
                              trailing: Icon(Icons.location_on),
                              onTap: () {

                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),*/
            Container(
              height: 350,
              color: Colors.greenAccent,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: listPurchases.length,
                itemBuilder: (context, index) {
                  //return Container(child: Text(listPurchases[index]['name']));
                  return ListTile(
                    onTap: () {
                      setState(() {
                        _target = LatLng(
                            double.parse(listPurchases[index]['latitude']),
                            double.parse(listPurchases[index]['longitude']));
                        getMarkers();
                        _movimentarCamera();
                      });
                    },
                    title: (listPurchases[index]['street'] == null)
                        ? Text("Desconhecido")
                        : Text(listPurchases[index]['street']),
                    subtitle: (listPurchases[index]['street'] == null)
                        ? Text("Desconhecido")
                        : Text(
                            "${listPurchases[index]['latitude']}, ${listPurchases[index]['longitude']}"),
                  );
                },
              ),
            ),
            Expanded(
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  zoom: this._zoom,
                  target: _target,
                  tilt: _tilt,
                  bearing: _bearing,
                ),
                onTap: (x) {},
                mapType: _mapType,
                zoomControlsEnabled: true,
                compassEnabled: true,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                markers: getMarkers(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Set<Marker> getMarkers() {
    Set<Marker> markers = Set<Marker>();
    setState(
      () {
        markers.add(
          Marker(
            markerId: MarkerId('current'),
            infoWindow: InfoWindow(
              title: "Local de entrega",
              //"${locais[0].street}, ${locais[0].name}, ${locais[0].subAdministrativeArea}",
            ),
            position: _target,
          ),
        );
      },
    );

    return markers;
  }

  _onMapCreated(GoogleMapController googleMapController) {
    _completerGoogle.complete(googleMapController);
  }

  _movimentarCamera() async {
    GoogleMapController googleMapController = await _completerGoogle.future;
    googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: _target, zoom: _zoom, tilt: _tilt, bearing: _bearing)));
  }
}
