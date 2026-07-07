import 'dart:math';

import 'package:flutter/material.dart';

import '../domain/transmitter.dart';
import '../data/transmitter_data.dart';

class AddTransmitterScreen extends StatefulWidget {
  const AddTransmitterScreen({super.key});

  @override
  State<AddTransmitterScreen> createState() =>
      _AddTransmitterScreenState();
}

class _AddTransmitterScreenState
    extends State<AddTransmitterScreen> {

  final nombreController =
      TextEditingController();

  String tipoSeleccionado = 'Radio';

  String generarToken() {

    const caracteres =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';

    final random = Random();

    return '${List.generate(
      4,
      (_) => caracteres[
          random.nextInt(
            caracteres.length,
          )],
    ).join()}-${List.generate(
      4,
      (_) => caracteres[
          random.nextInt(
            caracteres.length,
          )],
    ).join()}';
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF080026),

      appBar: AppBar(
        backgroundColor: const Color(0xFF080026),

        elevation: 0,

        iconTheme: const IconThemeData(
          color: Colors.white,
        ),

        title: const Text(
          'Añadir transmisor',

          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            /// NOMBRE
            const Text(
              'Nombre',

              style: TextStyle(
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 8),

            _buildInput(
              controller: nombreController,
              hint: '',
            ),

            const SizedBox(height: 20),

            /// TIPO
            const Text(
              'Tipo',

              style: TextStyle(
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 8),

            Container(
              height: 58,

              padding:
                  const EdgeInsets.symmetric(
                horizontal: 14,
              ),

              decoration: BoxDecoration(
                color: const Color(0xFF1C1C3A),

                borderRadius:
                    BorderRadius.circular(14),
              ),

              child:
                  DropdownButtonHideUnderline(
                child: DropdownButton<String>(

                  value: tipoSeleccionado,

                  isExpanded: true,

                  dropdownColor:
                      const Color(0xFF1C1C3A),

                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),

                  items: const [

                    DropdownMenuItem(
                      value: 'Radio',
                      child: Text('Radio'),
                    ),

                    DropdownMenuItem(
                      value: 'Televisión',
                      child:
                          Text('Televisión'),
                    ),
                  ],

                  onChanged: (value) {

                    setState(() {
                      tipoSeleccionado =
                          value!;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 35),

            /// BOTON
            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: () {

                  final tokenGenerado =
                      generarToken();

                  final nuevoTransmisor =
                      Transmitter(

                    nombre:
                        nombreController.text,

                    tipo:
                        tipoSeleccionado,

                    token:
                        tokenGenerado,

                    activo:
                        false,

                    fechaRegistro:
                        DateTime.now(),
                  );

                  transmisores.add(
                    nuevoTransmisor,
                  );

                  showDialog(
                    context: context,

                    builder: (_) =>
                        AlertDialog(

                      title: const Text(
                        'Transmisor registrado',
                      ),

                      content: Text(
                        'Token generado:\n\n$tokenGenerado',
                      ),

                      actions: [

                        TextButton(
                          onPressed: () {

                            Navigator.pop(
                              context,
                            );

                            Navigator.pop(
                              context,
                              true,
                            );
                          },

                          child: const Text(
                            'Aceptar',
                          ),
                        ),
                      ],
                    ),
                  );
                },

                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(
                    0xFF507DBC,
                  ),

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
                  'Añadir transmisor',

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInput({
    required TextEditingController
        controller,

    required String hint,
  }) {

    return TextField(
      controller: controller,

      keyboardType:
          TextInputType.text,

      style: const TextStyle(
        color: Colors.white,
      ),

      decoration: InputDecoration(
        hintText: hint,

        hintStyle: const TextStyle(
          color: Colors.white70,
        ),

        filled: true,

        fillColor:
            const Color(0xFF1C1C3A),

        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(14),

          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}