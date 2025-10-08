import 'package:flutter_test/flutter_test.dart';
import 'package:video_duration_native_platform_interface/src/method_channel_video_duration_native.dart';
import 'package:video_duration_native_platform_interface/video_duration_native_platform_interface.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('VideoDurationNativePlatform default initialization', () {
    test('has default MethodChannelVideoDurationNative instance', () {
      // This test runs in isolation to test the actual default initialization
      // without interference from other test setups
      expect(
        VideoDurationNativePlatform.instance,
        isA<MethodChannelVideoDurationNative>(),
      );
    });
  });
}
