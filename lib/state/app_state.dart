import 'package:material_ui/material_ui.dart';

class AppState extends ChangeNotifier {
  final Set<String> _favoriteIds = <String>{};
  final List<String> _comparisonIds = <String>[];
  final Set<String> _likedReviewIds = <String>{};
  final Set<String> _hiddenReviewIds = <String>{};

  Set<String> get favoriteIds => Set.unmodifiable(_favoriteIds);
  List<String> get comparisonIds => List.unmodifiable(_comparisonIds);
  Set<String> get likedReviewIds => Set.unmodifiable(_likedReviewIds);
  Set<String> get hiddenReviewIds => Set.unmodifiable(_hiddenReviewIds);

  bool isFavorite(String componenteId) => _favoriteIds.contains(componenteId);

  bool isComparing(String componenteId) => _comparisonIds.contains(componenteId);

  bool isLiked(String resenaId) => _likedReviewIds.contains(resenaId);

  bool isHidden(String resenaId) => _hiddenReviewIds.contains(resenaId);

  void toggleFavorite(String componenteId) {
    if (!_favoriteIds.add(componenteId)) {
      _favoriteIds.remove(componenteId);
    }
    notifyListeners();
  }

  bool toggleComparison(String componenteId) {
    if (_comparisonIds.remove(componenteId)) {
      notifyListeners();
      return false;
    }
    if (_comparisonIds.length >= 3) {
      return false;
    }
    _comparisonIds.add(componenteId);
    notifyListeners();
    return true;
  }

  void removeComparison(String componenteId) {
    if (_comparisonIds.remove(componenteId)) {
      notifyListeners();
    }
  }

  void clearComparison() {
    if (_comparisonIds.isEmpty) {
      return;
    }
    _comparisonIds.clear();
    notifyListeners();
  }

  void toggleLike(String resenaId) {
    if (!_likedReviewIds.add(resenaId)) {
      _likedReviewIds.remove(resenaId);
    }
    notifyListeners();
  }

  void hideReview(String resenaId) {
    if (_hiddenReviewIds.add(resenaId)) {
      notifyListeners();
    }
  }

  void resetSession() {
    _favoriteIds.clear();
    _comparisonIds.clear();
    _likedReviewIds.clear();
    _hiddenReviewIds.clear();
    notifyListeners();
  }
}

class AppStateScope extends InheritedNotifier<AppState> {
  const AppStateScope({
    super.key,
    required AppState appState,
    required super.child,
  }) : super(notifier: appState);

  static AppState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppStateScope>();
    assert(scope != null, 'AppStateScope no encontrado en el contexto');
    return scope!.notifier!;
  }

  static AppState read(BuildContext context) {
    final scope = context.getInheritedWidgetOfExactType<AppStateScope>();
    assert(scope != null, 'AppStateScope no encontrado en el contexto');
    return scope!.notifier!;
  }
}
