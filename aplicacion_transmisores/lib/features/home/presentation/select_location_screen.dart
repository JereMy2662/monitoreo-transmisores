import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectLocationScreen extends StatefulWidget {
  const SelectLocationScreen({super.key});

  @override
  State<SelectLocationScreen> createState() =>
      _SelectLocationScreenState();
}

class _SelectLocationScreenState
    extends State<SelectLocationScreen> {

  LatLng posicionSeleccionada =
      const LatLng(-16.5000, -68.1500);

  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF080026),

      appBar: AppBar(
        backgroundColor:
            const Color(0xFF080026),

        elevation: 0,

        iconTheme: const IconThemeData(
          color: Colors.white,
        ),

        title: const Text(
          'Seleccionar ubicación',

          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),

      body: Stack(
        children: [

          GoogleMap(
            initialCameraPosition:
                CameraPosition(

              target:
                  posicionSeleccionada,

              zoom: 14,
            ),

            onMapCreated: (controller) {
              mapController = controller;
            },

            markers: {
              Marker(
                markerId:
                    const MarkerId('ubicacion'),

                position:
                    posicionSeleccionada,
              ),
            },

            onTap: (LatLng posicion) {

              setState(() {
                posicionSeleccionada = posicion;
              });
            },
          ),

          Positioned(
            bottom: 20,
            left: 20,
            right: 20,

            child: ElevatedButton(
              onPressed: () {

                Navigator.pop(
                  context,
                  posicionSeleccionada,
                );
              },

              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFF507DBC),

                padding:
                    const EdgeInsets.symmetric(
                  vertical: 16,
                ),

                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(
                    16,
                  ),
                ),
              ),

              child: const Text(
                'Guardar ubicación',

                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}