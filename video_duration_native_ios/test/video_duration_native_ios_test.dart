import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:video_duration_native_ios/video_duration_native_ios.dart';
import 'package:video_duration_native_platform_interface/video_duration_native_platform_interface.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('VideoDurationNativeIOS', () {
    const kPlatformName = 'iOS';
    late VideoDurationNativeIOS videoDurationNative;
    late List<MethodCall> log;

    setUp(() async {
      videoDurationNative = VideoDurationNativeIOS();

      log = <MethodCall>[];
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        videoDurationNative.methodChannel,
        (methodCall) async {
        log.add(methodCall);
        switch (methodCall.method) {
          case 'getPlatformName':
            return kPlatformName;
          case 'getDuration':
            return 5000; // 5 seconds in milliseconds
          default:
            return null;
        }
      });
    });

    test('can be registered', () {
      VideoDurationNativeIOS.registerWith();
      expect(
        VideoDurationNativePlatform.instance,
        isA<VideoDurationNativeIOS>(),
      );
    });

    test('getPlatformName returns correct name', () async {
      final name = await videoDurationNative.getPlatformName();
      expect(
        log,
        <Matcher>[isMethodCall('getPlatformName', arguments: null)],
      );
      expect(name, equals(kPlatformName));
    });

    group('getDuration', () {
      test('returns duration for valid file path', () async {
        const testPath = '/path/to/video.mp4';
        final duration = await videoDurationNative.getDuration(testPath);
        
        expect(
          log,
          <Matcher>[
            isMethodCall('getDuration', arguments: {'path': testPath}),
          ],
        );
        expect(duration, equals(const Duration(milliseconds: 5000)));
      });

      test('returns duration for file URL', () async {
        const fileUrl = 'file:///path/to/video.mp4';
        final duration = await videoDurationNative.getDuration(fileUrl);
        
        expect(duration, equals(const Duration(milliseconds: 5000)));
      });

      test('returns zero duration when result is null', () async {
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(
          videoDurationNative.methodChannel,
          (methodCall) async => null,
        );

        final duration = await videoDurationNative.getDuration('/test.mp4');
        expect(duration, equals(Duration.zero));
      });

      test('returns zero duration on exception', () async {
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(
          videoDurationNative.methodChannel,
          (methodCall) async => throw PlatformException(code: 'error'),
        );

        final duration = await videoDurationNative.getDuration('/test.mp4');
        expect(duration, equals(Duration.zero));
      });
    });
  });
}
