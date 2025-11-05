# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-11-05

### Added
- Initial release of postcode_checker package
- Support for 170+ countries and territories using ISO 3166-1 alpha-2 country codes
- Postal code validation using CLDR-based regex patterns (version 26.0.1)
- `PostcodeChecker` class with the following methods:
  - `validate()` - Validate a postal code for a specific country
  - `getPostalCodePattern()` - Get the regex pattern for a country
  - `hasPostalCodes()` - Check if a country has postal codes
  - `supportedCountries()` - List all supported countries
- `PostcodeValidationResult` class for detailed validation results
- `CountryCode` enum with all ISO 3166-1 alpha-2 codes
- `CountryCodeExtension` for easy access to country code strings
- Comprehensive unit tests covering major countries and edge cases
- Detailed documentation and examples
- Example application demonstrating all features

### Supported Regions
- **North America**: US, CA, MX, PR, and more
- **Europe**: GB, DE, FR, IT, ES, NL, PL, SE, and more
- **Asia-Pacific**: JP, CN, IN, AU, SG, KR, and more
- **South America**: BR, AR, CL, CO, and more
- **Africa & Middle East**: ZA, EG, IL, TR, SA, and more
- **Special Territories**: Various overseas territories and dependencies

### Documentation
- README.md with comprehensive usage guide
- API documentation with examples
- Example code demonstrating all features
- CHANGELOG.md for tracking changes
- LICENSE file (MIT)

### Quality
- 100+ unit tests covering various countries and formats
- Tests for edge cases (whitespace, empty strings, invalid formats)
- Clear error messages for validation failures
- Type-safe API using enums

## [Unreleased]

### Planned
- Support for postal code formatting (not just validation)
- Additional countries as patterns become available
- Performance optimizations for pattern matching
- Support for validating postal code ranges
- Integration with geocoding services

---

## Version History

- **1.0.0** (2025-11-05): Initial release with comprehensive postal code validation

---

## Migration Guide

### From 0.x to 1.0.0

This is the initial release, so no migration is needed.

---

## How to Contribute

See the [Contributing Guide](CONTRIBUTING.md) for information on how to contribute to this project.

## Reporting Issues

Please report issues on our [GitHub issue tracker](https://github.com/SamuelMTDavies/postcode/issues).
