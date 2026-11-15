import 'package:material_ui/material_ui.dart';

import '../models/componente.dart';
import '../state/app_state.dart';
import '../widgets/component_image.dart';
import '../widgets/star_rating.dart';
import 'resenas_screen.dart';

class DetalleScreen extends StatelessWidget {
  const DetalleScreen({super.key, required this.componente});

  final Componente componente;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final appState = AppStateScope.of(context);
    final isComparing = appState.isComparing(componente.id);
    final canCompare = isComparing || appState.comparisonIds.length < 3;
    final total = componente.totalResenas;
    final textoResenas = total == 1 ? '1 reseña' : '$total reseñas';

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 300,
                width: double.infinity,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ColoredBox(
                        color: scheme.surfaceContainerHighest,
                        child: ComponentImage(
                          asset: componente.imageAsset,
                          fit: BoxFit.contain,
                          errorIconSize: 48,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 16,
                      left: 16,
                      child: Material(
                        color: scheme.surface.withValues(alpha: 0.7),
                        shape: const CircleBorder(),
                        child: IconButton(
                          tooltip: 'Volver',
                          onPressed: () => Navigator.of(context).maybePop(),
                          style: IconButton.styleFrom(
                            minimumSize: const Size(40, 40),
                            padding: EdgeInsets.zero,
                          ),
                          icon: const Icon(Icons.arrow_back),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            componente.marca.toUpperCase(),
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: scheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: scheme.secondaryContainer,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            componente.subCategoria.toUpperCase(),
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: scheme.onSecondaryContainer,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      componente.nombre,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        StarRating(
                          rating: componente.promedioCalificacion,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${componente.promedioCalificacion.toStringAsFixed(1)} ($textoResenas)',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Especificaciones',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _SpecRow(
                      label: 'Precio',
                      value: '\$${componente.costo}',
                    ),
                    _SpecRow(
                      label: 'Consumo Energético',
                      value: '${componente.consumoEnergetico}W',
                    ),
                    _SpecRow(
                      label: 'Fecha de Lanzamiento',
                      value: componente.fechaLanzamiento,
                    ),
                    if (componente.socket != null)
                      _SpecRow(
                        label: 'Socket',
                        value: componente.socket!,
                      ),
                    if (componente.tipoRam != null)
                      _SpecRow(
                        label: 'Tipo de RAM',
                        value: componente.tipoRam!,
                      ),
                    if (componente.vatios != null)
                      _SpecRow(
                        label: 'Vatios',
                        value: '${componente.vatios} W',
                      ),
                    if (componente.largoMm != null)
                      _SpecRow(
                        label: 'Largo de la GPU',
                        value: '${componente.largoMm} mm',
                      ),
                    if (componente.largoMaxGpuMm != null)
                      _SpecRow(
                        label: 'Largo máximo de GPU',
                        value: '${componente.largoMaxGpuMm} mm',
                      ),
                    if (componente.socketsSoportados.isNotEmpty)
                      _SpecRow(
                        label: 'Sockets soportados',
                        value: componente.socketsSoportados.join(', '),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) =>
                                  ResenasScreen(componente: componente),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text('Ver reseñas ($total)'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: canCompare
                            ? () => appState.toggleComparison(componente.id)
                            : null,
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          isComparing
                              ? 'Quitar de comparación'
                              : 'Comparar',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class _SpecRow extends StatelessWidget {
  const _SpecRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
