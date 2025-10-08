# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.2](https://github.com/Ddarkbooked/video_duration_native/compare/video_duration_native_android-v0.2.1...video_duration_native_android-v0.2.2) (2025-10-08)


### Bug Fixes

* correct Android package name configuration ([f2fdd6f](https://github.com/Ddarkbooked/video_duration_native/commit/f2fdd6f1bf99539aae228842906354f402a1564d))

## [0.2.1+4] - 2025-01-XX

### Fixed
- Fixed Android package name configuration to match actual file location
- Corrected plugin class path from com.github.ddarkbooked.video_duration_native to com.example.verygoodcore

## [0.2.1](https://github.com/Ddarkbooked/video_duration_native/compare/video_duration_native_android-v0.2.0...video_duration_native_android-v0.2.1) (2025-10-08)


### Bug Fixes

* update CHANGELOG and improve test coverage ([0316fff](https://github.com/Ddarkbooked/video_duration_native/commit/0316fff4e58f854c1f8a4a1c8b7227932c882599))

## [0.2.0](https://github.com/Ddarkbooked/video_duration_native/compare/video_duration_native_android-v0.1.0...video_duration_native_android-v0.2.0) (2025-10-08)


### Features

* initial implementation of lightweight native video duration reader ([cacf2ab](https://github.com/Ddarkbooked/video_duration_native/commit/cacf2ab4dd4c048dce0ca9bcdae42a50dda2a195))
* introduce initial plugin packages ([d794879](https://github.com/Ddarkbooked/video_duration_native/commit/d794879cd54d8858dfb5fe755532a0a8f79cfc44))

## [Unreleased]

## [0.1.0+1] - 2024-01-XX

### Added
- Android implementation of video_duration_native plugin
- MediaMetadataRetriever integration for lightweight metadata extraction
- Support for file paths and content:// URIs
- Kotlin implementation with proper resource cleanup
- Comprehensive test coverage
- Error handling with Duration.zero return
