import 'package:flutter/material.dart';

import '../data/transmitter_data.dart';

import 'edit_transmitter_screen.dart';

import 'widgets/transmitter_wide_card.dart';

class TransmitterListScreen
    extends StatefulWidget {

  const TransmitterListScreen({
    super.key,
  });

  @override
  State<TransmitterListScreen>
      createState() =>
          _TransmitterListScreenState();
}

class _TransmitterListScreenState
    extends State<
        TransmitterListScreen> {

  String busqueda = '';

  String filtroTipo = 'Todos';

  /// ELIMINAR
  void eliminarTransmisor(index) {

    showDialog(
      context: context,

      builder: (context) {

        return AlertDialog(
          backgroundColor:
              const Color(0xFF121232),

          title: const Text(
            'Eliminar',

            style: TextStyle(
              color: Colors.white,
            ),
          ),

          content: const Text(
            '¿Deseas eliminar este transmisor?',

            style: TextStyle(
              color: Colors.white70,
            ),
          ),

          actions: [

            TextButton(
              onPressed: () {

                Navigator.pop(context);
              },

              child: const Text(
                'Cancelar',

                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {

                setState(() {

                  transmisores.removeAt(
                    index,
                  );
                });

                Navigator.pop(context);
              },

              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.red,
              ),

              child: const Text(
                'Eliminar',
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    final transmisoresFiltrados =
        transmisores.where((t) {

      final coincideBusqueda =
          t.nombre
              .toLowerCase()
              .contains(
                busqueda.toLowerCase(),
              );

      final coincideTipo =
          filtroTipo == 'Todos'
              ? true
              : t.tipo == filtroTipo;

      return coincideBusqueda &&
          coincideTipo;
    }).toList();

    return Scaffold(
      backgroundColor:
          const Color(0xFF080026),

      appBar: AppBar(
        backgroundColor:
            const Color(0xFF080026),

        elevation: 0,

        leading: IconButton(
          onPressed: () {

            Navigator.pop(
              context,
              true,
            );
          },

          icon: const Icon(
            Icons.arrow_back_ios_new,

            color: Colors.white,
          ),
        ),

        title: const Text(
          'Lista de transmisores',

          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),

      body: Padding(
        padding:
            const EdgeInsets.all(18),

        child: Column(
          children: [

            /// BUSCADOR
            TextField(

              onChanged: (value) {

                setState(() {

                  busqueda = value;
                });
              },

              style: const TextStyle(
                color: Colors.white,
              ),

              decoration:
                  InputDecoration(

                hintText:
                    'Buscar transmisor...',

                hintStyle:
                    const TextStyle(
                  color:
                      Colors.white54,
                ),

                prefixIcon:
                    const Icon(
                  Icons.search,
                  color:
                      Colors.white54,
                ),

                filled: true,

                fillColor:
                    const Color(
                  0xFF1C1C3A,
                ),

                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                    14,
                  ),

                  borderSide:
                      BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 15),

            /// FILTROS
            SingleChildScrollView(
              scrollDirection:
                  Axis.horizontal,

              child: Row(
                children: [

                  _filtroChip(
                    'Todos',
                  ),

                  const SizedBox(
                    width: 10,
                  ),

                  _filtroChip(
                    'Radio',
                  ),

                  const SizedBox(
                    width: 10,
                  ),

                  _filtroChip(
                    'Televisión',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            /// LISTA
            Expanded(
              child:
                  transmisoresFiltrados
                          .isEmpty

                      ? const Center(
                          child: Text(
                            'No se encontraron transmisores',

                            style:
                                TextStyle(
                              color:
                                  Colors.white54,

                              fontSize:
                                  16,
                            ),
                          ),
                        )

                      : ListView.builder(

                          itemCount:
                              transmisoresFiltrados
                                  .length,

                          itemBuilder:
                              (context,
                                  index) {

                            final t =
                                transmisoresFiltrados[
                                    index];

                            return TransmitterWideCard(

                              transmitter:
                                  t,

                              onFavorite: () {

                                setState(() {

                                  t.favorito =
                                      !t.favorito;
                                });
                              },

                              onEdit:
                                  () async {

                                final resultado =
                                    await Navigator.push(

                                  context,

                                  MaterialPageRoute(
                                    builder:
                                        (_) =>
                                            EditTransmitterScreen(
                                      transmitter:
                                          t,
                                    ),
                                  ),
                                );

                                if (resultado ==
                                    true) {

                                  setState(
                                      () {});
                                }
                              },

                              onDelete: () {

                                final indiceReal =
                                    transmisores
                                        .indexOf(
                                  t,
                                );

                                eliminarTransmisor(
                                  indiceReal,
                                );
                              },
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _filtroChip(
    String tipo,
  ) {

    final seleccionado =
        filtroTipo == tipo;

    return GestureDetector(

      onTap: () {

        setState(() {

          filtroTipo = tipo;
        });
      },

      child: Container(
        padding:
            const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),

        decoration: BoxDecoration(
          color: seleccionado
              ? const Color(
                  0xFF507DBC,
                )
              : const Color(
                  0xFF1C1C3A,
                ),

          borderRadius:
              BorderRadius.circular(
            20,
          ),
        ),

        child: Text(
          tipo,

          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}