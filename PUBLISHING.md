# Publishing Guide for video_duration_native

This guide walks you through publishing the `video_duration_native` plugin to GitHub and pub.dev.

## Prerequisites

- GitHub account
- pub.dev account (create at [pub.dev](https://pub.dev))
- Flutter SDK installed
- Git configured

## Step 1: Create GitHub Repository

### Option A: Using GitHub CLI
```bash
gh repo create video_duration_native --public --description "Lightweight native video duration reader for Flutter. No FFmpeg, no byte loading—just native platform APIs."
```

### Option B: Using GitHub Web Interface
1. Go to [github.com/new](https://github.com/new)
2. Repository name: `video_duration_native`
3. Description: `Lightweight native video duration reader for Flutter. No FFmpeg, no byte loading—just native platform APIs.`
4. Set to **Public**
5. **Don't** initialize with README (we already have one)
6. Click "Create repository"

## Step 2: Update Repository URLs

**Replace `YOUR_USERNAME` with your actual GitHub username in these files:**

1. `video_duration_native/pubspec.yaml`
2. `video_duration_native_platform_interface/pubspec.yaml`
3. `video_duration_native_android/pubspec.yaml`
4. `video_duration_native_ios/pubspec.yaml`

**Find and replace:**
```yaml
homepage: https://github.com/YOUR_USERNAME/video_duration_native
repository: https://github.com/YOUR_USERNAME/video_duration_native
issue_tracker: https://github.com/YOUR_USERNAME/video_duration_native/issues
```

## Step 3: Push to GitHub

```bash
# Add remote origin (replace YOUR_USERNAME)
git remote add origin https://github.com/YOUR_USERNAME/video_duration_native.git
git branch -M main
git push -u origin main
```

## Step 4: Publish to pub.dev

**Important:** Publish packages in this order due to dependencies:

### 1. Platform Interface (First)
```bash
cd video_duration_native_platform_interface
flutter pub publish --dry-run  # Test first
flutter pub publish
```

### 2. Android Implementation (Second)
```bash
cd video_duration_native_android
flutter pub publish --dry-run  # Test first
flutter pub publish
```

### 3. iOS Implementation (Third)
```bash
cd video_duration_native_ios
flutter pub publish --dry-run  # Test first
flutter pub publish
```

### 4. Main Plugin (Last)
```bash
cd video_duration_native
flutter pub publish --dry-run  # Test first
flutter pub publish
```

## Step 5: Verify Publication

After publishing, verify on pub.dev:
- [video_duration_native](https://pub.dev/packages/video_duration_native)
- [video_duration_native_platform_interface](https://pub.dev/packages/video_duration_native_platform_interface)
- [video_duration_native_android](https://pub.dev/packages/video_duration_native_android)
- [video_duration_native_ios](https://pub.dev/packages/video_duration_native_ios)

## Step 6: Update Example App

After publishing, update the example app to use published versions:

```bash
cd video_duration_native/example
# Update pubspec.yaml to use published versions instead of path dependencies
flutter pub get
```

## Release Management

After the initial publication, use conventional commits for automated releases:

```bash
# For new features
git commit -m "feat: add support for video thumbnails"

# For bug fixes
git commit -m "fix: handle null duration values correctly"

# For breaking changes
git commit -m "feat!: change API to return Duration instead of int

BREAKING CHANGE: getDuration now returns Duration object instead of milliseconds"
```

The release-please workflow will automatically:
- Generate changelog entries
- Create release PRs
- Publish new versions to pub.dev

## Troubleshooting

### Common Issues

1. **Package name already exists**: Choose a different name
2. **Dependency not found**: Ensure you published dependencies first
3. **Version conflict**: Update version numbers in pubspec.yaml
4. **Authentication**: Run `flutter pub login` first

### Commands to Check Before Publishing

```bash
# Check for issues
flutter analyze
flutter test

# Verify pubspec.yaml
flutter pub deps

# Test dry run
flutter pub publish --dry-run
```

## Next Steps

After successful publication:

1. ✅ Update README with pub.dev badges
2. ✅ Create example project using the published package
3. ✅ Monitor pub.dev analytics
4. ✅ Respond to issues and feature requests
5. ✅ Maintain the package with regular updates

## Support

- **Issues**: [GitHub Issues](https://github.com/YOUR_USERNAME/video_duration_native/issues)
- **Discussions**: [GitHub Discussions](https://github.com/YOUR_USERNAME/video_duration_native/discussions)
- **Documentation**: [README.md](README.md) and [TESTING.md](TESTING.md)
