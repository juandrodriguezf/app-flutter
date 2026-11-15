import 'package:material_ui/material_ui.dart';

class ComponentImage extends StatelessWidget {
  const ComponentImage({
    super.key,
    required this.asset,
    this.fit = BoxFit.contain,
    this.width,
    this.height,
  });

  final String asset;
  final BoxFit fit;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Image.asset(
      asset,
      fit: fit,
      width: width,
      height: height,
      errorBuilder: (context, error, stackTrace) {
        return ColoredBox(
          color: scheme.surfaceContainerHighest,
          child: Center(
            child: Icon(
              Icons.image_not_supported_outlined,
              size: 28,
              color: scheme.outline,
            ),
          ),
        );
      },
    );
  }
}
