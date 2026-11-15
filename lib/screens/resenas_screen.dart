import 'package:material_ui/material_ui.dart';

import '../data/sample_data.dart';
import '../models/componente.dart';
import '../models/resena.dart';
import '../state/app_state.dart';
import '../widgets/component_image.dart';
import '../widgets/review_item_card.dart';
import '../widgets/star_rating.dart';

class ResenasScreen extends StatefulWidget {
  const ResenasScreen({super.key, required this.componente});

  final Componente componente;

  @override
  State<ResenasScreen> createState() => _ResenasScreenState();
}

class _ResenasScreenState extends State<ResenasScreen> {
  String _selectedSource = 'Todas';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final appState = AppStateScope.of(context);
    final todas = resenasDe(widget.componente.id)
        .where((resena) => !appState.isHidden(resena.id))
        .toList(growable: false);
    final filtradas = _selectedSource == 'Todas'
        ? todas
        : todas
            .where((resena) => resena.fuente == _selectedSource)
            .toList(growable: false);
    final promedio = _promedio(todas);
    final distribucion = _distribucion(todas);
    final fuentes = fuentesDe(widget.componente.id);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.only(bottom: 32),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      tooltip: 'Volver',
                      onPressed: () => Navigator.of(context).maybePop(),
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: ComponentImage(
                            asset: widget.componente.imageAsset,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.componente.marca,
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: scheme.onSurfaceVariant,
                              ),
                            ),
                            Text(
                              widget.componente.nombre,
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                StarRating(
                                  rating: promedio,
                                  size: 16,
                                  emptyColor: Colors.grey,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  promedio.toStringAsFixed(1),
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: scheme.primary,
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    ' · ${todas.length} ${todas.length == 1 ? 'reseña' : 'reseñas'}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: scheme.onSurfaceVariant,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: fuentes.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final fuente = fuentes[index];
                  return _SourceChip(
                    label: fuente,
                    selected: fuente == _selectedSource,
                    onTap: () {
                      setState(() => _selectedSource = fuente);
                    },
                  );
                },
              ),
            ),
            Card(
              margin: const EdgeInsets.all(16),
              elevation: 0,
              color: scheme.surfaceContainerHighest.withValues(alpha: 0.3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: List<Widget>.generate(5, (index) {
                        final progress = distribucion[index];
                        final rating = 5 - index;
                        final barHeight = progress == 0 ? 4.0 : 80 * progress;
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 80,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  width: 40,
                                  height: barHeight,
                                  decoration: BoxDecoration(
                                    color: progress > 0
                                        ? scheme.primary
                                        : scheme.outline.withValues(alpha: 0.3),
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(4),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '$rating★',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: scheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${todas.length} ${todas.length == 1 ? 'reseña' : 'reseñas'}',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => _showMessage(
                    'Escritura de reseñas no disponible en la demo.',
                  ),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Escribir una reseña'),
                ),
              ),
            ),
            const SizedBox(height: 8),
            if (filtradas.isEmpty)
              Padding(
                padding: const EdgeInsets.all(32),
                child: Center(
                  child: Text(
                    'No hay reseñas de esta fuente.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ),
              )
            else
              ...filtradas.map(
                (resena) => ReviewItemCard(
                  resena: resena,
                  canModify: resena.authorId == demoUserId,
                  onEdit: () => _showMessage(
                    'Edición de reseñas no disponible en la demo.',
                  ),
                  onDelete: () => _confirmDelete(resena),
                  onAuthorTap: () => _showMessage(
                    'Perfil de ${resena.nombreUsuario} no disponible en la demo.',
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  double _promedio(List<Resena> resenas) {
    if (resenas.isEmpty) {
      return 0;
    }
    final total = resenas.fold<int>(
      0,
      (sum, resena) => sum + resena.calificacion,
    );
    return total / resenas.length;
  }

  List<double> _distribucion(List<Resena> resenas) {
    if (resenas.isEmpty) {
      return List<double>.filled(5, 0);
    }
    return List<double>.generate(5, (index) {
      final rating = 5 - index;
      final cantidad =
          resenas.where((resena) => resena.calificacion == rating).length;
      return cantidad / resenas.length;
    });
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _confirmDelete(Resena resena) async {
    final appState = AppStateScope.read(context);
    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('¿Eliminar esta reseña?'),
        content: const Text(
          'Esta acción no se puede deshacer y afecta el promedio del componente.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(
              'Eliminar',
              style: TextStyle(
                color: Theme.of(dialogContext).colorScheme.error,
              ),
            ),
          ),
        ],
      ),
    );

    if (!mounted) {
      return;
    }

    if (confirm == true) {
      appState.hideReview(resena.id);
    }
  }
}

class _SourceChip extends StatelessWidget {
  const _SourceChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? scheme.primary : scheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(
            color: selected ? scheme.onPrimary : scheme.onSurfaceVariant,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
