import 'package:check_duration/check_duration.dart';
import 'package:test/test.dart';

void main() {
  group('CheckDuration', () {
    test('description returns correct message', () {
      const action = CheckDuration();
      expect(
        action.description(),
        equals(
          'Check that video duration is displayed from native getDuration',
        ),
      );
    });
  });
}
