import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:video_duration_native_platform_interface/video_duration_native_platform_interface.dart';

/// The iOS implementation of [VideoDurationNativePlatform].
class VideoDurationNativeIOS extends VideoDurationNativePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel(
    'video_duration_native_ios',
  );

  /// Registers this class as the default instance of
  /// [VideoDurationNativePlatform]
  static void registerWith() {
    VideoDurationNativePlatform.instance = VideoDurationNativeIOS();
  }

  @override
  Future<String?> getPlatformName() {
    return methodChannel.invokeMethod<String>('getPlatformName');
  }

  @override
  Future<Duration> getDuration(String pathOrUri) async {
    try {
      final ms = await methodChannel.invokeMethod<int>(
        'getDuration',
        {'path': pathOrUri},
      );
      final value = ms ?? 0;
      if (value <= 0) return Duration.zero;
      return Duration(milliseconds: value);
    } on Exception {
      return Duration.zero;
    }
  }
}
