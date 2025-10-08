import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:video_duration_native_example/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('E2E', () {
    testWidgets('getPlatformName', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      await tester.tap(find.text('Get Platform Name'));
      await tester.pumpAndSettle();

      // Give it a bit more time for the async call
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pumpAndSettle();

      // Verify platform name text is displayed
      final platformNameText = find.byKey(const Key('platform_name_text'));
      expect(platformNameText, findsOneWidget);

      // Verify it contains "Platform Name:"
      expect(find.textContaining('Platform Name:'), findsOneWidget);
    });

    testWidgets('getDuration returns duration value', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Find the "Get Duration" button using its key
      final getDurationButton = find.byKey(const Key('get_duration_button'));
      expect(getDurationButton, findsOneWidget);

      // Tap the button to get duration
      // Note: With default invalid path, native code returns Duration.zero
      await tester.tap(getDurationButton);
      await tester.pumpAndSettle();

      // Verify that duration text is displayed
      final durationText = find.byKey(const Key('duration_text'));
      expect(durationText, findsOneWidget);

      // Verify the format includes "Duration:" and "seconds"
      expect(find.textContaining('Duration:'), findsOneWidget);
      expect(find.textContaining('seconds'), findsAtLeastNWidgets(1));

      // Verify milliseconds text is also displayed
      final durationMsText = find.byKey(const Key('duration_ms_text'));
      expect(durationMsText, findsOneWidget);
      expect(find.textContaining('ms'), findsOneWidget);
    });

    testWidgets('pick video button is visible', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Verify the Pick Video File button exists
      final pickVideoButton = find.byKey(const Key('pick_video_button'));
      expect(pickVideoButton, findsOneWidget);

      // Verify it has the correct label
      expect(find.text('Pick Video File'), findsOneWidget);

      // Note: We can't test the actual file picking in integration tests
      // as it requires native file picker interaction
    });
  });
}
