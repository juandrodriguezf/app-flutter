import 'package:flutter_app/state/app_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('alterna favoritos', () {
    final state = AppState();
    addTearDown(state.dispose);

    expect(state.isFavorite('comp-1'), isFalse);
    state.toggleFavorite('comp-1');
    expect(state.isFavorite('comp-1'), isTrue);
    state.toggleFavorite('comp-1');
    expect(state.isFavorite('comp-1'), isFalse);
  });

  test('limita la comparacion a tres componentes', () {
    final state = AppState();
    addTearDown(state.dispose);

    expect(state.toggleComparison('comp-1'), isTrue);
    expect(state.toggleComparison('comp-2'), isTrue);
    expect(state.toggleComparison('comp-3'), isTrue);
    expect(state.toggleComparison('comp-4'), isFalse);
    expect(state.comparisonIds, hasLength(3));

    expect(state.toggleComparison('comp-1'), isFalse);
    expect(state.isComparing('comp-1'), isFalse);
    expect(state.comparisonIds, hasLength(2));
  });

  test('alterna me gusta y reinicia la sesion', () {
    final state = AppState();
    addTearDown(state.dispose);

    state.toggleFavorite('comp-1');
    state.toggleComparison('comp-1');
    state.toggleLike('res-101');
    state.hideReview('res-101');

    expect(state.isFavorite('comp-1'), isTrue);
    expect(state.isComparing('comp-1'), isTrue);
    expect(state.isLiked('res-101'), isTrue);
    expect(state.isHidden('res-101'), isTrue);

    state.resetSession();

    expect(state.favoriteIds, isEmpty);
    expect(state.comparisonIds, isEmpty);
    expect(state.isLiked('res-101'), isFalse);
    expect(state.isHidden('res-101'), isFalse);
  });
}
