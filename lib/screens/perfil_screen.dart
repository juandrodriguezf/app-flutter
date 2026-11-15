import 'package:material_ui/material_ui.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key, required this.onSignOut});

  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.person, size: 56),
            const SizedBox(height: 12),
            const Text('Perfil en construcción'),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: onSignOut,
              child: const Text('Cerrar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
