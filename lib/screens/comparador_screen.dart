import 'package:material_ui/material_ui.dart';

class ComparadorScreen extends StatelessWidget {
  const ComparadorScreen({super.key, required this.onOpenFeed});

  final VoidCallback onOpenFeed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Comparador')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.compare_arrows, size: 56),
            const SizedBox(height: 12),
            const Text('Comparador en construcción'),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: onOpenFeed,
              child: const Text('Volver al feed'),
            ),
          ],
        ),
      ),
    );
  }
}
