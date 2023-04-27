import 'dart:async';

import 'package:flutter/material.dart';

import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../helpers/functions.dart';
import '../../../helpers/helper_function.dart';
import '../../../helpers/styles.dart';
import '../../../models/address.dart';



class SelectMapScreen extends StatelessWidget {
  var latitude;
  var longitude;

  String detailsAddress = "";

  final Completer<GoogleMapController> _controller = Completer();
  final TextEditingController _controllertext = TextEditingController();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(locData.latitude ?? 22, locData.longitude ?? 39),
    zoom: 14.4746,
  );

  void setInitialLocation() async {
    CameraPosition cPosition = CameraPosition(
      zoom: 19,
      target: LatLng(locData.latitude ?? 33, locData.longitude ?? 29),
    );
    final GoogleMapController controller = await _controller.future;
    controller
        .animateCamera(CameraUpdate.newCameraPosition(cPosition))
        .then((value) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 270.0),
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              myLocationButtonEnabled: true,
              buildingsEnabled: true,
              compassEnabled: true,
              indoorViewEnabled: true,
              mapToolbarEnabled: true,
              rotateGesturesEnabled: true,
              scrollGesturesEnabled: true,
              tiltGesturesEnabled: true,
              trafficEnabled: true,
              zoomControlsEnabled: true,
              zoomGesturesEnabled: true,
              myLocationEnabled: true,
              onCameraMove: (object) {
                latitude = object.target.latitude;
                longitude = object.target.longitude;
                getAddresses(object.target.latitude, object.target.longitude);
              },
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                setInitialLocation();
              },
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 150),
              child: Image.asset(
                'assets/images/pin.png',
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: SizedBox(
              height: 290,
              child: Column(
                children: [
                  Container(
                    height: 150,
                    width: double.infinity,
                    margin: const EdgeInsets.all(18),
                    padding: const EdgeInsets.all(10),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/pin.png',
                              height: 20,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              "اختر موقع",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                          ],
                        ),
                        const Divider(),
                        TextField(
                          controller: _controllertext,
                          decoration: const InputDecoration(
                            hintText: 'تفاصيل العنوان',
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 2, top: 11, right: 15),
                            hintStyle: TextStyle(fontSize: 12),
                          ),
                          onChanged: (v) {},
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () async {
                      if (validate(context)) {
                        AddressModel addressModel = AddressModel(
                            label: _controllertext.text,
                            lat: latitude??34.49,
                            lng: longitude??34.49);
                        Navigator.of(context).pop(addressModel);
                      }
                    },
                    child: Container(
                      height: 45,
                      width: double.infinity,
                      color: homeColor,
                      child: const Center(
                        child: Text(
                          "تآكيد الموقع",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void getAddresses(double latitude, double longitude) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);

    _controllertext.text =
        "${placemarks[0].name},${placemarks[0].country},${placemarks[0].street}";
  }

  bool validate(context) {
    if (_controllertext.text.isEmpty) {
      HelperFunction.slt.notifyUser(
          context: context, message: "اكتب تفاصيل العنوان", color: homeColor);
      return false;
    } 
    
    // else if (latitude == null || longitude == null) {
    //   HelperFunction.slt.notifyUser(
    //       context: context,
    //       message: "اختار موقع من علي الخريطة ",
    //       color: homeColor);
    //   return false;
    // }
    
     else {
      return true;
    }
  }

  
}
