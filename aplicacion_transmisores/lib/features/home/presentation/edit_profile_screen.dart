import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() =>
      _EditProfileScreenState();
}

class _EditProfileScreenState
    extends State<EditProfileScreen> {

  final nombreController =
      TextEditingController();

  final correoController =
      TextEditingController();

  final telefonoController =
      TextEditingController();

  bool cargando = true;

  @override
  void initState() {
    super.initState();

    cargarDatos();
  }

  Future<void> cargarDatos() async {

    final uid =
        FirebaseAuth.instance.currentUser!.uid;

    final doc =
        await FirebaseFirestore.instance
            .collection("usuarios")
            .doc(uid)
            .get();

    final data = doc.data()!;

    nombreController.text =
        data["nombre"] ?? "";

    correoController.text =
        data["correo"] ?? "";

    telefonoController.text =
        data["telefono"] ?? "";

    setState(() {
      cargando = false;
    });
  }

  Future<void> guardar() async {

    final uid =
        FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection("usuarios")
        .doc(uid)
        .update({

      "nombre":
          nombreController.text.trim(),

      "correo":
          correoController.text.trim(),

      "telefono":
          telefonoController.text.trim(),
    });

    if (!mounted) return;

    Navigator.pop(context);
  }

  Widget campo(
    String label,
    TextEditingController controller,
  ) {

    return Padding(
      padding:
          const EdgeInsets.only(bottom: 15),

      child: TextField(
        controller: controller,

        style: const TextStyle(
          color: Colors.white,
        ),

        decoration: InputDecoration(
          labelText: label,

          labelStyle:
              const TextStyle(
            color: Colors.white70,
          ),

          filled: true,

          fillColor:
              const Color(0xFF121232),

          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(12),
          ),
        ),
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
          "Editar perfil",
          style: TextStyle(
            color: Colors.white,
          ),
        ),

        iconTheme:
            const IconThemeData(
          color: Colors.white,
        ),
      ),

      body: cargando

          ? const Center(
              child:
                  CircularProgressIndicator(),
            )

          : Padding(
              padding:
                  const EdgeInsets.all(20),

              child: Column(
                children: [

                  campo(
                    "Nombre",
                    nombreController,
                  ),

                  campo(
                    "Correo",
                    correoController,
                  ),

                  campo(
                    "Teléfono",
                    telefonoController,
                  ),

                  const Spacer(),

                  SizedBox(
                    width: double.infinity,

                    child: ElevatedButton(
                      onPressed: guardar,

                      style:
                          ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.blue,

                        minimumSize:
                            const Size(
                          double.infinity,
                          50,
                        ),
                      ),

                      child: const Text(
                        "Guardar cambios",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}