import 'package:video_duration_native_platform_interface'
    '/video_duration_native_platform_interface.dart';

VideoDurationNativePlatform get _platform =>
    VideoDurationNativePlatform.instance;

/// Returns the name of the current platform.
Future<String> getPlatformName() async {
  final platformName = await _platform.getPlatformName();
  if (platformName == null) throw Exception('Unable to get platform name.');
  return platformName;
}

/// Returns the duration of a video file.
///
/// The [pathOrUri] parameter can be:
/// - An absolute file path (e.g., `/storage/emulated/0/video.mp4`)
/// - A content URI (Android only, e.g., `content://media/external/video/123`)
/// - A file URL (e.g., `file:///path/to/video.mp4`)
///
/// This method uses native platform APIs to read video metadata without
/// loading the entire file into memory:
/// - **Android**: Uses `MediaMetadataRetriever`
/// - **iOS**: Uses `AVURLAsset` with lightweight configuration
///
/// Returns [Duration.zero] if the duration cannot be determined or if an
/// error occurs.
///
/// Example:
/// ```dart
/// final duration = await getDuration('/path/to/video.mp4');
/// print('Video duration: ${duration.inSeconds} seconds');
/// ```
Future<Duration> getDuration(String pathOrUri) =>
    _platform.getDuration(pathOrUri);
