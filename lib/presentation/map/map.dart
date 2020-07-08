import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';
import 'map_bloc.dart';

class MapPage extends StatefulWidget {
  @override
  State<MapPage> createState() => MapSampleState();
}

class MapSampleState extends State<MapPage> {
  GoogleMapController _controller;
  final Set<Polyline> polyline = {};
  final Set<Marker> _markers = {};
  List<LatLng> routeCoords;
  LocationData currentLocation;
  final MapBloc bloc = GetIt.instance<MapBloc>();
  var latLng = LatLng(19.1136, 72.8697);
  var destinationLatLag = LatLng(21.1136, 72.8697);

  GoogleMapPolyline googleMapPolyline =
      new GoogleMapPolyline(apiKey: "AIzaSyDme9kw3nMJil33E11ZdJHkJ-uML1HgDKk");

  @override
  void initState() {
    getCurrentLocation();
    bloc.streamController.stream.listen((data) {
      //For this demo, commented.
      //destinationLatLag = LatLng(data.restaurantLat, data.restaurantLng);
      //addMarker(destinationLatLag, data.restaurantName);
    });

    bloc.getOrderInfo();

    super.initState();
  }

  moveCamera(GoogleMapController mapController, LatLng _position) {
    mapController?.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: _position,
          zoom: 14.0,
        ),
      ),
    );
  }

  addMarker(LatLng _position, String _title) {
    _markers.add(Marker(
      // This marker id can be anything that uniquely identifies each marker.
      markerId: MarkerId(_position.toString()),
      position: _position,
      infoWindow: InfoWindow(
        title: _title,
      ),
      icon: BitmapDescriptor.defaultMarker,
    ));
  }

  // ignore: missing_return
  Future<void> getCurrentLocation() {
    var location = new Location();
    location.onLocationChanged.listen((currentLocation) {
      print(currentLocation.latitude);
      print(currentLocation.longitude);
      setState(() {
        latLng = LatLng(currentLocation.latitude, currentLocation.longitude);
        destinationLatLag = LatLng(
            latLng.latitude + 0.01, latLng.longitude + 0.01); //Random loation

        addMarker(latLng, "Current position");
        addMarker(destinationLatLag, "Destination");

        moveCamera(_controller, latLng);

        getaddressPoints();
      });
      print("get current Location:$latLng");
    });
  }

  navigateToGoogleMap() async {
    launch(
        "google.navigation:q=${destinationLatLag.latitude},${destinationLatLag.longitude}");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
          mapType: MapType.normal,
          polylines: polyline,
          initialCameraPosition: CameraPosition(target: latLng, zoom: 14.0),
          onMapCreated: onMapCreated,
          markers: _markers,
          myLocationEnabled: true,
          myLocationButtonEnabled: true),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToGoogleMap,
        label: Text(
          "Start Navigation",
          style: TextStyle(color: Colors.white),
        ),
        icon: Icon(Icons.directions, color: Colors.white),
      ),
    );
  }

  void onMapCreated(GoogleMapController controller) {
    setState(() {
      _controller = controller;
    });
  }

  getaddressPoints() async {
    print("get address points");
    routeCoords = await googleMapPolyline.getCoordinatesWithLocation(
        origin: latLng,
        destination: destinationLatLag,
        mode: RouteMode.driving);
    polyline.add(Polyline(
        polylineId: PolylineId('route1'),
        visible: true,
        points: routeCoords,
        width: 4,
        color: Colors.blue,
        startCap: Cap.roundCap,
        endCap: Cap.buttCap));
    setState(() {});
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}
