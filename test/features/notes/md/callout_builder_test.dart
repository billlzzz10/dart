
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:novelist_plus/features/notes/md/callout_builder.dart';

void main() {
  group('CalloutBuilder Tests', () {
    late CalloutBuilder calloutBuilder;

    setUp(() {
      calloutBuilder = CalloutBuilder();
    });

    testWidget('should build note callout', (WidgetTester tester) async {
      final element = md.Element.text('div', 'This is a note');
      element.attributes['data-callout-type'] = 'note';

      final widget = calloutBuilder.visitElementAfter(element, null);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: widget),
        ),
      );

      expect(find.text('This is a note'), findsOneWidget);
      expect(find.byIcon(Icons.info_outline), findsOneWidget);
    });

    testWidget('should build tip callout', (WidgetTester tester) async {
      final element = md.Element.text('div', 'This is a tip');
      element.attributes['data-callout-type'] = 'tip';

      final widget = calloutBuilder.visitElementAfter(element, null);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: widget),
        ),
      );

      expect(find.text('This is a tip'), findsOneWidget);
      expect(find.byIcon(Icons.lightbulb_outline), findsOneWidget);
    });

    testWidget('should build warning callout', (WidgetTester tester) async {
      final element = md.Element.text('div', 'This is a warning');
      element.attributes['data-callout-type'] = 'warning';

      final widget = calloutBuilder.visitElementAfter(element, null);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: widget),
        ),
      );

      expect(find.text('This is a warning'), findsOneWidget);
      expect(find.byIcon(Icons.warning_outlined), findsOneWidget);
    });

    testWidget('should handle default callout type', (WidgetTester tester) async {
      final element = md.Element.text('div', 'Default callout');

      final widget = calloutBuilder.visitElementAfter(element, null);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: widget),
        ),
      );

      expect(find.text('Default callout'), findsOneWidget);
      expect(find.byIcon(Icons.help_outline), findsOneWidget);
    });
  });

  group('ImageBuilder Tests', () {
    late ImageBuilder imageBuilder;

    setUp(() {
      imageBuilder = ImageBuilder();
    });

    testWidget('should build network image', (WidgetTester tester) async {
      final element = md.Element.text('img', '');
      element.attributes['src'] = 'https://example.com/image.jpg';
      element.attributes['alt'] = 'Test image';

      final widget = imageBuilder.visitElementAfter(element, null);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: widget),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
    });

    testWidget('should handle empty src', (WidgetTester tester) async {
      final element = md.Element.text('img', '');
      element.attributes['src'] = '';

      final widget = imageBuilder.visitElementAfter(element, null);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: widget),
        ),
      );

      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidget('should build asset image', (WidgetTester tester) async {
      final element = md.Element.text('img', '');
      element.attributes['src'] = 'assets/images/test.jpg';
      element.attributes['alt'] = 'Local image';

      final widget = imageBuilder.visitElementAfter(element, null);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: widget),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
    });
  });
}
