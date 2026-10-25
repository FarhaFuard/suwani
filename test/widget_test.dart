
import 'package:flutter_test/flutter_test.dart';
import 'package:suwani_mobile/main.dart';

void main() {
  testWidgets('SUWANI app launches', (WidgetTester tester) async {
    await tester.pumpWidget(const SuwaniApp());

    expect(find.text('My Elders'), findsNothing);
    expect(find.text('Hello, Clara'), findsOneWidget);
  });
}
