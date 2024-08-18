import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:movie_app/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';

class MapWidget extends StatelessWidget {

  ProfileBloc bloc;
  static const routeName = 'map_widget';

  MapWidget({super.key,required this.bloc});


  @override
  Widget build(BuildContext context) {
    final Completer<GoogleMapController> initcontroller = Completer<GoogleMapController>();
    void mapCreator (GoogleMapController controller){
      initcontroller.complete(controller);
    }
    List <Marker> marker = [];
    List <LatLng> points = [];
    ///map render
    return BlocBuilder(
      bloc: bloc,
      builder: (context, state) {
      if(state is PermissionSuccess){

      ///this condition make map in initial mode
      if(state.lat == 0 && state.lon == 0){
        marker = [];
        points = [];
      } else{
        marker = [
          Marker(
              markerId: const MarkerId('local point'),
              position: LatLng(state.locationData.latitude!,state.locationData.longitude!),
          ),
          Marker(
              markerId: const MarkerId('destination point'),
              position: LatLng(state.lat,state.lon),
          ),
        ];
        points = [
          LatLng(state.lat, state.lon),
          LatLng(state.locationData.latitude!, state.locationData.longitude!),
        ];
      }

      ///changePosition of Camera
      goToCurrentLocation () async{
        final GoogleMapController controller = await initcontroller.future;
        controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(state.locationData.latitude!,state.locationData.longitude!),zoom: 16 ),
         ),
        );
      }

      ///draw a polyline for user
      final Polyline polyline = Polyline(
        color: Colors.blueAccent,
        width: 2,
        polylineId: const PolylineId('userPolyLine'),
        points: points
      );

      ///userMap render
      return Scaffold(
        body: GoogleMap(
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          polylines: {polyline},
          onTap: (argument) {
            // BlocProvider.of<ProfileBloc>(context).add(GetUserLocation(lat: argument.latitude, lon: argument.longitude));
            bloc.add(GetUserLocation(lat: argument.latitude, lon: argument.longitude));
          },
          trafficEnabled: true,
          buildingsEnabled: true,
          onMapCreated: mapCreator,
          initialCameraPosition: CameraPosition(
            target: LatLng(state.locationData.latitude!,state.locationData.longitude!),
            zoom: 10,
          ),
          markers: Set<Marker>.from(marker),
       ),

        ///receive current lat and lon
        floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            bloc.add(GetUserLocation(
                lat: state.locationData.latitude! , lon: state.locationData.longitude!));
            goToCurrentLocation();
          },
          label: const Icon(Icons.location_history),
          backgroundColor: Colors.white,
        ),
      );
    }
         return Container();
  },
);
  }
}
