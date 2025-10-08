import 'package:flutter_test/flutter_test.dart';
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
