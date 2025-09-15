
import 'package:flutter_test/flutter_test.dart';

extension TestWidgetExtension on void Function() {
  void testWidget(String description, Future<void> Function(WidgetTester) test) {
    testWidgets(description, test);
  }
}
