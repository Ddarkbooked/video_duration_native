# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial implementation of lightweight native video duration reader
- Support for Android (MediaMetadataRetriever) and iOS (AVURLAsset)
- File path and content URI support for Android
- File path and file URL support for iOS
- Comprehensive test suite (unit, integration, and E2E tests)
- Example app with file picker integration
- Fluttium integration tests with custom actions
- Error handling with Duration.zero return on failures
- Type-safe Duration object return
- No FFmpeg dependencies - uses native platform APIs only
- No byte loading - lightweight metadata extraction
