# Contributing to postcode_checker

First off, thank you for considering contributing to postcode_checker! It's people like you that make this package better for everyone.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
  - [Reporting Bugs](#reporting-bugs)
  - [Suggesting Enhancements](#suggesting-enhancements)
  - [Adding New Country Patterns](#adding-new-country-patterns)
  - [Pull Requests](#pull-requests)
- [Development Setup](#development-setup)
- [Style Guidelines](#style-guidelines)
- [Testing Guidelines](#testing-guidelines)

## Code of Conduct

This project and everyone participating in it is governed by a Code of Conduct. By participating, you are expected to uphold this code. Please be respectful and constructive in all interactions.

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check the existing issues to avoid duplicates. When you create a bug report, include as many details as possible:

- **Use a clear and descriptive title**
- **Describe the exact steps to reproduce the problem**
- **Provide specific examples** (code snippets, postal codes that fail)
- **Describe the behavior you observed** and what you expected
- **Include your Dart version** and platform (if relevant)

Example bug report:

```markdown
**Title**: Invalid validation for UK postcode "EC1A 1BB"

**Description**:
The postcode "EC1A 1BB" is a valid UK postcode but is being rejected by the validator.

**Steps to Reproduce**:
1. Create a PostcodeChecker instance
2. Call validate(CountryCode.GB, 'EC1A 1BB')
3. Result shows isValid = false

**Expected Behavior**:
Should return isValid = true

**Actual Behavior**:
Returns isValid = false

**Dart Version**: 3.0.0
```

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion, include:

- **Use a clear and descriptive title**
- **Provide a detailed description** of the suggested enhancement
- **Explain why this enhancement would be useful**
- **Provide examples** of how it would be used

### Adding New Country Patterns

To add support for a new country or improve an existing pattern:

1. **Research the postal code format**
   - Check the country's postal service website
   - Verify against CLDR data if available
   - Look for official government documentation

2. **Add the pattern** to `lib/src/postcode_checker.dart`:
   ```dart
   case CountryCode.XX:
     return r'\d{5}'; // Your pattern here
   ```

3. **Add comprehensive tests** in `test/postcode_checker_test.dart`:
   ```dart
   group('PostcodeChecker - Country Name (XX)', () {
     test('validates standard format', () {
       final result = checker.validate(CountryCode.XX, '12345');
       expect(result.isValid, isTrue);
     });

     test('validates various formats', () {
       final validCodes = ['12345', '67890'];
       for (final code in validCodes) {
         final result = checker.validate(CountryCode.XX, code);
         expect(result.isValid, isTrue, reason: 'Failed: $code');
       }
     });

     test('rejects invalid format', () {
       final result = checker.validate(CountryCode.XX, 'INVALID');
       expect(result.isValid, isFalse);
     });
   });
   ```

4. **Document your sources** in the pull request description

### Pull Requests

1. **Fork the repository** and create your branch from `main`
2. **Make your changes** following the style guidelines
3. **Add tests** for any new functionality
4. **Ensure all tests pass**: `dart test`
5. **Ensure code is formatted**: `dart format .`
6. **Ensure no analysis issues**: `dart analyze`
7. **Update documentation** as needed
8. **Commit your changes** with clear commit messages
9. **Push to your fork** and submit a pull request

#### Pull Request Guidelines

- **One feature per PR**: Keep pull requests focused on a single feature or bug fix
- **Write clear descriptions**: Explain what changes you made and why
- **Reference issues**: If your PR fixes an issue, reference it (e.g., "Fixes #123")
- **Update CHANGELOG**: Add your changes to the CHANGELOG.md under "Unreleased"
- **Follow semantic versioning**: Indicate if your change is a breaking change

Example PR description:

```markdown
## Description
Adds support for Swedish postal codes.

## Changes
- Added pattern for CountryCode.SE in postcode_checker.dart
- Added comprehensive tests for Swedish postal codes
- Updated README with Sweden in supported countries list

## Testing
- All existing tests pass
- Added 5 new test cases for Swedish postal codes
- Manually tested with real Swedish postal codes

## References
- Pattern based on CLDR data: [link]
- Swedish postal service documentation: [link]

Fixes #45
```

## Development Setup

### Prerequisites

- Dart SDK 3.0.0 or higher
- Git

### Setup Steps

1. Clone your fork:
   ```bash
   git clone https://github.com/YOUR_USERNAME/postcode.git
   cd postcode
   ```

2. Install dependencies:
   ```bash
   dart pub get
   ```

3. Run tests to verify setup:
   ```bash
   dart test
   ```

4. Create a new branch:
   ```bash
   git checkout -b feature/my-new-feature
   ```

### Running Tests

```bash
# Run all tests
dart test

# Run specific test file
dart test test/postcode_checker_test.dart

# Run tests with coverage
dart test --coverage=coverage

# Format coverage report
dart pub global activate coverage
dart pub global run coverage:format_coverage --lcov --in=coverage --out=coverage/lcov.info --report-on=lib
```

### Code Formatting

```bash
# Format all Dart files
dart format .

# Check formatting without making changes
dart format --output=none --set-exit-if-changed .
```

### Static Analysis

```bash
# Analyze all Dart files
dart analyze

# Analyze with specific options
dart analyze --fatal-infos
```

## Style Guidelines

### Dart Style

- Follow the [official Dart style guide](https://dart.dev/guides/language/effective-dart/style)
- Use `dart format` to automatically format code
- Maximum line length: 80 characters
- Use single quotes for strings unless interpolating

### Code Organization

- Keep functions focused and single-purpose
- Use clear, descriptive variable names
- Add documentation comments for public APIs
- Group related code together

### Documentation

- Use `///` for documentation comments
- Include examples in documentation where helpful
- Document all parameters and return values
- Keep documentation up-to-date with code changes

Example:

```dart
/// Validates a postal code for the specified country.
///
/// Returns a [PostcodeValidationResult] containing the validation status
/// and any error messages.
///
/// Example:
/// ```dart
/// final checker = PostcodeChecker();
/// final result = checker.validate(CountryCode.US, '12345');
/// if (result.isValid) {
///   print('Valid postal code!');
/// }
/// ```
PostcodeValidationResult validate(CountryCode countryCode, String postalCode);
```

## Testing Guidelines

### Test Structure

- Use descriptive test names that explain what is being tested
- Group related tests using `group()`
- Use `setUp()` and `tearDown()` for common test setup/cleanup
- Test both success and failure cases

### Test Coverage

- Aim for high test coverage (>90%)
- Test edge cases (empty strings, whitespace, special characters)
- Test all supported countries (at least representative samples)
- Test error conditions and error messages

### Test Naming

```dart
// Good
test('validates standard 5-digit ZIP code', () { ... });
test('rejects ZIP code with letters', () { ... });

// Bad
test('test1', () { ... });
test('zip code', () { ... });
```

## Commit Messages

Write clear, concise commit messages:

- Use the imperative mood ("Add feature" not "Added feature")
- First line should be 50 characters or less
- Provide detailed explanation in the body if needed
- Reference issues and PRs where appropriate

Example:

```
Add support for Swedish postal codes

- Implement SE pattern from CLDR data
- Add comprehensive test coverage
- Update documentation

Fixes #45
```

## Questions?

If you have questions about contributing, feel free to:

- Open an issue with the "question" label
- Start a discussion on GitHub Discussions
- Contact the maintainers

Thank you for contributing to postcode_checker!
