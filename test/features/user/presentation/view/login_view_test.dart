import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cura_pet/features/user/presentation/view/login_view.dart';

void main() {
  testWidgets('LoginView renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginView()));

    expect(find.text('Welcome!'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.text("Sign In"), findsOneWidget);
  });
}
