import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:video_duration_native_android/video_duration_native_android.dart';
import 'package:video_duration_native_platform_interface/video_duration_native_platform_interface.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('VideoDurationNativeAndroid', () {
    const kPlatformName = 'Android';
    late VideoDurationNativeAndroid videoDurationNative;
    late List<MethodCall> log;

    setUp(() async {
      videoDurationNative = VideoDurationNativeAndroid();

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
      VideoDurationNativeAndroid.registerWith();
      expect(
        VideoDurationNativePlatform.instance,
        isA<VideoDurationNativeAndroid>(),
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
        const testPath = '/storage/emulated/0/video.mp4';
        final duration = await videoDurationNative.getDuration(testPath);
        
        expect(
          log,
          <Matcher>[
            isMethodCall('getDuration', arguments: {'path': testPath}),
          ],
        );
        expect(duration, equals(const Duration(milliseconds: 5000)));
      });

      test('returns duration for content URI', () async {
        const contentUri = 'content://media/external/video/123';
        final duration = await videoDurationNative.getDuration(contentUri);
        
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
