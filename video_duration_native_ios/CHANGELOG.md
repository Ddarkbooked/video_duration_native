# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.0](https://github.com/Ddarkbooked/video_duration_native/compare/video_duration_native_ios-v0.1.0...video_duration_native_ios-v0.2.0) (2025-10-08)


### Features

* initial implementation of lightweight native video duration reader ([cacf2ab](https://github.com/Ddarkbooked/video_duration_native/commit/cacf2ab4dd4c048dce0ca9bcdae42a50dda2a195))
* introduce initial plugin packages ([d794879](https://github.com/Ddarkbooked/video_duration_native/commit/d794879cd54d8858dfb5fe755532a0a8f79cfc44))

## [Unreleased]

## [0.1.0+1] - 2024-01-XX

### Added
- iOS implementation of video_duration_native plugin
- AVURLAsset integration with optimized settings
- Support for file paths and file:// URLs
- Swift implementation with lightweight configuration
- preloadsEligibleContentKeys = false for memory efficiency
- prefersPreciseDurationAndTiming = true for accuracy (iOS 13+)
- Comprehensive test coverage
- Error handling with Duration.zero return
