import 'package:material_ui/material_ui.dart';

class StarRating extends StatelessWidget {
  const StarRating({
    super.key,
    required this.rating,
    this.size = 16,
    this.filledColor,
    this.emptyColor,
  });

  final double rating;
  final double size;
  final Color? filledColor;
  final Color? emptyColor;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final filled = filledColor ?? scheme.primary;
    final empty = emptyColor ?? scheme.outline;
    final filledCount = rating.floor();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List<Widget>.generate(5, (index) {
        final isFilled = index < filledCount;
        return Icon(
          isFilled ? Icons.star : Icons.star_border,
          size: size,
          color: isFilled ? filled : empty,
        );
      }),
    );
  }
}
