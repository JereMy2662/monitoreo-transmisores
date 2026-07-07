import 'package:flutter/material.dart';
import '../../domain/transmitter.dart';
import '../transmitter_detail_screen.dart';

class TransmitterCard extends StatelessWidget {

  final Transmitter transmitter;
  final VoidCallback onFavorite;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TransmitterCard({
    super.key,
    required this.transmitter,
    required this.onFavorite,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                TransmitterDetailScreen(
              transmitter: transmitter,
            ),
          ),
        );
      },

      child: Container(
        width: 170,

        margin: const EdgeInsets.only(
          right: 12,
        ),

        padding: const EdgeInsets.all(14),

        decoration: BoxDecoration(
          color: const Color(0xFF507DBC),

          borderRadius:
              BorderRadius.circular(18),
        ),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            /// SUPERIOR
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

              children: [

                /// ESTADO
                Icon(
                  transmitter.activo
                      ? Icons.check_circle
                      : Icons.cancel,

                  color: transmitter.activo
                      ? Colors.green
                      : Colors.red,

                  size: 22,
                ),

                /// FAVORITO
                GestureDetector(
                  onTap: onFavorite,

                  child: Icon(
                    transmitter.favorito
                        ? Icons.star
                        : Icons.star_border,

                    color: Colors.yellow,

                    size: 22,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            /// NOMBRE
            Text(
              transmitter.nombre,

              maxLines: 1,

              overflow:
                  TextOverflow.ellipsis,

              style: const TextStyle(
                color: Colors.white,

                fontWeight:
                    FontWeight.bold,

                fontSize: 15,
              ),
            ),

            const SizedBox(height: 6),

            /// TOKEN
            Text(
              transmitter.token,

              maxLines: 1,

              overflow:
                  TextOverflow.ellipsis,

              style: const TextStyle(
                color: Colors.white70,

                fontSize: 12,
              ),
            ),

            const Spacer(),

            /// INFERIOR
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

              children: [

                /// TIPO
                Icon(
                  transmitter.tipo == 'Radio'
                      ? Icons.radio
                      : Icons.tv,

                  color: Colors.white,

                  size: 22,
                ),

                /// MENU
                PopupMenuButton<String>(

                  icon: const Icon(
                    Icons.more_vert,

                    color: Colors.white,
                  ),

                  color: const Color(
                    0xFF121232,
                  ),

                  onSelected: (value) {

                    if (value == 'editar') {

                      onEdit();
                    }

                    if (value == 'eliminar') {

                      onDelete();
                    }
                  },

                  itemBuilder: (context) => [

                    PopupMenuItem(
                      value: 'editar',

                      child: Container(
                        padding:
                            const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),

                        decoration: BoxDecoration(
                          color: Colors.blue,

                          borderRadius:
                              BorderRadius.circular(
                            10,
                          ),
                        ),

                        child: const Row(
                          children: [

                            Icon(
                              Icons.edit,

                              color: Colors.white,

                              size: 18,
                            ),

                            SizedBox(width: 8),

                            Text(
                              'Editar',

                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    PopupMenuItem(
                      value: 'eliminar',

                      child: Container(
                        padding:
                            const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),

                        decoration: BoxDecoration(
                          color: Colors.red,

                          borderRadius:
                              BorderRadius.circular(
                            10,
                          ),
                        ),

                        child: const Row(
                          children: [

                            Icon(
                              Icons.delete,

                              color: Colors.white,

                              size: 18,
                            ),

                            SizedBox(width: 8),

                            Text(
                              'Eliminar',

                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}