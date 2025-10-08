# Contributing to video_duration_native

Thank you for your interest in contributing to `video_duration_native`! This document provides guidelines for contributing to the project.

## Development Setup

1. **Clone the repository:**
   ```bash
   git clone <repository-url>
   cd video_duration_native
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   cd video_duration_native/example && flutter pub get
   ```

3. **Run tests:**
   ```bash
   # Unit tests
   flutter test
   
   # Integration tests
   cd video_duration_native/example
   flutter test integration_test/app_test.dart
   
   # Fluttium E2E tests
   fluttium test flows/test_platform_name.yaml
   fluttium test flows/test_get_duration.yaml
   ```

## Commit Message Format

This project uses [Conventional Commits](https://www.conventionalcommits.org/) for automated changelog generation and version management.

### Format
```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

### Types

- **`feat`**: A new feature (triggers minor version bump)
- **`fix`**: A bug fix (triggers patch version bump)
- **`docs`**: Documentation only changes
- **`style`**: Changes that do not affect the meaning of the code
- **`refactor`**: A code change that neither fixes a bug nor adds a feature
- **`perf`**: A code change that improves performance
- **`test`**: Adding missing tests or correcting existing tests
- **`chore`**: Changes to the build process or auxiliary tools

### Examples

```bash
# New feature
git commit -m "feat: add support for video thumbnails"

# Bug fix
git commit -m "fix: handle null duration values correctly"

# Breaking change
git commit -m "feat!: change API to return Duration instead of int

BREAKING CHANGE: getDuration now returns Duration object instead of milliseconds"
```

## Pull Request Process

1. **Create a feature branch:**
   ```bash
   git checkout -b feat/your-feature-name
   ```

2. **Make your changes** and ensure all tests pass

3. **Follow conventional commit format** in your commit messages

4. **Update documentation** if you've changed APIs or added features

5. **Create a pull request** with a clear description

## Testing Requirements

All contributions must include appropriate tests:

- **Unit tests** for new functionality
- **Integration tests** for UI changes
- **Fluttium tests** for new user flows (if applicable)

## Code Style

This project follows [Very Good Analysis](https://pub.dev/packages/very_good_analysis) linting rules:

- Use `dart format` to format code
- Follow the existing code style
- Keep functions under 20 lines when possible
- Use meaningful variable and function names

## Release Process

Releases are automated using [release-please](https://github.com/googleapis/release-please):

1. **Conventional commits** trigger automatic version bumps
2. **Release PRs** are created automatically
3. **Merging release PRs** publishes to GitHub and pub.dev

No manual version management is needed - just follow the conventional commit format!

## Questions?

If you have questions about contributing, please open an issue or reach out to the maintainers.
