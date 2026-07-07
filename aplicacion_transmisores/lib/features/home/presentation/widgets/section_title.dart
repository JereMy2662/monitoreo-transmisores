import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String titulo;

  const SectionTitle({
    super.key,
    required this.titulo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        titulo,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}