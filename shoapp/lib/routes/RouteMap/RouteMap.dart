import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shoapp/model/Address.dart';

class RouteMap extends StatefulWidget {
  const RouteMap({Key? key}) : super(key: key);

  @override
  _RouteMapState createState() => _RouteMapState();
}

class _RouteMapState extends State<RouteMap> {
  double _zoom = 0, _tilt = 0, _bearing = 0;
  LatLng _target = LatLng(-5.659460, -37.800060);
  Set<Marker> _setMarker = {};
  MapType _mapType = MapType.normal;
  Completer<GoogleMapController> _completerGoogle = Completer();
  List<Placemark> locais = [];
  Address ? address;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _zoom = 25;
    //_listenerLocalizacao();
    _getCoordsUser();
    getAddress(_target).then((value) {
      locais = value;
      address!.latitude = _target.latitude.toString();
      address!.longitude = _target.longitude.toString();
      address!.street = locais[0].name!;
      //print("addddrrrrreesssss = ${value}");
    });
    //_listenerLocalizacao();
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
        title: Text("Cadastro de endereço"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 30,
        ),
      ),
      body: Column(
        children: [
          Container(
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
                              setState((){
                                address = Address(latitude: _target.latitude.toString(), longitude: _target.longitude.toString(), street: "${locais[index].street}, ${locais[index].name}, ${locais[index].subAdministrativeArea}");
                              });

                              Navigator.pop(context, address);
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
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
              onTap: (x) {
                print("================ apertei: ${x}");

                setState(() {

                    _target = x;
                    _movimentarCamera();
                    getAddress(_target).then(
                      (value) {
                        locais = value;
                        address = Address(latitude: x.latitude.toString(), longitude: x.longitude.toString(), street: "${locais[0].street}, ${locais[0].name}, ${locais[0].subAdministrativeArea}");
                      },
                    );

                  },
                );
              },
              mapType: _mapType,
              zoomControlsEnabled: true,
              compassEnabled: true,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              markers: getMarkers(),
            ),
          ),
          FloatingActionButton(
            child: Icon(Icons.map_sharp),
            onPressed: () {
              Navigator.pop(context, address);
              /*setState(() {
                _mapType = (_mapType == MapType.satellite)
                    ? MapType.normal
                    : MapType.satellite;
              });*/
            },
          ),
        ],
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
                title:
                    "${locais[0].street}, ${locais[0].name}, ${locais[0].subAdministrativeArea}",
                onTap: () {
                  //print("====================== Adicionado no mapa");
                }),
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

  _getCoordsUser() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    setState(() {
      _target = LatLng(position.latitude, position.longitude);
      _zoom = 25;
      _tilt = 0;
      _bearing = 0;
      _movimentarCamera();
    });
  }

/*_listenerLocalizacao() {
    Geolocator.getPositionStream(
            desiredAccuracy: LocationAccuracy.best, distanceFilter: 1)
        .listen((Position position) {
      print("xxxxxxxxxxxxxxxxxxxxx position stream: " + position.toString());

      Marker marckerUsuario = Marker(
        markerId: MarkerId("user"),
        position: LatLng(position.latitude, position.longitude),
        infoWindow: InfoWindow(title: "Endereço de entrega"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
      );

      setState(() {
        _target = LatLng(position.latitude, position.longitude);
        _zoom = 17;
        _setMarker.add(marckerUsuario);
        _movimentarCamera();

      });
      final snackBar = SnackBar(content: Text('Mudou localização: $_target'));

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }*/
}
