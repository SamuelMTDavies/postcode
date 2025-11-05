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
///   final checker = PostcodeChecker();
///
///   // Validate a US ZIP code
///   final usResult = checker.validate(CountryCode.US, '12345');
///   print(usResult.isValid); // true
///
///   // Validate a UK postcode
///   final ukResult = checker.validate(CountryCode.GB, 'SW1A 1AA');
///   print(ukResult.isValid); // true
///
///   // Check if a country has postal codes
///   print(checker.hasPostalCodes(CountryCode.DE)); // true
///
///   // Get the regex pattern for a country
///   final pattern = checker.getPostalCodePattern(CountryCode.CA);
///   print(pattern); // [ABCEGHJKLMNPRSTVXY]\d[ABCEGHJ-NPRSTV-Z][ ]?\d[ABCEGHJ-NPRSTV-Z]\d
/// }
/// ```
library postcode_checker;

export 'src/country_code.dart';
export 'src/postcode_checker.dart';
