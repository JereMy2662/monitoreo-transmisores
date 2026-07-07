import 'package:flutter/material.dart';

import 'widgets/transmitter_card.dart';

import 'widgets/section_title.dart';

import 'add_transmiter_screen.dart';

import 'edit_transmitter_screen.dart';

import 'transmitter_list_screen.dart';
import 'profile_screen.dart';

import '../data/transmitter_data.dart';

class HomeScreen extends StatefulWidget {

  final DateTime loginTime;

  const HomeScreen({
    super.key,
    required this.loginTime,
  });

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState
    extends State<HomeScreen> {

  /// ELIMINAR TRANSMISOR
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

            /// CANCELAR
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

            /// ELIMINAR
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

    final favoritos = transmisores
        .where(
          (t) => t.favorito == true,
        )
        .toList();

    return Scaffold(
      backgroundColor:
          const Color(0xFF080026),

      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.all(18),

          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                /// HEADER
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,

                  children: [

                    /// LOGO
                    Image.asset(
                      'assets/images/logo.png',

                      width: 55,
                    ),

                    /// PERFIL
GestureDetector(
  onTap: () {

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProfileScreen(
          loginTime: widget.loginTime,
        ),
      ),
    );
  },

  child: const Icon(
    Icons.person_outline,
    color: Colors.white,
    size: 30,
  ),
),
                  ],
                ),

                const SizedBox(height: 28),

                /// TITULO + BOTONES
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,

                  children: [

                    const Text(
                      'Transmisores',

                      style: TextStyle(
                        color: Colors.white,

                        fontSize: 28,

                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    Row(
                      children: [

                        /// AÑADIR
                        IconButton(
                          onPressed: () async {

                            final resultado =
                                await Navigator.push(

                              context,

                              MaterialPageRoute(
                                builder: (_) =>
                                    const AddTransmitterScreen(),
                              ),
                            );

                            if (resultado ==
                                true) {

                              setState(() {});
                            }
                          },

                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),

                        /// LISTA
                        IconButton(
                          onPressed: () async {

                            final resultado =
                                await Navigator.push(

                              context,

                              MaterialPageRoute(
                                builder: (_) =>
                                    const TransmitterListScreen(),
                              ),
                            );

                            if (resultado ==
                                true) {

                              setState(() {});
                            }
                          },

                          icon: const Icon(
                            Icons.menu,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                /// TODOS
                const SectionTitle(
                  titulo: 'Todos',
                ),

                const SizedBox(height: 10),

                SizedBox(
                  height: 170,

                  child: transmisores.isEmpty
                      ? const Center(
                          child: Text(
                            'No hay transmisores',

                            style: TextStyle(
                              color:
                                  Colors.white54,
                            ),
                          ),
                        )

                      : ListView.builder(
                          scrollDirection:
                              Axis.horizontal,

                          itemCount:
                              transmisores.length,

                          itemBuilder:
                              (context, index) {

                            final t =
                                transmisores[index];

                            return TransmitterCard(

                              transmitter: t,

                              onFavorite: () {

                                setState(() {

                                  t.favorito =
                                      !t.favorito;
                                });
                              },

                              onEdit: () async {

                                final resultado =
                                    await Navigator.push(

                                  context,

                                  MaterialPageRoute(
                                    builder: (_) =>
                                        EditTransmitterScreen(
                                      transmitter: t,
                                    ),
                                  ),
                                );

                                if (resultado ==
                                    true) {

                                  setState(() {});
                                }
                              },

                              onDelete: () {

                                eliminarTransmisor(
                                  index,
                                );
                              },
                            );
                          },
                        ),
                ),

                const SizedBox(height: 28),

                /// FAVORITOS
                const SectionTitle(
                  titulo: 'Favoritos',
                ),

                const SizedBox(height: 10),

                SizedBox(
                  height: 170,

                  child: favoritos.isEmpty
                      ? const Center(
                          child: Text(
                            'No hay favoritos',

                            style: TextStyle(
                              color:
                                  Colors.white54,
                            ),
                          ),
                        )

                      : ListView.builder(
                          scrollDirection:
                              Axis.horizontal,

                          itemCount:
                              favoritos.length,

                          itemBuilder:
                              (context, index) {

                            final t =
                                favoritos[index];

                            return TransmitterCard(

                              transmitter: t,

                              onFavorite: () {

                                setState(() {

                                  t.favorito =
                                      !t.favorito;
                                });
                              },

                              onEdit: () async {

                                final resultado =
                                    await Navigator.push(

                                  context,

                                  MaterialPageRoute(
                                    builder: (_) =>
                                        EditTransmitterScreen(
                                      transmitter: t,
                                    ),
                                  ),
                                );

                                if (resultado ==
                                    true) {

                                  setState(() {});
                                }
                              },

                              onDelete: () {

                                final realIndex =
                                    transmisores.indexOf(
                                  t,
                                );

                                eliminarTransmisor(
                                  realIndex,
                                );
                              },
                            );
                          },
                        ),
                ),

                const SizedBox(height: 28),

                /// RECIENTES
                const SectionTitle(
                  titulo: 'Recientes',
                ),

                const SizedBox(height: 10),

                SizedBox(
                  height: 170,

                  child: transmisores.isEmpty
                      ? const Center(
                          child: Text(
                            'No hay recientes',

                            style: TextStyle(
                              color:
                                  Colors.white54,
                            ),
                          ),
                        )

                      : ListView.builder(
                          scrollDirection:
                              Axis.horizontal,

                          itemCount:
                              transmisores.length,

                          itemBuilder:
                              (context, index) {

                            final t =
                                transmisores[index];

                            return TransmitterCard(

                              transmitter: t,

                              onFavorite: () {

                                setState(() {

                                  t.favorito =
                                      !t.favorito;
                                });
                              },

                              onEdit: () async {

                                final resultado =
                                    await Navigator.push(

                                  context,

                                  MaterialPageRoute(
                                    builder: (_) =>
                                        EditTransmitterScreen(
                                      transmitter: t,
                                    ),
                                  ),
                                );

                                if (resultado ==
                                    true) {

                                  setState(() {});
                                }
                              },

                              onDelete: () {

                                eliminarTransmisor(
                                  index,
                                );
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}