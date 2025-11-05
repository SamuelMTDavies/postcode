/// A comprehensive Dart package for validating postal codes from countries
/// worldwide using ISO 3166-1 alpha-2 country codes.
///
/// This package provides postal code validation using regex patterns from the
/// Unicode CLDR (Common Locale Data Repository) version 26.0.1, which was the
/// last version to include postal code data.
///
/// ## Usage
///
/// ```dart
/// import 'package:postcode_checker/postcode_checker.dart';
///
/// void main() {
///   // Validate a US ZIP code
///   final usResult = PostcodeChecker.validate(CountryCode.US, '12345');
///   print(usResult.isValid); // true
///
///   // Validate a UK postcode
///   final ukResult = PostcodeChecker.validate(CountryCode.GB, 'SW1A 1AA');
///   print(ukResult.isValid); // true
///
///   // Handle validation errors
///   final invalidResult = PostcodeChecker.validate(CountryCode.US, 'ABC');
///   if (!invalidResult.isValid) {
///     print(invalidResult.errorMessage); // Error message
///     print(invalidResult.errorCode); // Error code
///   }
///
///   // Check if a country has postal codes
///   print(PostcodeChecker.hasPostalCodes(CountryCode.DE)); // true
///
///   // Get the regex pattern for a country
///   final pattern = PostcodeChecker.getPostalCodePattern(CountryCode.CA);
///   print(pattern); // [ABCEGHJKLMNPRSTVXY]\d[ABCEGHJ-NPRSTV-Z][ ]?\d[ABCEGHJ-NPRSTV-Z]\d
/// }
/// ```
library postcode_checker;

export 'src/country_code.dart';
export 'src/postcode_checker.dart';
export 'src/postcode_validation_error.dart';
