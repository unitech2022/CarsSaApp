import 'dart:async';

import 'package:carsa/bloc/address_cubit/address_cubit.dart';
import 'package:carsa/helpers/constants.dart';
import 'package:carsa/helpers/styles.dart';
import 'package:carsa/models/address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../helpers/functions.dart';

class MapScreen extends StatelessWidget {
  var latitude;
  var longitude;

  String lable = "";
  String detailsAddress = "";
  int status;
  int addressId;
  Address address;

  bool loading = false;

  MapScreen(
      {this.latitude,
      this.longitude,
      required this.lable,
      required this.detailsAddress,
      required this.addressId,
      required this.status,
      required this.address});

  double lat = 0.0;
  double lng = 0.0;
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
    printFunction("lable$lable");
    _controllertext.text = lable;
    return BlocConsumer<AddressCubit, AddressState>(
      listener: (context, state) {
        if (state is MoveMapState) {
          _controllertext.text = state.address;
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              GoogleMap(
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
                onCameraIdle: () {
                  AddressCubit.get(context)
                      .getLocationAddress(latitude, longitude);
                },
                onCameraMove: (object) {
                  latitude = object.target.latitude;
                  longitude = object.target.longitude;
                },
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                  setInitialLocation();
                },
              ),
              Center(
                child: Image.asset(
                  'assets/images/pin.png',
                  height: 40,
                  fit: BoxFit.cover,
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
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
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
                      AddressCubit.get(context).loadChangAddress ||
                              AddressCubit.get(context).loadMoveing
                          ? const SizedBox(
                              height: 46,
                              width: 46,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: homeColor,
                                  strokeWidth: 3,
                                ),
                              ),
                            )
                          : MaterialButton(
                              onPressed: () async {
                                if (status == 1) {
                                  Address newAddress = Address(
                                      id: addressId,
                                      userId: address.userId!,
                                      lable: _controllertext.text,
                                      lat: latitude,
                                      lng: longitude,
                                      createdAt: address.createdAt);
                                  AddressCubit.get(context)
                                      .updateAddress(newAddress)
                                      .then((value) {
                                    AddressCubit.get(context).getAddresses();
                                    pop(context);
                                  });
                                } else {
                                  Address newAddress = Address(
                                      userId: currentUser.id,
                                      lable: _controllertext.text,
                                      lat: latitude,
                                      lng: longitude,
                                      createdAt: address.createdAt);
                                  AddressCubit.get(context)
                                      .addAddress(newAddress)
                                      .then((value) {
                                    AddressCubit.get(context).getAddresses();
                                    pop(context);
                                  });
                                }
                                //
                                // if(lable == ""){
                                //   HelperFunctions.slt.notifyUser(
                                //       context: context,
                                //       message: "اكتب اسم العنوان".tr(),
                                //       color: Colors.black45);
                                //
                                // }else
                                // {
                                //   // await _addressProvider.addAddress(state,context: context,lable:lable,lat: latitude,lng: longitude);
                                // }
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
      },
    );
  }

  void getAddresses(double latitude, double longitude) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);

    _controllertext.text =
        "${placemarks[0].name},${placemarks[0].country},${placemarks[0].street}";
  }
}
