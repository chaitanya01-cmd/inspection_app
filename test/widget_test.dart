import 'package:flutter_test/flutter_test.dart';

import 'package:camera_app/main.dart';

void main() {
  testWidgets('Municipal Inspection app loads', (WidgetTester tester) async {
    await tester.pumpWidget(const MunicipalInspectionApp());

    expect(find.byType(MunicipalInspectionApp), findsOneWidget);
  });
}