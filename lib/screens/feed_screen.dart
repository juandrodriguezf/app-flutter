import 'package:material_ui/material_ui.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key, required this.onOpenComparador});

  final VoidCallback onOpenComparador;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Feed')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.dynamic_feed, size: 56),
            const SizedBox(height: 12),
            const Text('Feed en construcción'),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: onOpenComparador,
              child: const Text('Abrir comparador'),
            ),
          ],
        ),
      ),
    );
  }
}
