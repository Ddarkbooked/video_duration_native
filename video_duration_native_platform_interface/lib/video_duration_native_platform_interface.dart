import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:video_duration_native_platform_interface/src/method_channel_video_duration_native.dart';

/// {@template video_duration_native_platform}
/// The interface that implementations of video_duration_native must implement.
///
/// Platform implementations should extend this class
/// rather than implement it as `VideoDurationNative`.
///
/// Extending this class (using `extends`) ensures that the subclass will get
/// the default implementation, while platform implementations that
/// `implements` this interface will be broken by newly added
/// [VideoDurationNativePlatform] methods.
/// {@endtemplate}
abstract class VideoDurationNativePlatform extends PlatformInterface {
  /// {@macro video_duration_native_platform}
  VideoDurationNativePlatform() : super(token: _token);

  static final Object _token = Object();

  static VideoDurationNativePlatform _instance =
      MethodChannelVideoDurationNative();

  /// The default instance of [VideoDurationNativePlatform] to use.
  ///
  /// Defaults to [MethodChannelVideoDurationNative].
  static VideoDurationNativePlatform get instance => _instance;

  /// Platform-specific plugins should set this with their own
  /// platform-specific class that extends [VideoDurationNativePlatform]
  /// when they register themselves.
  static set instance(VideoDurationNativePlatform instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  /// Return the current platform name.
  Future<String?> getPlatformName();

  /// Returns the duration of a video file.
  ///
  /// The [pathOrUri] parameter can be:
  /// - An absolute file path (e.g., `/storage/emulated/0/video.mp4`)
  /// - A content URI (Android only, e.g., `content://media/external/video/123`)
  ///
  /// Returns [Duration.zero] if the duration cannot be determined.
  Future<Duration> getDuration(String pathOrUri);
}
