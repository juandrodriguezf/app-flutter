import 'package:flutter_app/screens/comparador_screen.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('el comparador muestra su estado vacio', (tester) async {
    final appState = AppState();
    addTearDown(appState.dispose);
    var volvioAlFeed = false;

    await tester.pumpWidget(
      AppStateScope(
        appState: appState,
        child: MaterialApp(
          home: ComparadorScreen(
            onOpenFeed: () => volvioAlFeed = true,
          ),
        ),
      ),
    );

    expect(find.text('Sin componentes para comparar'), findsOneWidget);
    expect(find.text('Volver al feed'), findsOneWidget);

    await tester.tap(find.text('Volver al feed'));
    await tester.pump();

    expect(volvioAlFeed, isTrue);
  });

  testWidgets('el comparador muestra la tabla con dos componentes', (
    tester,
  ) async {
    final appState = AppState();
    addTearDown(appState.dispose);
    appState.toggleComparison('comp-1');
    appState.toggleComparison('comp-3');

    await tester.pumpWidget(
      AppStateScope(
        appState: appState,
        child: MaterialApp(
          home: ComparadorScreen(onOpenFeed: () {}),
        ),
      ),
    );

    expect(find.text('2/3'), findsOneWidget);
    expect(find.text('Especificación'), findsOneWidget);
    expect(find.textContaining('RTX 5060'), findsOneWidget);
    expect(find.textContaining('RTX 4080'), findsOneWidget);
    expect(find.text('Mejor'), findsWidgets);
    expect(find.text('Limpiar comparación'), findsOneWidget);
  });
}
