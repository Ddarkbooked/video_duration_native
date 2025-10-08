import 'package:fluttium/fluttium.dart';

/// {@template check_duration}
/// An action that checks if a real video duration is displayed.
///
/// This action verifies that a duration text is visible,
/// indicating that getDuration successfully read video metadata
/// using native APIs.
///
/// Usage:
///
/// ```yaml
/// - checkDuration:
/// ```
/// {@endtemplate}
class CheckDuration extends Action {
  /// {@macro check_duration}
  const CheckDuration();

  @override
  Future<bool> execute(Tester tester) async {
    // Check that duration text starts with "Duration:"
    // This indicates getDuration was successfully called
    // and returned a value from the native platform
    final result = await const ExpectVisible(
      text: 'Duration:',
    ).execute(tester);
    
    if (!result) {
      return false;
    }

    // Also verify milliseconds text is shown
    // For real videos, this will be non-zero
    return const ExpectVisible(
      text: 'seconds',
    ).execute(tester);
  }

  @override
  String description() =>
      'Check that video duration is displayed from native getDuration';
}
