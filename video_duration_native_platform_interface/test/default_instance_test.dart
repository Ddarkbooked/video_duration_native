import 'package:flutter_test/flutter_test.dart';
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

  group('VideoDurationNativePlatform default initialization', () {
    test('has default MethodChannelVideoDurationNative instance', () {
      // Create a concrete instance to test the platform interface
      final platform = TestVideoDurationNativePlatform();
      
      // Verify the instance is created successfully
      expect(platform, isA<VideoDurationNativePlatform>());
      
      // Test that we can access the static instance
      expect(
        VideoDurationNativePlatform.instance,
        isA<VideoDurationNativePlatform>(),
      );
    });

    test('static instance can be set and retrieved', () {
      // Test setting and getting the static instance
      final testPlatform = TestVideoDurationNativePlatform();
      VideoDurationNativePlatform.instance = testPlatform;
      
      expect(
        VideoDurationNativePlatform.instance,
        equals(testPlatform),
      );
    });
  });
}
