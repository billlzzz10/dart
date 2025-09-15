// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Import all test files
import 'widgets/project_card_test.dart' as project_card_tests;
import 'widgets/project_cover_test.dart' as project_cover_tests;
import 'features/dashboard/dashboard_screen_test.dart' as dashboard_tests;
import 'features/notes/md/callout_builder_test.dart' as callout_builder_tests;
import 'data/db/models/project_test.dart' as project_model_tests;

void main() {
  group('All Widget Tests', () {
    project_card_tests.main();
    project_cover_tests.main();
    project_cover_tests.main();
    dashboard_tests.main();
    callout_builder_tests.main();
    project_model_tests.main();
  });
}