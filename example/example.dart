import 'package:postcode_checker/postcode_checker.dart';

void main() {
  print('=== Postcode Checker Examples ===\n');

  // Example 1: Validate US ZIP codes
  print('Example 1: United States ZIP Codes');
  _validateAndPrint(CountryCode.US, '12345');
  _validateAndPrint(CountryCode.US, '12345-6789');
  _validateAndPrint(CountryCode.US, 'INVALID');
  print('');

  // Example 2: Validate UK postcodes
  print('Example 2: United Kingdom Postcodes');
  _validateAndPrint(CountryCode.GB, 'SW1A 1AA');
  _validateAndPrint(CountryCode.GB, 'M1 1AA');
  _validateAndPrint(CountryCode.GB, 'INVALID');
  print('');

  // Example 3: Validate Canadian postal codes
  print('Example 3: Canadian Postal Codes');
  _validateAndPrint(CountryCode.CA, 'K1A 0B1');
  _validateAndPrint(CountryCode.CA, 'M5W1E6');
  _validateAndPrint(CountryCode.CA, 'D1A 0B1'); // Invalid (D not allowed)
  print('');

  // Example 4: Validate various European postal codes
  print('Example 4: European Postal Codes');
  _validateAndPrint(CountryCode.DE, '10115'); // Germany
  _validateAndPrint(CountryCode.FR, '75001'); // France
  _validateAndPrint(CountryCode.IT, '00118'); // Italy
  _validateAndPrint(CountryCode.ES, '28001'); // Spain
  _validateAndPrint(CountryCode.NL, '1012 AB'); // Netherlands
  print('');

  // Example 5: Validate Asian postal codes
  print('Example 5: Asian Postal Codes');
  _validateAndPrint(CountryCode.JP, '100-0001'); // Japan
  _validateAndPrint(CountryCode.CN, '100000'); // China
  _validateAndPrint(CountryCode.IN, '110001'); // India
  _validateAndPrint(CountryCode.SG, '018956'); // Singapore
  print('');

  // Example 6: Validate South American postal codes
  print('Example 6: South American Postal Codes');
  _validateAndPrint(CountryCode.BR, '01310-100'); // Brazil
  _validateAndPrint(CountryCode.AR, 'C1425ABC'); // Argentina
  _validateAndPrint(CountryCode.CL, '8320000'); // Chile
  print('');

  // Example 7: Check if countries have postal codes
  print('Example 7: Check Postal Code Support');
  print(
      'Does US have postal codes? ${PostcodeChecker.hasPostalCodes(CountryCode.US)}');
  print(
      'Does GB have postal codes? ${PostcodeChecker.hasPostalCodes(CountryCode.GB)}');
  print(
      'Does AO have postal codes? ${PostcodeChecker.hasPostalCodes(CountryCode.AO)}');
  print('');

  // Example 8: Get postal code pattern for a country
  print('Example 8: Get Regex Patterns');
  print('US pattern: ${PostcodeChecker.getPostalCodePattern(CountryCode.US)}');
  print('CA pattern: ${PostcodeChecker.getPostalCodePattern(CountryCode.CA)}');
  print('JP pattern: ${PostcodeChecker.getPostalCodePattern(CountryCode.JP)}');
  print('');

  // Example 9: List all supported countries
  print('Example 9: Supported Countries');
  final supportedCountries = PostcodeChecker.supportedCountries();
  print('Total supported countries: ${supportedCountries.length}');
  print('First 10 supported countries:');
  for (var i = 0; i < 10 && i < supportedCountries.length; i++) {
    print('  - ${supportedCountries[i].code}');
  }
  print('');

  // Example 10: Working with validation results and error handling
  print('Example 10: Detailed Validation Results & Error Handling');

  // Valid result
  final validResult = PostcodeChecker.validate(CountryCode.US, '12345');
  print('Country: ${validResult.countryCode.code}');
  print('Postal Code: ${validResult.postalCode}');
  print('Is Valid: ${validResult.isValid}');
  print('Error: ${validResult.errorMessage ?? 'None'}');
  print('');

  // Invalid format error
  final invalidFormat = PostcodeChecker.validate(CountryCode.US, 'ABC');
  print('Invalid format example:');
  print('  Error Type: ${invalidFormat.error}');
  print('  Error Code: ${invalidFormat.errorCode}');
  print('  Error Message: ${invalidFormat.errorMessage}');
  print('');

  // Empty postal code error
  final emptyCode = PostcodeChecker.validate(CountryCode.US, '');
  print('Empty postal code example:');
  print('  Error Type: ${emptyCode.error}');
  print('  Error Code: ${emptyCode.errorCode}');
  print('  Error Message: ${emptyCode.errorMessage}');
  print('');

  // No postal code system error
  final noSystem = PostcodeChecker.validate(CountryCode.AO, '12345');
  print('No postal code system example:');
  print('  Error Type: ${noSystem.error}');
  print('  Error Code: ${noSystem.errorCode}');
  print('  Error Message: ${noSystem.errorMessage}');
}

void _validateAndPrint(CountryCode country, String postalCode) {
  final result = PostcodeChecker.validate(country, postalCode);
  final status = result.isValid ? '✓' : '✗';
  final message = result.isValid ? 'Valid' : result.errorMessage;
  print('  $status ${country.code}: "$postalCode" - $message');
}
