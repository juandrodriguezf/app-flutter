import 'package:material_ui/material_ui.dart';

import '../data/sample_data.dart';
import '../models/componente.dart';
import '../state/app_state.dart';
import '../widgets/component_image.dart';
import '../widgets/review_item_card.dart';
import '../widgets/star_rating.dart';
import 'detalle_screen.dart';
import 'resenas_screen.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key, required this.onOpenComparador});

  final VoidCallback onOpenComparador;

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedTab = 0;
  String _selectedCategory = 'Todo';

  bool get _explorando => _selectedTab == 0;

  List<Componente> get _componentesFiltrados {
    final query = _searchController.text.trim().toLowerCase();
    return sampleComponentes.where((componente) {
      final coincideCategoria =
          _selectedCategory == 'Todo' ||
          componente.subCategoria == _selectedCategory;
      final coincideBusqueda =
          query.isEmpty || componente.nombre.toLowerCase().contains(query);
      return coincideCategoria && coincideBusqueda;
    }).toList(growable: false);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _openDetalle(Componente componente) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => DetalleScreen(componente: componente),
      ),
    );
  }

  void _openResenas(Componente componente) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ResenasScreen(componente: componente),
      ),
    );
  }

  String _textoComponentesEncontrados(int cantidad) {
    return cantidad == 1
        ? '1 componente encontrado'
        : '$cantidad componentes encontrados';
  }

  String _textoResenasEncontradas(int cantidad) {
    return cantidad == 1
        ? '1 reseña encontrada'
        : '$cantidad reseñas encontradas';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final appState = AppStateScope.of(context);
    final categorias = categoriasDeComponentes;
    final componentes = _componentesFiltrados;
    final resenas = resenasDeSiguiendo
        .where((resena) => !appState.isHidden(resena.id))
        .toList(growable: false);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.only(bottom: 24),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: scheme.primary,
                    backgroundImage: const AssetImage('assets/images/logo.png'),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'RateMyPc',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _TabButton(
                          label: 'Explorar',
                          selected: _explorando,
                          onTap: () => setState(() => _selectedTab = 0),
                        ),
                      ),
                      Expanded(
                        child: _TabButton(
                          label: 'Siguiendo',
                          selected: !_explorando,
                          onTap: () => setState(() => _selectedTab = 1),
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 1, color: scheme.outlineVariant),
                ],
              ),
            ),
            if (appState.comparisonIds.isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                child: _ComparadorBar(
                  cantidad: appState.comparisonIds.length,
                  onComparar: widget.onOpenComparador,
                ),
              ),
            if (_explorando) ...[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: TextField(
                  controller: _searchController,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: 'Buscar componentes',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchController.text.isEmpty
                        ? null
                        : IconButton(
                            tooltip: 'Cancelar',
                            onPressed: () {
                              _searchController.clear();
                              setState(() {});
                            },
                            icon: const Icon(Icons.close),
                          ),
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: categorias.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final categoria = categorias[index];
                    return _CategoryChip(
                      label: categoria,
                      selected: categoria == _selectedCategory,
                      onTap: () {
                        setState(() => _selectedCategory = categoria);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  _textoComponentesEncontrados(componentes.length),
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              if (componentes.isEmpty)
                const _NotFound()
              else
                ...componentes.map(
                  (componente) => _FeedItemCard(
                    componente: componente,
                    onOpenDetalle: () => _openDetalle(componente),
                    onOpenResenas: () => _openResenas(componente),
                  ),
                ),
            ] else ...[
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  _textoResenasEncontradas(resenas.length),
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              if (resenas.isEmpty)
                const _SinResenasSiguiendo()
              else
                ...resenas.map(
                  (resena) => ReviewItemCard(
                    resena: resena,
                    componenteNombre:
                        componentePorId(resena.componenteId)?.nombre,
                    onAuthorTap: () => _showMessage(
                      'Perfil de ${resena.nombreUsuario} no disponible en la demo.',
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

class _TabButton extends StatelessWidget {
  const _TabButton({
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
      onTap: onTap,
      child: Container(
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: selected ? scheme.primary : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          label,
          style: theme.textTheme.labelLarge?.copyWith(
            color: selected ? scheme.primary : scheme.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
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
          color: selected
              ? scheme.primaryContainer
              : scheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selected ? scheme.primary : Colors.transparent,
          ),
        ),
        child: Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(
            color: selected ? scheme.primary : scheme.onSurfaceVariant,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _ComparadorBar extends StatelessWidget {
  const _ComparadorBar({
    required this.cantidad,
    required this.onComparar,
  });

  final int cantidad;
  final VoidCallback onComparar;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final listo = cantidad >= 2;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: scheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.compare_arrows, color: scheme.onPrimaryContainer),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Comparador ($cantidad)',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: scheme.onPrimaryContainer,
                  ),
                ),
                Text(
                  listo
                      ? 'Listo para comparar'
                      : 'Selecciona al menos 2 componentes',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: scheme.onPrimaryContainer.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
          FilledButton(
            onPressed: listo ? onComparar : null,
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            ),
            child: const Text('Comparar'),
          ),
        ],
      ),
    );
  }
}

class _CategoryBadge extends StatelessWidget {
  const _CategoryBadge({required this.subCategoria});

  final String subCategoria;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final esCpu = subCategoria.toUpperCase() == 'CPU';
    final background = esCpu ? scheme.tertiary : scheme.secondary;
    final foreground = esCpu ? scheme.onTertiary : scheme.onSecondary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        subCategoria.toUpperCase(),
        style: theme.textTheme.labelSmall?.copyWith(
          color: foreground,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _FeedItemCard extends StatelessWidget {
  const _FeedItemCard({
    required this.componente,
    required this.onOpenDetalle,
    required this.onOpenResenas,
  });

  final Componente componente;
  final VoidCallback onOpenDetalle;
  final VoidCallback onOpenResenas;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final appState = AppStateScope.of(context);
    final visibles = resenasVisibles(componente.id, appState.hiddenReviewIds);
    final totalResenas = visibles.length;
    final promedio = promedioDeResenas(visibles);
    final isFavorite = appState.isFavorite(componente.id);
    final isComparing = appState.isComparing(componente.id);
    final canCompare = isComparing || appState.comparisonIds.length < 3;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      elevation: 0,
      color: scheme.surfaceContainerHighest,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onOpenResenas,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: ColoredBox(
                  color: scheme.surface,
                  child: SizedBox(
                    width: 90,
                    height: 90,
                    child: ComponentImage(
                      asset: componente.imageAsset,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            componente.marca.toUpperCase(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        _CategoryBadge(
                          subCategoria: componente.subCategoria,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      componente.nombre,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: scheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Lanzamiento: ${componente.fechaLanzamiento}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 8,
                      runSpacing: 4,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '\$${componente.costo}',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                StarRating(
                                  rating: promedio,
                                  size: 12,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${promedio.toStringAsFixed(1)} ($totalResenas)',
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    color: scheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              tooltip: isFavorite
                                  ? 'Quitar de favoritos'
                                  : 'Favorito',
                              onPressed: () =>
                                  appState.toggleFavorite(componente.id),
                              icon: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                size: 18,
                              ),
                              style: IconButton.styleFrom(
                                foregroundColor: isFavorite
                                    ? scheme.primary
                                    : scheme.onSurface,
                                backgroundColor: scheme.surface,
                                minimumSize: const Size(32, 32),
                                padding: EdgeInsets.zero,
                                tapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                              ),
                            ),
                            const SizedBox(width: 4),
                            IconButton(
                              tooltip: 'Info',
                              onPressed: onOpenDetalle,
                              icon: const Icon(Icons.info_outline, size: 18),
                              style: IconButton.styleFrom(
                                foregroundColor: scheme.onSurface,
                                backgroundColor: scheme.surface,
                                minimumSize: const Size(32, 32),
                                padding: EdgeInsets.zero,
                                tapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                              ),
                            ),
                            const SizedBox(width: 4),
                            IconButton(
                              tooltip: isComparing
                                  ? 'Quitar de comparación'
                                  : 'Comparar',
                              onPressed: canCompare
                                  ? () =>
                                      appState.toggleComparison(componente.id)
                                  : null,
                              icon: const Icon(
                                Icons.compare_arrows,
                                size: 18,
                              ),
                              style: IconButton.styleFrom(
                                foregroundColor: isComparing
                                    ? scheme.primary
                                    : scheme.onSurface,
                                disabledForegroundColor: scheme.onSurface
                                    .withValues(alpha: 0.38),
                                backgroundColor: isComparing
                                    ? scheme.primaryContainer
                                    : scheme.surface,
                                minimumSize: const Size(32, 32),
                                padding: EdgeInsets.zero,
                                tapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NotFound extends StatelessWidget {
  const _NotFound();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.all(48),
      child: Column(
        children: [
          Icon(Icons.search_off, size: 56, color: scheme.onSurfaceVariant),
          const SizedBox(height: 12),
          Text(
            'No se encontraron componentes',
            textAlign: TextAlign.center,
            style: theme.textTheme.titleMedium?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Intenta con otros filtros o busca algo diferente',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _SinResenasSiguiendo extends StatelessWidget {
  const _SinResenasSiguiendo();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.all(48),
      child: Column(
        children: [
          Text(
            'No hay reseñas de usuarios que sigues',
            textAlign: TextAlign.center,
            style: theme.textTheme.titleMedium?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Sigue a otros usuarios para ver sus reseñas aquí',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
