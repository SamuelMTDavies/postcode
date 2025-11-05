import 'package:postcode_checker/postcode_checker.dart';

void main() {
  final checker = PostcodeChecker();

  print('=== Postcode Checker Examples ===\n');

  // Example 1: Validate US ZIP codes
  print('Example 1: United States ZIP Codes');
  _validateAndPrint(checker, CountryCode.US, '12345');
  _validateAndPrint(checker, CountryCode.US, '12345-6789');
  _validateAndPrint(checker, CountryCode.US, 'INVALID');
  print('');

  // Example 2: Validate UK postcodes
  print('Example 2: United Kingdom Postcodes');
  _validateAndPrint(checker, CountryCode.GB, 'SW1A 1AA');
  _validateAndPrint(checker, CountryCode.GB, 'M1 1AA');
  _validateAndPrint(checker, CountryCode.GB, 'INVALID');
  print('');

  // Example 3: Validate Canadian postal codes
  print('Example 3: Canadian Postal Codes');
  _validateAndPrint(checker, CountryCode.CA, 'K1A 0B1');
  _validateAndPrint(checker, CountryCode.CA, 'M5W1E6');
  _validateAndPrint(checker, CountryCode.CA, 'D1A 0B1'); // Invalid (D not allowed)
  print('');

  // Example 4: Validate various European postal codes
  print('Example 4: European Postal Codes');
  _validateAndPrint(checker, CountryCode.DE, '10115'); // Germany
  _validateAndPrint(checker, CountryCode.FR, '75001'); // France
  _validateAndPrint(checker, CountryCode.IT, '00118'); // Italy
  _validateAndPrint(checker, CountryCode.ES, '28001'); // Spain
  _validateAndPrint(checker, CountryCode.NL, '1012 AB'); // Netherlands
  print('');

  // Example 5: Validate Asian postal codes
  print('Example 5: Asian Postal Codes');
  _validateAndPrint(checker, CountryCode.JP, '100-0001'); // Japan
  _validateAndPrint(checker, CountryCode.CN, '100000'); // China
  _validateAndPrint(checker, CountryCode.IN, '110001'); // India
  _validateAndPrint(checker, CountryCode.SG, '018956'); // Singapore
  print('');

  // Example 6: Validate South American postal codes
  print('Example 6: South American Postal Codes');
  _validateAndPrint(checker, CountryCode.BR, '01310-100'); // Brazil
  _validateAndPrint(checker, CountryCode.AR, 'C1425ABC'); // Argentina
  _validateAndPrint(checker, CountryCode.CL, '8320000'); // Chile
  print('');

  // Example 7: Check if countries have postal codes
  print('Example 7: Check Postal Code Support');
  print('Does US have postal codes? ${checker.hasPostalCodes(CountryCode.US)}');
  print('Does GB have postal codes? ${checker.hasPostalCodes(CountryCode.GB)}');
  print('Does AO have postal codes? ${checker.hasPostalCodes(CountryCode.AO)}');
  print('');

  // Example 8: Get postal code pattern for a country
  print('Example 8: Get Regex Patterns');
  print('US pattern: ${checker.getPostalCodePattern(CountryCode.US)}');
  print('CA pattern: ${checker.getPostalCodePattern(CountryCode.CA)}');
  print('JP pattern: ${checker.getPostalCodePattern(CountryCode.JP)}');
  print('');

  // Example 9: List all supported countries
  print('Example 9: Supported Countries');
  final supportedCountries = checker.supportedCountries();
  print('Total supported countries: ${supportedCountries.length}');
  print('First 10 supported countries:');
  for (var i = 0; i < 10 && i < supportedCountries.length; i++) {
    print('  - ${supportedCountries[i].code}');
  }
  print('');

  // Example 10: Working with validation results
  print('Example 10: Detailed Validation Results');
  final result = checker.validate(CountryCode.US, '12345');
  print('Country: ${result.countryCode.code}');
  print('Postal Code: ${result.postalCode}');
  print('Is Valid: ${result.isValid}');
  print('Error Message: ${result.errorMessage ?? 'None'}');
}

void _validateAndPrint(
  PostcodeChecker checker,
  CountryCode country,
  String postalCode,
) {
  final result = checker.validate(country, postalCode);
  final status = result.isValid ? '✓' : '✗';
  print('  $status ${country.code}: "$postalCode" - ${result.isValid ? 'Valid' : result.errorMessage}');
}
