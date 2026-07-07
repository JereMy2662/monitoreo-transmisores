import 'package:flutter/material.dart';

import '../domain/transmitter.dart';

class EditTransmitterScreen
    extends StatefulWidget {

  final Transmitter transmitter;

  const EditTransmitterScreen({
    super.key,
    required this.transmitter,
  });

  @override
  State<EditTransmitterScreen>
      createState() =>
          _EditTransmitterScreenState();
}

class _EditTransmitterScreenState
    extends State<EditTransmitterScreen> {

  late TextEditingController
      nombreController;

  late String tipoSeleccionado;

  @override
  void initState() {
    super.initState();

    nombreController =
        TextEditingController(
      text:
          widget.transmitter.nombre,
    );

    tipoSeleccionado =
        widget.transmitter.tipo;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
          const Color(0xFF080026),

      appBar: AppBar(
        backgroundColor:
            const Color(0xFF080026),

        elevation: 0,

        iconTheme:
            const IconThemeData(
          color: Colors.white,
        ),

        title: const Text(
          'Editar transmisor',

          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(20),

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
              controller:
                  nombreController,
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

              decoration:
                  BoxDecoration(
                color:
                    const Color(
                  0xFF1C1C3A,
                ),

                borderRadius:
                    BorderRadius.circular(
                  14,
                ),
              ),

              child:
                  DropdownButtonHideUnderline(
                child:
                    DropdownButton<String>(

                  value:
                      tipoSeleccionado,

                  isExpanded: true,

                  dropdownColor:
                      const Color(
                    0xFF1C1C3A,
                  ),

                  style:
                      const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),

                  items: const [

                    DropdownMenuItem(
                      value: 'Radio',
                      child:
                          Text('Radio'),
                    ),

                    DropdownMenuItem(
                      value:
                          'Televisión',
                      child: Text(
                          'Televisión'),
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

            const SizedBox(height: 20),

            /// TOKEN
            const Text(
              'Token',

              style: TextStyle(
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 8),

            Container(
              width: double.infinity,

              padding:
                  const EdgeInsets.all(
                16,
              ),

              decoration:
                  BoxDecoration(
                color:
                    const Color(
                  0xFF1C1C3A,
                ),

                borderRadius:
                    BorderRadius.circular(
                  14,
                ),
              ),

              child: Text(
                widget.transmitter.token,

                style:
                    const TextStyle(
                  color:
                      Colors.white,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 35),

            /// BOTON
            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: () {

                  widget.transmitter.nombre =
                      nombreController.text;

                  widget.transmitter.tipo =
                      tipoSeleccionado;

                  Navigator.pop(
                    context,
                    true,
                  );
                },

                style:
                    ElevatedButton
                        .styleFrom(
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
                  'Guardar cambios',

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
  }) {

    return TextField(
      controller: controller,

      style: const TextStyle(
        color: Colors.white,
      ),

      decoration: InputDecoration(
        filled: true,

        fillColor:
            const Color(0xFF1C1C3A),

        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            14,
          ),

          borderSide:
              BorderSide.none,
        ),
      ),
    );
  }
}