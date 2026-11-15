import 'package:material_ui/material_ui.dart';

import '../models/componente.dart';

class DetalleScreen extends StatelessWidget {
  const DetalleScreen({super.key, required this.componente});

  final Componente componente;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle')),
      body: Center(
        child: Text('Detalle de ${componente.nombre}'),
      ),
    );
  }
}
