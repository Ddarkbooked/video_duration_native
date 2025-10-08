package com.example.verygoodcore

import android.content.Context
import android.media.MediaMetadataRetriever
import android.net.Uri
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class VideoDurationNativePlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel
    private lateinit var appContext: Context

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        appContext = flutterPluginBinding.applicationContext
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "video_duration_native_android")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "getPlatformName" -> {
                result.success("Android ${android.os.Build.VERSION.RELEASE}")
            }
            "getDuration" -> {
                val path = call.argument<String>("path")
                if (path.isNullOrBlank()) {
                    result.success(0)
                    return
                }
                result.success(getDurationMs(appContext, path))
            }
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun getDurationMs(context: Context, path: String): Int {
        val retriever = MediaMetadataRetriever()
        return try {
            // Support both absolute file:// paths and content:// URIs
            if (path.startsWith("content://")) {
                val uri = Uri.parse(path)
                retriever.setDataSource(context, uri)
            } else {
                retriever.setDataSource(path)
            }
            val dur = retriever.extractMetadata(MediaMetadataRetriever.METADATA_KEY_DURATION)
            dur?.toLongOrNull()?.coerceAtLeast(0L)?.coerceAtMost(Int.MAX_VALUE.toLong())?.toInt() ?: 0
        } catch (_: Throwable) {
            0
        } finally {
            try {
                retriever.release()
            } catch (_: Throwable) {
                // Ignore release errors
            }
        }
    }
}