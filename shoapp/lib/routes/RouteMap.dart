import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteMap extends StatefulWidget {
  const RouteMap({Key? key}) : super(key: key);

  @override
  _RouteMapState createState() => _RouteMapState();
}

class _RouteMapState extends State<RouteMap> {
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
          Text("maoa"),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  zoom: 15,
                  target: LatLng(-5.659503, -37.799962)
                )
            ),
          ),
        ],
      )
    );
  }
}
