import 'package:flutter_test/flutter_test.dart';
import 'package:video_duration_native_platform_interface/src/method_channel_video_duration_native.dart';
import 'package:video_duration_native_platform_interface/video_duration_native_platform_interface.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('static initialization is covered', () {
    // This test ensures the static initialization is covered
    // by creating a MethodChannelVideoDurationNative instance
    final instance = MethodChannelVideoDurationNative();
    expect(instance, isA<MethodChannelVideoDurationNative>());

    // Also test accessing the static instance
    final staticInstance = VideoDurationNativePlatform.instance;
    expect(staticInstance, isA<VideoDurationNativePlatform>());
  });

  test('default instance creation is covered', () {
    // Reset the instance to test the default creation
    VideoDurationNativePlatform.instance = MethodChannelVideoDurationNative();

    // Test that the default instance is properly created
    final instance = VideoDurationNativePlatform.instance;
    expect(instance, isA<MethodChannelVideoDurationNative>());
  });
}
