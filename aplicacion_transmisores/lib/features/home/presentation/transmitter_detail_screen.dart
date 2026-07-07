import 'package:flutter/material.dart';

import '../domain/transmitter.dart';

class TransmitterDetailScreen extends StatelessWidget {

  final Transmitter transmitter;

  const TransmitterDetailScreen({
    super.key,
    required this.transmitter,
  });

  Widget dato(
    IconData icono,
    String titulo,
    String valor,
  ) {

    return Container(
      margin: const EdgeInsets.only(
        bottom: 15,
      ),

      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: const Color(0xFF121232),

        borderRadius:
            BorderRadius.circular(15),
      ),

      child: Row(
        children: [

          Icon(
            icono,
            color: Colors.white,
          ),

          const SizedBox(width: 15),

          Expanded(
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

                const SizedBox(height: 4),

                Text(
                  valor,

                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final t = transmitter;

    return Scaffold(
      backgroundColor:
          const Color(0xFF080026),

      appBar: AppBar(
        backgroundColor:
            const Color(0xFF080026),

        iconTheme:
            const IconThemeData(
          color: Colors.white,
        ),

        title: Text(
          t.nombre,

          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),

      body: Padding(
        padding:
            const EdgeInsets.all(18),

        child: SingleChildScrollView(
          child: Column(
            children: [

              /// DATOS DEL TRANSMISOR

              dato(
                Icons.badge,
                "Nombre",
                t.nombre,
              ),

              dato(
                t.tipo == 'Radio'
                    ? Icons.radio
                    : Icons.tv,
                "Tipo",
                t.tipo,
              ),

              dato(
                Icons.key,
                "Token",
                t.token,
              ),

              dato(
                t.activo
                    ? Icons.check_circle
                    : Icons.cancel,
                "Estado",
                t.activo
                    ? "Activo"
                    : "Inactivo",
              ),

              dato(
                Icons.calendar_month,
                "Fecha de registro",
                "${t.fechaRegistro.day.toString().padLeft(2, '0')}/"
                "${t.fechaRegistro.month.toString().padLeft(2, '0')}/"
                "${t.fechaRegistro.year}",
              ),

              const SizedBox(height: 10),

              /// DATOS SNMP

              dato(
                Icons.thermostat,
                "Temperatura fuente",
                "--",
              ),

              dato(
                Icons.bolt,
                "Voltaje fuente",
                "--",
              ),

              dato(
                Icons.flash_on,
                "Potencia incidente",
                "--",
              ),

              dato(
                Icons.swap_horiz,
                "Potencia reflejada",
                "--",
              ),

              dato(
                Icons.warning_amber,
                "Estado de alarma",
                "--",
              ),

              dato(
                Icons.network_check,
                "VSWR",
                "--",
              ),

              dato(
                Icons.speed,
                "Eficiencia",
                "--",
              ),

              dato(
                Icons.access_time,
                "Última lectura",
                "--",
              ),
            ],
          ),
        ),
      ),
    );
  }
}