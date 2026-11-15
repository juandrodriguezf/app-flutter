import 'package:flutter_app/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

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
}
