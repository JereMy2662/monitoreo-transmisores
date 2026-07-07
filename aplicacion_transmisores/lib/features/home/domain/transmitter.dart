class Transmitter {

  String nombre;

  String tipo;

  String token;

  bool activo;

  bool favorito;

  DateTime fechaRegistro;

  Transmitter({
    required this.nombre,
    required this.tipo,
    required this.token,
    required this.activo,
    required this.fechaRegistro,
    this.favorito = false,
  });
}