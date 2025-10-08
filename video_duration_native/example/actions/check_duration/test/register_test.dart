import 'package:check_duration/check_duration.dart';
import 'package:fluttium/fluttium.dart';
import 'package:test/test.dart';

void main() {
  group('CheckDuration', () {
    test('can be registered', () {
      expect(CheckDuration.new, returnsNormally);
    });

    test('is an Action', () {
      expect(const CheckDuration(), isA<Action>());
    });
  });
}
