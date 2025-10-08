import 'package:flutter_test/flutter_test.dart';
import 'package:video_duration_native_platform_interface/src/method_channel_video_duration_native.dart';
import 'package:video_duration_native_platform_interface/video_duration_native_platform_interface.dart';

class VideoDurationNativeMock extends VideoDurationNativePlatform {
  static const mockPlatformName = 'Mock';
  static const mockDuration = Duration(milliseconds: 3000);

  @override
  Future<String?> getPlatformName() async => mockPlatformName;

  @override
  Future<Duration> getDuration(String pathOrUri) async => mockDuration;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Test default instance initialization first (before any setUp interference)
  group('VideoDurationNativePlatform default initialization', () {
    test('has default MethodChannelVideoDurationNative instance', () {
      // This test runs before setUp, so it tests
      // the actual default initialization
      expect(
        VideoDurationNativePlatform.instance,
        isA<MethodChannelVideoDurationNative>(),
      );
    });
  });

  group('VideoDurationNativePlatformInterface', () {
    late VideoDurationNativePlatform videoDurationNativePlatform;

    setUp(() {
      videoDurationNativePlatform = VideoDurationNativeMock();
      VideoDurationNativePlatform.instance = videoDurationNativePlatform;
    });

    group('getPlatformName', () {
      test('returns correct name', () async {
        expect(
          await VideoDurationNativePlatform.instance.getPlatformName(),
          equals(VideoDurationNativeMock.mockPlatformName),
        );
      });
    });

    group('getDuration', () {
      test('returns correct duration', () async {
        expect(
          await VideoDurationNativePlatform.instance.getDuration('/test.mp4'),
          equals(VideoDurationNativeMock.mockDuration),
        );
      });
    });
  });
}
