import 'package:flutter_app/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('muestra el saludo inicial', (tester) async {
    await tester.pumpWidget(const MainApp());

    expect(find.text('Hello World!'), findsOneWidget);
  });
}
