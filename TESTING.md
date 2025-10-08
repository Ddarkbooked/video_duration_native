# Testing Guide for video_duration_native

This document describes all the testing approaches available for the `video_duration_native` plugin.

## Test Types

### 1. Unit Tests ✅
Tests the Dart API and platform interface implementation.

**Location:** `video_duration_native/test/`, `video_duration_native_platform_interface/test/`

**Run:**
```bash
# From plugin root
cd video_duration_native
flutter test

# Platform interface tests
cd video_duration_native_platform_interface
flutter test
```

**Coverage:**
- ✅ Platform name retrieval
- ✅ getDuration method with valid paths
- ✅ getDuration with null/negative values
- ✅ getDuration error handling
- ✅ Platform-specific implementations (Android/iOS)

---

### 2. Integration Tests (Flutter Driver) ✅
Tests the plugin with a real Flutter app and device/emulator.

**Location:** `video_duration_native/example/integration_test/app_test.dart`

**Run:**
```bash
cd video_duration_native/example
flutter test integration_test/app_test.dart
```

**Tests:**
- ✅ `getPlatformName` - Verifies platform name is retrieved and displayed
- ✅ `getDuration returns duration value` - Tests getDuration is called and result is displayed
- ✅ `pick video button is visible` - Verifies file picker UI is present

**Results:** All 3 tests passing! 🎉

---

### 3. Fluttium Tests (E2E) ✅
Behavior-driven tests using Fluttium for automated UI testing.

**Location:** `video_duration_native/example/flows/`

**Run:**
```bash
cd video_duration_native/example

# Test platform name functionality
fluttium test flows/test_platform_name.yaml

# Test getDuration functionality  
fluttium test flows/test_get_duration.yaml
```

**Tests:**
- ✅ `test_platform_name.yaml` - Taps button and verifies platform name
- ✅ `test_get_duration.yaml` - Taps getDuration button and verifies output

**Custom Actions:**
- `checkPlatformName` - Validates platform-specific name display
- `checkDuration` - Validates duration text format

**Results:** Both tests passing! 🎉

---

## Native Implementation Testing

### Android
**Native Code:** `MediaMetadataRetriever`
- ✅ File paths supported
- ✅ Content URIs supported (`content://...`)
- ✅ Returns duration in milliseconds
- ✅ Handles errors gracefully

### iOS
**Native Code:** `AVURLAsset`
- ✅ File paths supported
- ✅ File URLs supported (`file://...`)
- ✅ Lightweight (no track preloading)
- ✅ Returns duration in milliseconds
- ✅ Handles errors gracefully

---

## Manual Testing with Real Videos

For comprehensive testing with actual video files:

1. **Run the example app:**
   ```bash
   cd video_duration_native/example
   flutter run
   ```

2. **Test scenarios:**
   - Tap "Pick Video File" → Select a video → Verify duration
   - Enter manual path → Tap "Get Duration" → Verify result
   - Try different video formats (MP4, MOV, etc.)
   - Try invalid paths → Verify returns 0 seconds

---

## Test Results Summary

| Test Type | Location | Status | Count |
|-----------|----------|--------|-------|
| Unit Tests (Plugin) | `test/` | ✅ Passing | Multiple |
| Unit Tests (Platform Interface) | `platform_interface/test/` | ✅ Passing | Multiple |
| Unit Tests (Android) | `android/test/` | ✅ Passing | Multiple |
| Unit Tests (iOS) | `ios/test/` | ✅ Passing | Multiple |
| Integration Tests | `example/integration_test/` | ✅ Passing | 3 |
| Fluttium Tests | `example/flows/` | ✅ Passing | 2 |

**Total: All tests passing! ✅**

---

## Continuous Integration

The plugin includes GitHub Actions workflows for automated testing:

- `video_duration_native.yaml` - Main plugin tests
- `video_duration_native_android.yaml` - Android platform tests
- `video_duration_native_ios.yaml` - iOS platform tests
- `video_duration_native_platform_interface.yaml` - Platform interface tests

---

## Key Features Verified

✅ **Cross-platform** - Works on Android and iOS  
✅ **Lightweight** - No FFmpeg, no byte loading  
✅ **Content URI support** - Android content:// URIs  
✅ **Error handling** - Returns Duration.zero on errors  
✅ **Native APIs** - MediaMetadataRetriever (Android), AVURLAsset (iOS)  
✅ **File picker integration** - Works with file_picker package  
✅ **Automated testing** - Unit, integration, and E2E tests  

---

## Contributing

When adding new features, please ensure:
1. Unit tests are added/updated
2. Integration tests cover the new functionality
3. Fluttium flows are updated if UI changes
4. All existing tests continue to pass

