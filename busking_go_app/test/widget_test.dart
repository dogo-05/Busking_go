import 'package:flutter_test/flutter_test.dart';
import 'package:busking_go_app/main.dart';

void main() {
  testWidgets('App loads successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const BuskingGoApp());
    expect(find.text('버스킹고'), findsOneWidget);
  });
}
