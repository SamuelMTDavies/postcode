# postcode_checker

A comprehensive Dart package for validating postal codes from countries worldwide using ISO 3166-1 alpha-2 country codes and CLDR-based regex patterns.

[![Pub Version](https://img.shields.io/pub/v/postcode_checker)](https://pub.dev/packages/postcode_checker)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

## Features

- ✅ **Comprehensive Coverage**: Supports 170+ countries and territories
- 🌍 **ISO 3166-1 Standard**: Uses official alpha-2 country codes
- 🎯 **CLDR-Based Patterns**: Regex patterns from Unicode CLDR v26.0.1
- 🔍 **Simple Static API**: Clean, no-instantiation design
- 🚨 **Type-Safe Error Handling**: Enum-based error types with clear messages
- 📦 **Zero Dependencies**: No external dependencies required
- 🧪 **Well Tested**: Comprehensive unit test coverage
- 📚 **Well Documented**: Clear examples and API documentation

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  postcode_checker: ^1.0.0
```

Then run:

```bash
dart pub get
```

## Usage

### Basic Validation

```dart
import 'package:postcode_checker/postcode_checker.dart';

void main() {
  // Validate a US ZIP code
  final usResult = PostcodeChecker.validate(CountryCode.US, '12345');
  print(usResult.isValid); // true

  // Validate a UK postcode
  final ukResult = PostcodeChecker.validate(CountryCode.GB, 'SW1A 1AA');
  print(ukResult.isValid); // true

  // Validate an invalid postal code
  final invalidResult = PostcodeChecker.validate(CountryCode.US, 'INVALID');
  print(invalidResult.isValid); // false
  print(invalidResult.errorMessage); // Error description
}
```

### Working with Validation Results

```dart
final result = PostcodeChecker.validate(CountryCode.CA, 'K1A 0B1');

if (result.isValid) {
  print('Valid postal code for ${result.countryCode.code}');
} else {
  print('Invalid: ${result.errorMessage}');
}
```

### Error Handling

The package provides type-safe error handling with clear error messages:

```dart
// Empty postal code error
final emptyResult = PostcodeChecker.validate(CountryCode.US, '');
print(emptyResult.error); // PostcodeValidationError.emptyPostalCode
print(emptyResult.errorCode); // 'EMPTY_POSTAL_CODE'
print(emptyResult.errorMessage); // 'Postal code cannot be empty or contain only whitespace.'

// Invalid format error
final invalidResult = PostcodeChecker.validate(CountryCode.US, 'ABC');
print(invalidResult.error); // PostcodeValidationError.invalidFormat
print(invalidResult.errorCode); // 'INVALID_FORMAT'
print(invalidResult.errorMessage); // 'The postal code does not match the expected format for this country.'

// No postal code system error
final noSystemResult = PostcodeChecker.validate(CountryCode.AO, '12345');
print(noSystemResult.error); // PostcodeValidationError.noPostalCodeSystem
print(noSystemResult.errorCode); // 'NO_POSTAL_CODE_SYSTEM'
```

Available error types:
- `PostcodeValidationError.emptyPostalCode` - Empty or whitespace-only input
- `PostcodeValidationError.invalidFormat` - Postal code doesn't match country pattern
- `PostcodeValidationError.noPostalCodeSystem` - Country doesn't use postal codes
- `PostcodeValidationError.unsupportedCountry` - Country code not recognized

### Check if a Country Has Postal Codes

```dart
print(PostcodeChecker.hasPostalCodes(CountryCode.US)); // true
print(PostcodeChecker.hasPostalCodes(CountryCode.GB)); // true
print(PostcodeChecker.hasPostalCodes(CountryCode.AO)); // false (Angola has no postal codes)
```

### Get Postal Code Pattern

```dart
final pattern = PostcodeChecker.getPostalCodePattern(CountryCode.US);
print(pattern); // \d{5}([ \-]\d{4})?

final caPattern = PostcodeChecker.getPostalCodePattern(CountryCode.CA);
print(caPattern); // [ABCEGHJKLMNPRSTVXY]\d[ABCEGHJ-NPRSTV-Z][ ]?\d[ABCEGHJ-NPRSTV-Z]\d
```

### List Supported Countries

```dart
final countries = PostcodeChecker.supportedCountries();
print('Supported countries: ${countries.length}');

for (final country in countries.take(5)) {
  print(country.code);
}
```

## Supported Countries

This package supports postal code validation for 170+ countries and territories, including:

### North America
- 🇺🇸 United States (US)
- 🇨🇦 Canada (CA)
- 🇲🇽 Mexico (MX)
- 🇵🇷 Puerto Rico (PR)

### Europe
- 🇬🇧 United Kingdom (GB)
- 🇩🇪 Germany (DE)
- 🇫🇷 France (FR)
- 🇮🇹 Italy (IT)
- 🇪🇸 Spain (ES)
- 🇳🇱 Netherlands (NL)
- 🇵🇱 Poland (PL)
- 🇸🇪 Sweden (SE)
- And many more...

### Asia-Pacific
- 🇯🇵 Japan (JP)
- 🇨🇳 China (CN)
- 🇮🇳 India (IN)
- 🇦🇺 Australia (AU)
- 🇸🇬 Singapore (SG)
- 🇰🇷 South Korea (KR)
- And many more...

### South America
- 🇧🇷 Brazil (BR)
- 🇦🇷 Argentina (AR)
- 🇨🇱 Chile (CL)
- 🇨🇴 Colombia (CO)
- And more...

### Africa & Middle East
- 🇿🇦 South Africa (ZA)
- 🇪🇬 Egypt (EG)
- 🇮🇱 Israel (IL)
- 🇹🇷 Turkey (TR)
- 🇸🇦 Saudi Arabia (SA)
- And more...

See the [full list of supported countries](https://github.com/SamuelMTDavies/postcode/blob/main/SUPPORTED_COUNTRIES.md) or use `PostcodeChecker.supportedCountries()` to get a complete list.

## Examples

### Validate Multiple Countries

```dart
final testCases = {
  CountryCode.US: ['12345', '12345-6789', 'INVALID'],
  CountryCode.GB: ['SW1A 1AA', 'M1 1AA', '12345'],
  CountryCode.DE: ['10115', '80331', '1234'],
  CountryCode.JP: ['100-0001', '060-0001', '1000001'],
};

for (final entry in testCases.entries) {
  final country = entry.key;
  final codes = entry.value;

  print('Testing ${country.code}:');
  for (final code in codes) {
    final result = PostcodeChecker.validate(country, code);
    print('  ${code}: ${result.isValid}');
  }
}
```

### Custom Validation Function

```dart
bool isValidPostalCode(String countryCode, String postalCode) {
  // Parse country code string to enum
  final country = CountryCode.values.firstWhere(
    (c) => c.code == countryCode.toUpperCase(),
    orElse: () => throw ArgumentError('Invalid country code: $countryCode'),
  );

  return PostcodeChecker.validate(country, postalCode).isValid;
}

// Usage
print(isValidPostalCode('US', '12345')); // true
print(isValidPostalCode('GB', 'SW1A 1AA')); // true
```

## API Reference

### `PostcodeChecker`

The main class for validating postal codes.

#### Methods

- **`validate(CountryCode countryCode, String postalCode)`**: Validates a postal code for the specified country. Returns a `PostcodeValidationResult`.

- **`getPostalCodePattern(CountryCode countryCode)`**: Returns the regex pattern for the specified country, or `null` if not available.

- **`hasPostalCodes(CountryCode countryCode)`**: Returns `true` if the country has a postal code system.

- **`supportedCountries()`**: Returns a list of all countries with postal code validation support.

### `PostcodeValidationResult`

Represents the result of a postal code validation.

#### Properties

- **`isValid`**: Whether the postal code is valid.
- **`countryCode`**: The country code used for validation.
- **`postalCode`**: The postal code that was validated.
- **`errorMessage`**: Optional error message if validation failed.

#### Factory Methods

- **`PostcodeValidationResult.valid(CountryCode, String)`**: Creates a successful validation result.
- **`PostcodeValidationResult.invalid(CountryCode, String, String)`**: Creates a failed validation result.

### `CountryCode`

Enum representing ISO 3166-1 alpha-2 country codes.

#### Extension Methods

- **`code`**: Returns the two-letter country code as a string.

## Data Source

The postal code validation patterns in this package are based on the **Unicode CLDR (Common Locale Data Repository) version 26.0.1**, which was the last version to include postal code data before it was deprecated in 2016.

CLDR was chosen as the primary data source because:

- ✅ Maintained by the Unicode Consortium
- ✅ Widely used and tested
- ✅ Comprehensive coverage of 170+ territories
- ✅ Well-documented regex patterns

For countries not covered by CLDR, patterns may be sourced from other reliable sources such as government postal services or international standards organizations.

## Pattern Format

All postal code patterns support:

- **Optional spacing**: Many patterns allow optional spaces (e.g., `SW1A 1AA` or `SW1A1AA`)
- **Optional separators**: Hyphens and spaces where commonly used (e.g., `12345-6789`)
- **Case insensitivity**: Patterns work with both uppercase and lowercase letters
- **Strict validation**: Only validates the format, not whether the code actually exists

## Contributing

Contributions are welcome! If you find a bug or want to add support for additional countries, please:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes with tests
4. Commit your changes (`git commit -m 'Add amazing feature'`)
5. Push to the branch (`git push origin feature/amazing-feature`)
6. Open a Pull Request

### Adding a New Country Pattern

To add support for a new country:

1. Add the pattern to the switch statement in `lib/src/postcode_checker.dart`
2. Add comprehensive tests in `test/postcode_checker_test.dart`
3. Update the documentation

## Testing

Run the test suite:

```bash
dart test
```

Run tests with coverage:

```bash
dart test --coverage=coverage
dart pub global run coverage:format_coverage --lcov --in=coverage --out=coverage/lcov.info --report-on=lib
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- **Unicode CLDR**: For providing comprehensive postal code patterns
- **ISO 3166**: For the international standard of country codes
- All contributors who help improve this package

## Support

If you find this package helpful, please:

- ⭐ Star the repository on [GitHub](https://github.com/SamuelMTDavies/postcode)
- 🐛 Report issues on the [issue tracker](https://github.com/SamuelMTDavies/postcode/issues)
- 📝 Contribute improvements via pull requests

## Versioning

This package follows [Semantic Versioning](https://semver.org/):

- **MAJOR** version for incompatible API changes
- **MINOR** version for backwards-compatible functionality additions
- **PATCH** version for backwards-compatible bug fixes

Current version: **1.0.0**

## Related Packages

- [phone_number](https://pub.dev/packages/phone_number) - Phone number validation
- [email_validator](https://pub.dev/packages/email_validator) - Email validation
- [international_phone_input](https://pub.dev/packages/international_phone_input) - International phone input widget

---

Made with ❤️ by the postcode_checker team
