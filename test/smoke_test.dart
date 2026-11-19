import 'package:flutter_app/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

Future<void> _login(WidgetTester tester) async {
  await tester.pumpWidget(const RateMyPcApp());
  await tester.enterText(find.byType(TextField).at(0), 'demo@ratemypc.com');
  await tester.enterText(find.byType(TextField).at(1), '123456');
  await tester.tap(find.text('Ingresar'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('muestra el feed tras iniciar sesion', (tester) async {
    await _login(tester);

    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.byType(NavigationDestination), findsNWidgets(3));
    expect(find.text('Explorar'), findsOneWidget);
    expect(find.text('Siguiendo'), findsOneWidget);
    expect(find.textContaining('RTX 5060'), findsOneWidget);
  });

  testWidgets('valida el correo electronico', (tester) async {
    await tester.pumpWidget(const RateMyPcApp());

    await tester.enterText(find.byType(TextField).at(0), 'correo');
    await tester.tap(find.text('Ingresar'));
    await tester.pump();

    expect(find.text('Ingresa un correo válido'), findsOneWidget);
  });

  testWidgets('filtra componentes por busqueda', (tester) async {
    await _login(tester);

    await tester.enterText(find.byType(TextField), 'i7');
    await tester.pump();

    expect(find.textContaining('i7-12700KF'), findsOneWidget);
    expect(find.textContaining('RTX 5060'), findsNothing);
  });

  testWidgets('muestra resenas en siguiendo', (tester) async {
    await _login(tester);

    await tester.tap(find.text('Siguiendo'));
    await tester.pump();

    expect(find.text('3 reseñas encontradas'), findsOneWidget);
    expect(find.textContaining('TechWizard92'), findsOneWidget);
  });

  testWidgets('abre el detalle y permite comparar', (tester) async {
    await _login(tester);

    await tester.tap(find.byTooltip('Info').first);
    await tester.pumpAndSettle();

    expect(find.text('Especificaciones'), findsOneWidget);
    expect(find.text('Precio'), findsOneWidget);
    expect(find.textContaining('RTX 5060'), findsOneWidget);
    expect(find.text('Ver reseñas (4)'), findsOneWidget);

    await tester.ensureVisible(find.text('Comparar'));
    await tester.tap(find.text('Comparar'));
    await tester.pump();
    expect(find.text('Quitar de comparación'), findsOneWidget);

    await tester.ensureVisible(find.byTooltip('Volver'));
    await tester.tap(find.byTooltip('Volver'));
    await tester.pumpAndSettle();
    expect(find.text('Explorar'), findsOneWidget);
  });

  testWidgets('abre las resenas y elimina una propia', (tester) async {
    await _login(tester);

    await tester.tap(find.byTooltip('Info').first);
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Ver reseñas (4)'));
    await tester.tap(find.text('Ver reseñas (4)'));
    await tester.pumpAndSettle();

    expect(find.text('Escribir una reseña'), findsOneWidget);
    expect(find.text('Todas'), findsOneWidget);
    expect(find.textContaining('EarlyAdopter'), findsOneWidget);

    await tester.ensureVisible(find.byTooltip('Opciones de la reseña'));
    await tester.tap(find.byTooltip('Opciones de la reseña'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Eliminar'));
    await tester.pumpAndSettle();

    expect(find.text('¿Eliminar esta reseña?'), findsOneWidget);
    await tester.tap(find.text('Eliminar'));
    await tester.pumpAndSettle();

    expect(find.textContaining('EarlyAdopter'), findsNothing);

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();

    expect(find.text('4.0 (3)'), findsOneWidget);
  });

  testWidgets('muestra el perfil y cambia a resenas', (tester) async {
    await _login(tester);

    await tester.tap(find.byIcon(Icons.person_outline));
    await tester.pumpAndSettle();

    expect(find.text('PERFIL'), findsOneWidget);
    expect(find.text('Juan Rodríguez'), findsOneWidget);
    expect(find.text('Editar perfil'), findsOneWidget);

    await tester.drag(find.byType(ListView).last, const Offset(0, -250));
    await tester.pumpAndSettle();
    expect(find.text('EQUIPOS'), findsOneWidget);
    expect(find.text('RESEÑAS'), findsOneWidget);
    expect(find.text('Ryzen Boost X670'), findsWidgets);

    await tester.tap(find.text('RESEÑAS'));
    await tester.pumpAndSettle();

    expect(
      find.textContaining('Tarjeta gráfica GeForce RTX 5060'),
      findsWidgets,
    );
    expect(find.textContaining('EarlyAdopter'), findsOneWidget);
  });

  testWidgets('cierra sesion desde el perfil', (tester) async {
    await _login(tester);

    await tester.tap(find.byIcon(Icons.person_outline));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Cerrar sesión'));
    await tester.pumpAndSettle();

    expect(find.text('Ingresar'), findsOneWidget);
  });

  testWidgets('compara componentes y limpia la seleccion', (tester) async {
    await _login(tester);

    await tester.ensureVisible(find.byTooltip('Comparar').first);
    await tester.tap(find.byTooltip('Comparar').first);
    await tester.pump();

    await tester.ensureVisible(find.byTooltip('Comparar').first);
    await tester.tap(find.byTooltip('Comparar').first);
    await tester.pump();

    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.byIcon(Icons.compare_arrows),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.text('Compara hasta 3 componentes lado a lado.'),
      findsOneWidget,
    );
    expect(find.text('2/3'), findsOneWidget);
    expect(find.text('Especificación'), findsOneWidget);
    expect(find.textContaining('RTX 5060'), findsWidgets);
    expect(find.text('Mejor'), findsWidgets);
    expect(find.text('Limpiar comparación'), findsOneWidget);

    await tester.ensureVisible(find.text('Limpiar comparación'));
    await tester.tap(find.text('Limpiar comparación'));
    await tester.pumpAndSettle();

    expect(find.text('Sin componentes para comparar'), findsOneWidget);
    expect(find.text('Volver al feed'), findsOneWidget);

    await tester.tap(find.text('Volver al feed'));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.dynamic_feed), findsOneWidget);
    expect(find.text('Sin componentes para comparar'), findsNothing);
  });
}
