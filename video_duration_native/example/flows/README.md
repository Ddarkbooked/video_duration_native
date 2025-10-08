# Fluttium Integration Tests

This directory contains integration tests for the `video_duration_native` plugin using [Fluttium](https://fluttium.dev/).

## Available Tests

### 1. `test_platform_name.yaml`
Tests the basic platform name functionality to verify the plugin is properly initialized.

**What it tests:**
- Taps "Get Platform Name" button
- Verifies the platform name is displayed (e.g., "Android", "iOS")

### 2. `test_get_duration.yaml`
Tests the `getDuration` method by calling it with a default path.

**What it tests:**
- Taps "Get Duration" button with the default path
- Verifies that duration text is displayed (showing the native API was called)
- Note: For invalid paths, returns `Duration.zero` (0 seconds, 0 ms)

## Running Tests

```bash
# Run a specific test
fluttium test flows/test_platform_name.yaml
fluttium test flows/test_get_duration.yaml

# All tests should be run from the example directory
cd video_duration_native/example
fluttium test flows/test_platform_name.yaml
```

## Testing with Real Video Files

The automated tests use a default invalid path which returns `Duration.zero`. To test with **real video files**:

### Manual Testing
1. Run the example app normally:
   ```bash
   flutter run
   ```

2. Tap "Pick Video File" button
3. Select a video from your device
4. The app will automatically:
   - Call `getDuration()` with the selected file path
   - Display the actual video duration in seconds and milliseconds

### What Gets Tested

#### Android
- File paths: `/storage/emulated/0/video.mp4`
- Content URIs: `content://media/external/video/123`
- Uses `MediaMetadataRetriever` (lightweight, no FFmpeg)

#### iOS  
- File paths: `/path/to/video.mp4`
- File URLs: `file:///path/to/video.mp4`
- Uses `AVURLAsset` with `preloadsEligibleContentKeys = false` (lightweight)

## Custom Actions

### `checkDuration`
Custom Fluttium action that verifies:
- Duration text is visible on screen
- Format: "Duration: X seconds"
- Confirms native `getDuration` was called successfully

Location: `actions/check_duration/`

### `checkPlatformName`
Custom Fluttium action that verifies the platform name matches the current platform.

Location: `actions/check_platform_name/`

## Limitations

**File Picker in Automated Tests:**
Native file picker dialogs cannot be automated in Fluttium tests as they require manual user interaction. For this reason, the automated test uses the manual path input method instead of the "Pick Video File" button.

To test the complete file picker flow, run the app manually and interact with it.

