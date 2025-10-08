import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:video_duration_native_platform_interface/src/method_channel_video_duration_native.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const kPlatformName = 'platformName';

  group('$MethodChannelVideoDurationNative', () {
    late MethodChannelVideoDurationNative methodChannelVideoDurationNative;
    final log = <MethodCall>[];

    setUp(() async {
      methodChannelVideoDurationNative = MethodChannelVideoDurationNative();
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
            methodChannelVideoDurationNative.methodChannel,
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
            },
          );
    });

    tearDown(log.clear);

    test('getPlatformName', () async {
      final platformName = await methodChannelVideoDurationNative
          .getPlatformName();
      expect(
        log,
        <Matcher>[isMethodCall('getPlatformName', arguments: null)],
      );
      expect(platformName, equals(kPlatformName));
    });

    group('getDuration', () {
      test('returns duration when path is valid', () async {
        const testPath = '/path/to/video.mp4';
        final duration = await methodChannelVideoDurationNative.getDuration(
          testPath,
        );

        expect(
          log,
          <Matcher>[
            isMethodCall('getDuration', arguments: {'path': testPath}),
          ],
        );
        expect(duration, equals(const Duration(milliseconds: 5000)));
      });

      test('returns zero duration when result is null', () async {
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(
              methodChannelVideoDurationNative.methodChannel,
              (methodCall) async => null,
            );

        final duration = await methodChannelVideoDurationNative.getDuration(
          '/test.mp4',
        );
        expect(duration, equals(Duration.zero));
      });

      test('returns zero duration when result is negative', () async {
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(
              methodChannelVideoDurationNative.methodChannel,
              (methodCall) async => -1000,
            );

        final duration = await methodChannelVideoDurationNative.getDuration(
          '/test.mp4',
        );
        expect(duration, equals(Duration.zero));
      });

      test('returns zero duration on exception', () async {
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(
              methodChannelVideoDurationNative.methodChannel,
              (methodCall) async => throw PlatformException(code: 'error'),
            );

        final duration = await methodChannelVideoDurationNative.getDuration(
          '/test.mp4',
        );
        expect(duration, equals(Duration.zero));
      });
    });
  });
}
