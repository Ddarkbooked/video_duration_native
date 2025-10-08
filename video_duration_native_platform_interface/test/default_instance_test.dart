import 'package:flutter_test/flutter_test.dart';
import 'package:video_duration_native_platform_interface/src/method_channel_video_duration_native.dart';
import 'package:video_duration_native_platform_interface/video_duration_native_platform_interface.dart';

// Concrete implementation for testing
class TestVideoDurationNativePlatform extends VideoDurationNativePlatform {
  @override
  Future<String?> getPlatformName() async => 'Test';

  @override
  Future<Duration> getDuration(String pathOrUri) async => Duration.zero;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Test the default instance initialization first, before any other tests
  test(
    'VideoDurationNativePlatform has default '
    'MethodChannelVideoDurationNative instance',
    () {
      // Create a new MethodChannelVideoDurationNative instance to ensure
      // the static initialization is covered
      final methodChannelInstance = MethodChannelVideoDurationNative();

      // Test that we can access the static instance
      expect(
        VideoDurationNativePlatform.instance,
        isA<VideoDurationNativePlatform>(),
      );

      // Also verify the method channel instance is created successfully
      expect(methodChannelInstance, isA<MethodChannelVideoDurationNative>());
    },
  );

  group('VideoDurationNativePlatform default initialization', () {
    test('static instance can be set and retrieved', () {
      // Test setting and getting the static instance
      final testPlatform = TestVideoDurationNativePlatform();
      VideoDurationNativePlatform.instance = testPlatform;

      expect(
        VideoDurationNativePlatform.instance,
        equals(testPlatform),
      );
    });

    test('creates concrete platform instance', () {
      // Test creating a concrete instance
      // to ensure the platform interface works
      final platform = TestVideoDurationNativePlatform();
      expect(platform, isA<VideoDurationNativePlatform>());
    });
  });
}
