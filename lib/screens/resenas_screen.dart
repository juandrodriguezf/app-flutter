import 'package:material_ui/material_ui.dart';

import '../models/componente.dart';

class ResenasScreen extends StatelessWidget {
  const ResenasScreen({super.key, required this.componente});

  final Componente componente;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reseñas')),
      body: Center(
        child: Text('Reseñas de ${componente.nombre}'),
      ),
    );
  }
}
