import 'package:flutter_app/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  testWidgets('muestra el login y navega al menu principal', (tester) async {
    await tester.pumpWidget(const RateMyPcApp());

    expect(find.text('RateMyPc'), findsOneWidget);
    expect(find.text('Ingresar'), findsOneWidget);

    await tester.enterText(find.byType(TextField).at(0), 'demo@ratemypc.com');
    await tester.enterText(find.byType(TextField).at(1), '123456');
    await tester.tap(find.text('Ingresar'));
    await tester.pumpAndSettle();

    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.byType(NavigationDestination), findsNWidgets(3));
    expect(find.text('Feed en construcción'), findsOneWidget);
  });

  testWidgets('valida el correo electronico', (tester) async {
    await tester.pumpWidget(const RateMyPcApp());

    await tester.enterText(find.byType(TextField).at(0), 'correo');
    await tester.tap(find.text('Ingresar'));
    await tester.pump();

    expect(find.text('Ingresa un correo válido'), findsOneWidget);
  });
}
