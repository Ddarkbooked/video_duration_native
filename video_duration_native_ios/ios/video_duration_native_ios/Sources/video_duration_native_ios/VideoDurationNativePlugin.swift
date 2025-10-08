import Flutter
import UIKit
import AVFoundation

public class VideoDurationNativePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "video_duration_native_ios", binaryMessenger: registrar.messenger())
    let instance = VideoDurationNativePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformName":
      result("iOS")
    case "getDuration":
      guard
        let args = call.arguments as? [String: Any],
        let path = args["path"] as? String
      else {
        result(0)
        return
      }
      
      // Try to create URL from path (supports both URLs and file paths)
      var url: URL?
      if let parsedUrl = URL(string: path) {
        url = parsedUrl
      } else {
        url = URL(fileURLWithPath: path)
      }
      
      guard let videoUrl = url else {
        result(0)
        return
      }
      
      result(getDurationMs(url: videoUrl))
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func getDurationMs(url: URL) -> Int {
    // Lightweight reading: without loading tracks into memory
    let asset = AVURLAsset(url: url)
    asset.resourceLoader.preloadsEligibleContentKeys = false
    if #available(iOS 13.0, *) {
      asset.prefersPreciseDurationAndTiming = true
    }

    let duration = asset.duration
    if duration.isValid && duration.isNumeric {
      let seconds = CMTimeGetSeconds(duration)
      if seconds.isFinite && seconds > 0 {
        let ms = Int((seconds * 1000.0).rounded())
        return max(ms, 0)
      }
    }
    return 0
  }
}
