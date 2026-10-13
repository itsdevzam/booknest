import 'package:booknest/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('app widget is constructed', (WidgetTester tester) async {
    expect(const MainApp(), isA<StatelessWidget>());
  });
}
