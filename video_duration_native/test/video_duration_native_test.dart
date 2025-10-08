import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:video_duration_native/video_duration_native.dart';
import 'package:video_duration_native_platform_interface/video_duration_native_platform_interface.dart';

class MockVideoDurationNativePlatform extends Mock
    with MockPlatformInterfaceMixin
    implements VideoDurationNativePlatform {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group(VideoDurationNativePlatform, () {
    late VideoDurationNativePlatform videoDurationNativePlatform;

    setUp(() {
      videoDurationNativePlatform = MockVideoDurationNativePlatform();
      VideoDurationNativePlatform.instance = videoDurationNativePlatform;
    });

    group('getPlatformName', () {
      test('returns correct name when platform implementation exists',
          () async {
        const platformName = '__test_platform__';
        when(
          () => videoDurationNativePlatform.getPlatformName(),
        ).thenAnswer((_) async => platformName);

        final actualPlatformName = await getPlatformName();
        expect(actualPlatformName, equals(platformName));
      });

      test('throws exception when platform implementation is missing',
          () async {
        when(
          () => videoDurationNativePlatform.getPlatformName(),
        ).thenAnswer((_) async => null);

        expect(getPlatformName, throwsException);
      });
    });

    group('getDuration', () {
      test('returns duration from platform implementation', () async {
        const testPath = '/path/to/video.mp4';
        const expectedDuration = Duration(milliseconds: 5000);
        
        when(
          () => videoDurationNativePlatform.getDuration(testPath),
        ).thenAnswer((_) async => expectedDuration);

        final actualDuration = await getDuration(testPath);
        expect(actualDuration, equals(expectedDuration));
        
        verify(
          () => videoDurationNativePlatform.getDuration(testPath),
        ).called(1);
      });

      test('handles content URI paths', () async {
        const contentUri = 'content://media/external/video/123';
        const expectedDuration = Duration(milliseconds: 10000);
        
        when(
          () => videoDurationNativePlatform.getDuration(contentUri),
        ).thenAnswer((_) async => expectedDuration);

        final actualDuration = await getDuration(contentUri);
        expect(actualDuration, equals(expectedDuration));
      });

      test('returns zero duration on error', () async {
        when(
          () => videoDurationNativePlatform.getDuration(any()),
        ).thenAnswer((_) async => Duration.zero);

        final duration = await getDuration('/invalid/path.mp4');
        expect(duration, equals(Duration.zero));
      });
    });
  });
}
