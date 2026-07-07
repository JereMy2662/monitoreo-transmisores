import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {

  final DateTime loginTime;

  const ProfileScreen({
    super.key,
    required this.loginTime,
  });

  @override
  State<ProfileScreen> createState() =>
      _ProfileScreenState();
}

class _ProfileScreenState
    extends State<ProfileScreen> {

  Map<String, dynamic>? usuario;

  Timer? timer;

  String tiempoSesion = "00:00:00";

  @override
  void initState() {
    super.initState();

    cargarUsuario();

    iniciarContador();
  }

  Future<void> cargarUsuario() async {

    final uid =
        FirebaseAuth.instance.currentUser!.uid;

    final doc =
        await FirebaseFirestore.instance
            .collection("usuarios")
            .doc(uid)
            .get();

    setState(() {
      usuario = doc.data();
    });
  }

  void iniciarContador() {

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {

        final diferencia =
            DateTime.now()
                .difference(widget.loginTime);

        final horas =
            diferencia.inHours
                .toString()
                .padLeft(2, '0');

        final minutos =
            (diferencia.inMinutes % 60)
                .toString()
                .padLeft(2, '0');

        final segundos =
            (diferencia.inSeconds % 60)
                .toString()
                .padLeft(2, '0');

        setState(() {

          tiempoSesion =
              "$horas:$minutos:$segundos";
        });
      },
    );
  }

  @override
  void dispose() {

    timer?.cancel();

    super.dispose();
  }

  Widget dato(
    String titulo,
    String valor,
  ) {

    return Container(
      width: double.infinity,

      margin:
          const EdgeInsets.only(bottom: 15),

      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: const Color(0xFF121232),

        borderRadius:
            BorderRadius.circular(12),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Text(
            titulo,

            style: const TextStyle(
              color: Colors.white54,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            valor,

            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
          const Color(0xFF080026),

      appBar: AppBar(
        backgroundColor:
            const Color(0xFF080026),

        title: const Text(
          "Perfil",
          style: TextStyle(
            color: Colors.white,
          ),
        ),

        iconTheme:
            const IconThemeData(
          color: Colors.white,
        ),

        actions: [

          IconButton(
            onPressed: () async {

              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const EditProfileScreen(),
                ),
              );

              cargarUsuario();
            },

            icon: const Icon(
              Icons.edit_outlined,
            ),
          ),
        ],
      ),

      body: usuario == null

          ? const Center(
              child:
                  CircularProgressIndicator(),
            )

          : Padding(
              padding:
                  const EdgeInsets.all(20),

              child: Column(
                children: [

                  dato(
                    "Nombre",
                    usuario!["nombre"] ??
                        "",
                  ),

                  dato(
                    "ID",
                    usuario!["uid"] ??
                        "",
                  ),

                  dato(
                    "Tiempo de sesión",
                    tiempoSesion,
                  ),

                  dato(
                    "Correo",
                    usuario!["correo"] ??
                        "",
                  ),

                  dato(
                    "Teléfono",
                    usuario!["telefono"] ??
                        "",
                  ),
                ],
              ),
            ),
    );
  }
}