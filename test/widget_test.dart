import 'package:flutter_test/flutter_test.dart';
import 'package:first_flutter_app/main.dart';

void main() {
  testWidgets('Lab 02 loads correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const Lab02App());
    expect(find.text('AZARIENA BINTI ARIFIN'), findsOneWidget);
    expect(find.text('CSS3344 Mobile App Dev - Lab 02'), findsOneWidget);
    expect(find.text('Interactive Pickers (Lab 2.2)'), findsOneWidget);
  });
}
