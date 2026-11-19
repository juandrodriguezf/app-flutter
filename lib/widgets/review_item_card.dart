import 'package:flutter/material.dart';

import '../models/resena.dart';
import '../state/app_state.dart';

class ReviewItemCard extends StatelessWidget {
  const ReviewItemCard({
    super.key,
    required this.resena,
    this.componenteNombre,
    this.canModify = false,
    this.onEdit,
    this.onDelete,
    this.onAuthorTap,
    this.highlighted = false,
  });

  final Resena resena;
  final String? componenteNombre;
  final bool canModify;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onAuthorTap;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final appState = AppStateScope.of(context);
    final liked = appState.isLiked(resena.id);
    final likes = resena.likesCount + (liked ? 1 : 0);
    final nombreComponente = componenteNombre;
    final imageUrl = resena.imageUrl;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 0,
      color: scheme.surfaceContainerHighest.withValues(alpha: 0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: highlighted
            ? BorderSide(color: scheme.primary, width: 2)
            : BorderSide.none,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: onAuthorTap,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: scheme.primaryContainer,
                          backgroundImage: const AssetImage(
                            'assets/images/logo.png',
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                resena.nombreUsuario,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                resena.fecha,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: scheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (canModify)
                  PopupMenuButton<String>(
                    tooltip: 'Opciones de la reseña',
                    icon: const Icon(Icons.more_vert),
                    onSelected: (value) {
                      if (value == 'editar') {
                        onEdit?.call();
                      } else if (value == 'eliminar') {
                        onDelete?.call();
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem<String>(
                        value: 'editar',
                        child: Text('Editar'),
                      ),
                      PopupMenuItem<String>(
                        value: 'eliminar',
                        child: Text(
                          'Eliminar',
                          style: TextStyle(color: scheme.error),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            if (nombreComponente != null && nombreComponente.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                'Sobre $nombreComponente',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: scheme.primary,
                ),
              ),
            ],
            const SizedBox(height: 12),
            Text(resena.comentario, style: theme.textTheme.bodyMedium),
            if (imageUrl != null) ...[
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.network(
                  imageUrl,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
            if (resena.esCompraVerificada) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.check, size: 14, color: scheme.primary),
                  const SizedBox(width: 4),
                  Text(
                    'Compra verificada',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: scheme.primary,
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 4),
            Row(
              children: [
                IconButton(
                  tooltip: liked ? 'Quitar me gusta' : 'Me gusta',
                  onPressed: () => appState.toggleLike(resena.id),
                  icon: Icon(liked ? Icons.favorite : Icons.favorite_border),
                  color: liked ? scheme.primary : scheme.onSurfaceVariant,
                  iconSize: 20,
                  visualDensity: VisualDensity.compact,
                ),
                Text(
                  '$likes',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
