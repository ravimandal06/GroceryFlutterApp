import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vender/user/screen/checkout.dart';

class LocationEdit extends StatefulWidget {
  const LocationEdit({Key? key}) : super(key: key);

  @override
  State<LocationEdit> createState() => _LocationEditState();
}

class _LocationEditState extends State<LocationEdit> {
  String? _currentAddress;
  Position? _currentPosition;
  final TextEditingController _addressController = TextEditingController();

  final GlobalKey<FormState> formKey_ = GlobalKey<FormState>();

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
    GetStorage().write('address', _currentPosition);
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.locality}, ${place.administrativeArea}, ${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

//
  void getLocation() {
    _addressController.text = _currentAddress ?? "";
    GetStorage().write('_address', _addressController.text);
  }

// ...

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Location Page")),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Form(
            key: formKey_,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('LATITUTE: ${_currentPosition?.latitude ?? ""}'),
                  Text('LONGITUTE: ${_currentPosition?.longitude ?? ""}'),
                  Text('ADDRESS: ${_currentAddress ?? ""}'),
                  const SizedBox(height: 32),
                  const SizedBox(height: 26.0),
                  const Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                          height: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "Additional",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 26.0),
                  TextFormField(
                    controller: _addressController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Address',
                      hintText: 'Enter your full street address',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2.0,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your full street address';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        // _name = value;
                      });
                    },
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      _getCurrentPosition;
                      getLocation();
                    },
                    child: const Text("Tap to Get Current Location"),
                  ),
                  const SizedBox(height: 232),
                  SizedBox(
                    width: 600,
                    height: 45,
                    child: FilledButton.tonal(
                      onPressed: () {
                        if (formKey_.currentState!.validate()) {
                          // Form is valid, process the data
                          // For example, save it to a database

                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')));
                          GetStorage()
                              .write('address', _addressController.text);
                          print(_addressController.text);
                          Get.to(() => const CheckOut());
                        }
                      },
                      child: const Text('Continue'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
