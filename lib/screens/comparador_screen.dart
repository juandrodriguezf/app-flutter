import 'package:material_ui/material_ui.dart';

import '../data/sample_data.dart';
import '../models/componente.dart';
import '../state/app_state.dart';

const _comparisonLabels = <String>[
  'Precio',
  'Consumo',
  'Calificación',
  'Reseñas',
  r'Valor por $100',
  'Categoría',
  'Lanzamiento',
];

double _valorNumerico(Componente componente) {
  return componente.promedioCalificacion / componente.costo * 100;
}

class ComparadorScreen extends StatelessWidget {
  const ComparadorScreen({super.key, required this.onOpenFeed});

  final VoidCallback onOpenFeed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final appState = AppStateScope.of(context);
    final componentes = appState.comparisonIds
        .map(componentePorId)
        .whereType<Componente>()
        .toList(growable: false);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 12, 20, 8),
              child: Row(
                children: [
                  IconButton(
                    tooltip: 'Volver',
                    onPressed: onOpenFeed,
                    icon: const Icon(Icons.arrow_back),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Comparador',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Compara hasta 3 componentes lado a lado.',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: scheme.primaryContainer,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      '${componentes.length}/3',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: scheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: componentes.isEmpty
                  ? _ComparadorEmpty(onOpenFeed: onOpenFeed)
                  : SingleChildScrollView(
                      child: _ComparadorTable(
                        componentes: componentes,
                        onRemove: appState.removeComparison,
                        onClear: appState.clearComparison,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ComparadorEmpty extends StatelessWidget {
  const _ComparadorEmpty({required this.onOpenFeed});

  final VoidCallback onOpenFeed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.compare_arrows,
              size: 56,
              color: scheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              'Sin componentes para comparar',
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Agrega componentes desde el feed con el botón de comparar.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
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

class _ComparadorTable extends StatelessWidget {
  const _ComparadorTable({
    required this.componentes,
    required this.onRemove,
    required this.onClear,
  });

  final List<Componente> componentes;
  final ValueChanged<String> onRemove;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final bestPrice = componentes.reduce(
      (a, b) => a.costo <= b.costo ? a : b,
    );
    final bestConsumption = componentes.reduce(
      (a, b) => a.consumoEnergetico <= b.consumoEnergetico ? a : b,
    );
    final bestRating = componentes.reduce(
      (a, b) => a.promedioCalificacion >= b.promedioCalificacion ? a : b,
    );
    final conValor = componentes
        .where((componente) => componente.costo > 0 && componente.totalResenas > 0)
        .toList(growable: false);
    final bestValue = conValor.isEmpty
        ? null
        : conValor.reduce(
            (a, b) => _valorNumerico(a) >= _valorNumerico(b) ? a : b,
          );
    final columnasFijas = componentes.length > 2;

    Widget table = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _LabelColumn(),
        for (final componente in componentes)
          if (columnasFijas)
            SizedBox(
              width: 168,
              child: _ComponentColumn(
                componente: componente,
                bestPriceId: bestPrice.id,
                bestConsumptionId: bestConsumption.id,
                bestRatingId: bestRating.id,
                bestValueId: bestValue?.id,
                onRemove: () => onRemove(componente.id),
              ),
            )
          else
            Expanded(
              child: _ComponentColumn(
                componente: componente,
                bestPriceId: bestPrice.id,
                bestConsumptionId: bestConsumption.id,
                bestRatingId: bestRating.id,
                bestValueId: bestValue?.id,
                onRemove: () => onRemove(componente.id),
              ),
            ),
      ],
    );

    if (columnasFijas) {
      table = SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: table,
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
          child: table,
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
          child: SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: onClear,
              child: const Text('Limpiar comparación'),
            ),
          ),
        ),
      ],
    );
  }
}

class _LabelColumn extends StatelessWidget {
  const _LabelColumn();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return SizedBox(
      width: 112,
      child: Column(
        children: [
          SizedBox(
            height: 124,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(
                  'Especificación',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
          ),
          for (final label in _comparisonLabels)
            SizedBox(
              height: 52,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text(
                    label,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ComponentColumn extends StatelessWidget {
  const _ComponentColumn({
    required this.componente,
    required this.bestPriceId,
    required this.bestConsumptionId,
    required this.bestRatingId,
    required this.bestValueId,
    required this.onRemove,
  });

  final Componente componente;
  final String bestPriceId;
  final String bestConsumptionId;
  final String bestRatingId;
  final String? bestValueId;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final esMejorValor = bestValueId != null && componente.id == bestValueId;

    return Column(
      children: [
        SizedBox(
          height: 124,
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Card(
              margin: EdgeInsets.zero,
              elevation: 0,
              color: scheme.surfaceContainerHighest,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 6, 2, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            componente.nombre,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          tooltip: 'Quitar del comparador',
                          onPressed: onRemove,
                          icon: const Icon(Icons.close, size: 16),
                          style: IconButton.styleFrom(
                            minimumSize: const Size(32, 32),
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      componente.marca,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        _ValueCell(
          value: '\$${componente.costo.toStringAsFixed(2)}',
          isBest: componente.id == bestPriceId,
          badge: 'Mejor',
        ),
        _ValueCell(
          value: '${componente.consumoEnergetico.toStringAsFixed(0)} W',
          isBest: componente.id == bestConsumptionId,
          badge: 'Menor',
        ),
        _ValueCell(
          value: '${componente.promedioCalificacion.toStringAsFixed(1)} ★',
          isBest: componente.id == bestRatingId,
          badge: 'Mejor',
        ),
        _ValueCell(value: '${componente.totalResenas}'),
        _ValueCell(
          value: componente.costo > 0
              ? _valorNumerico(componente).toStringAsFixed(1)
              : '—',
          isBest: esMejorValor,
          badge: 'Mejor',
        ),
        _ValueCell(value: componente.subCategoria),
        _ValueCell(value: componente.fechaLanzamiento),
      ],
    );
  }
}

class _ValueCell extends StatelessWidget {
  const _ValueCell({
    required this.value,
    this.isBest = false,
    this.badge,
  });

  final String value;
  final bool isBest;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return SizedBox(
      height: 52,
      child: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: Row(
          children: [
            Expanded(
              child: Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: isBest ? FontWeight.bold : FontWeight.normal,
                  color: isBest ? scheme.primary : scheme.onSurface,
                ),
              ),
            ),
            if (isBest && badge != null) ...[
              const SizedBox(width: 4),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: scheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  badge!,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: scheme.onPrimaryContainer,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
