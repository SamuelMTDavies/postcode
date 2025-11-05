import 'package:postcode_checker/postcode_checker.dart';
import 'package:test/test.dart';

void main() {
  late PostcodeChecker checker;

  setUp(() {
    checker = const PostcodeChecker();
  });

  group('PostcodeChecker - United States (US)', () {
    test('validates standard 5-digit ZIP code', () {
      final result = checker.validate(CountryCode.US, '12345');
      expect(result.isValid, isTrue);
      expect(result.countryCode, equals(CountryCode.US));
    });

    test('validates ZIP+4 code with hyphen', () {
      final result = checker.validate(CountryCode.US, '12345-6789');
      expect(result.isValid, isTrue);
    });

    test('validates ZIP+4 code with space', () {
      final result = checker.validate(CountryCode.US, '12345 6789');
      expect(result.isValid, isTrue);
    });

    test('rejects invalid US postal code', () {
      final result = checker.validate(CountryCode.US, '1234');
      expect(result.isValid, isFalse);
      expect(result.errorMessage, isNotNull);
    });

    test('rejects letters in US postal code', () {
      final result = checker.validate(CountryCode.US, 'ABCDE');
      expect(result.isValid, isFalse);
    });
  });

  group('PostcodeChecker - United Kingdom (GB)', () {
    test('validates standard UK postcode with space', () {
      final result = checker.validate(CountryCode.GB, 'SW1A 1AA');
      expect(result.isValid, isTrue);
    });

    test('validates UK postcode without space', () {
      final result = checker.validate(CountryCode.GB, 'SW1A1AA');
      expect(result.isValid, isTrue);
    });

    test('validates GIR 0AA special postcode', () {
      final result = checker.validate(CountryCode.GB, 'GIR 0AA');
      expect(result.isValid, isTrue);
    });

    test('validates various UK postcode formats', () {
      final validCodes = [
        'M1 1AA',
        'M60 1NW',
        'CR2 6XH',
        'DN55 1PT',
        'W1A 1HQ',
        'EC1A 1BB',
      ];

      for (final code in validCodes) {
        final result = checker.validate(CountryCode.GB, code);
        expect(result.isValid, isTrue, reason: 'Failed to validate: $code');
      }
    });

    test('rejects invalid UK postcode', () {
      final result = checker.validate(CountryCode.GB, '12345');
      expect(result.isValid, isFalse);
    });
  });

  group('PostcodeChecker - Canada (CA)', () {
    test('validates Canadian postal code with space', () {
      final result = checker.validate(CountryCode.CA, 'K1A 0B1');
      expect(result.isValid, isTrue);
    });

    test('validates Canadian postal code without space', () {
      final result = checker.validate(CountryCode.CA, 'K1A0B1');
      expect(result.isValid, isTrue);
    });

    test('validates various Canadian postal codes', () {
      final validCodes = [
        'M5W 1E6',
        'H2Y 1C6',
        'V6B 1A1',
        'T2P 2G8',
      ];

      for (final code in validCodes) {
        final result = checker.validate(CountryCode.CA, code);
        expect(result.isValid, isTrue, reason: 'Failed to validate: $code');
      }
    });

    test('rejects postal code with invalid characters (D, F, I, O, Q, U)', () {
      final invalidCodes = ['D1A 0B1', 'K1F 0B1', 'K1A 0I1'];

      for (final code in invalidCodes) {
        final result = checker.validate(CountryCode.CA, code);
        expect(result.isValid, isFalse, reason: 'Should reject: $code');
      }
    });
  });

  group('PostcodeChecker - Germany (DE)', () {
    test('validates 5-digit German postal code', () {
      final result = checker.validate(CountryCode.DE, '10115');
      expect(result.isValid, isTrue);
    });

    test('validates various German postal codes', () {
      final validCodes = ['01067', '20095', '80331', '50667', '60311'];

      for (final code in validCodes) {
        final result = checker.validate(CountryCode.DE, code);
        expect(result.isValid, isTrue, reason: 'Failed to validate: $code');
      }
    });

    test('rejects invalid German postal code', () {
      final result = checker.validate(CountryCode.DE, '1234');
      expect(result.isValid, isFalse);
    });
  });

  group('PostcodeChecker - France (FR)', () {
    test('validates French postal code', () {
      final result = checker.validate(CountryCode.FR, '75001');
      expect(result.isValid, isTrue);
    });

    test('validates French postal code with space', () {
      final result = checker.validate(CountryCode.FR, '75 001');
      expect(result.isValid, isTrue);
    });

    test('validates various French postal codes', () {
      final validCodes = ['75001', '13001', '69001', '33000', '31000'];

      for (final code in validCodes) {
        final result = checker.validate(CountryCode.FR, code);
        expect(result.isValid, isTrue, reason: 'Failed to validate: $code');
      }
    });
  });

  group('PostcodeChecker - Japan (JP)', () {
    test('validates Japanese postal code with hyphen', () {
      final result = checker.validate(CountryCode.JP, '100-0001');
      expect(result.isValid, isTrue);
    });

    test('rejects Japanese postal code without hyphen', () {
      final result = checker.validate(CountryCode.JP, '1000001');
      expect(result.isValid, isFalse);
    });

    test('validates various Japanese postal codes', () {
      final validCodes = [
        '100-0001',
        '060-0001',
        '530-0001',
        '450-0001',
        '810-0001',
      ];

      for (final code in validCodes) {
        final result = checker.validate(CountryCode.JP, code);
        expect(result.isValid, isTrue, reason: 'Failed to validate: $code');
      }
    });
  });

  group('PostcodeChecker - Australia (AU)', () {
    test('validates 4-digit Australian postal code', () {
      final result = checker.validate(CountryCode.AU, '2000');
      expect(result.isValid, isTrue);
    });

    test('validates various Australian postal codes', () {
      final validCodes = ['2000', '3000', '4000', '6000', '0800'];

      for (final code in validCodes) {
        final result = checker.validate(CountryCode.AU, code);
        expect(result.isValid, isTrue, reason: 'Failed to validate: $code');
      }
    });

    test('rejects invalid Australian postal code', () {
      final result = checker.validate(CountryCode.AU, '12345');
      expect(result.isValid, isFalse);
    });
  });

  group('PostcodeChecker - Netherlands (NL)', () {
    test('validates Dutch postal code with space', () {
      final result = checker.validate(CountryCode.NL, '1012 AB');
      expect(result.isValid, isTrue);
    });

    test('validates Dutch postal code without space', () {
      final result = checker.validate(CountryCode.NL, '1012AB');
      expect(result.isValid, isTrue);
    });

    test('validates various Dutch postal codes', () {
      final validCodes = ['1012 AB', '2584 CD', '3011 EF', '5611 GH'];

      for (final code in validCodes) {
        final result = checker.validate(CountryCode.NL, code);
        expect(result.isValid, isTrue, reason: 'Failed to validate: $code');
      }
    });

    test('rejects postal code without letters', () {
      final result = checker.validate(CountryCode.NL, '1012');
      expect(result.isValid, isFalse);
    });
  });

  group('PostcodeChecker - Brazil (BR)', () {
    test('validates Brazilian postal code with hyphen', () {
      final result = checker.validate(CountryCode.BR, '01310-100');
      expect(result.isValid, isTrue);
    });

    test('validates Brazilian postal code without hyphen', () {
      final result = checker.validate(CountryCode.BR, '01310100');
      expect(result.isValid, isTrue);
    });

    test('validates various Brazilian postal codes', () {
      final validCodes = [
        '01310-100',
        '20040-020',
        '30130-010',
        '40015-010',
      ];

      for (final code in validCodes) {
        final result = checker.validate(CountryCode.BR, code);
        expect(result.isValid, isTrue, reason: 'Failed to validate: $code');
      }
    });
  });

  group('PostcodeChecker - India (IN)', () {
    test('validates 6-digit Indian PIN code', () {
      final result = checker.validate(CountryCode.IN, '110001');
      expect(result.isValid, isTrue);
    });

    test('validates various Indian PIN codes', () {
      final validCodes = ['110001', '400001', '560001', '700001', '600001'];

      for (final code in validCodes) {
        final result = checker.validate(CountryCode.IN, code);
        expect(result.isValid, isTrue, reason: 'Failed to validate: $code');
      }
    });

    test('rejects invalid Indian PIN code', () {
      final result = checker.validate(CountryCode.IN, '12345');
      expect(result.isValid, isFalse);
    });
  });

  group('PostcodeChecker - China (CN)', () {
    test('validates 6-digit Chinese postal code', () {
      final result = checker.validate(CountryCode.CN, '100000');
      expect(result.isValid, isTrue);
    });

    test('validates various Chinese postal codes', () {
      final validCodes = ['100000', '200000', '310000', '400000', '510000'];

      for (final code in validCodes) {
        final result = checker.validate(CountryCode.CN, code);
        expect(result.isValid, isTrue, reason: 'Failed to validate: $code');
      }
    });
  });

  group('PostcodeChecker - South Korea (KR)', () {
    test('validates Korean postal code with hyphen', () {
      final result = checker.validate(CountryCode.KR, '100-011');
      expect(result.isValid, isTrue);
    });

    test('validates Korean postal code without hyphen', () {
      final result = checker.validate(CountryCode.KR, '100011');
      expect(result.isValid, isTrue);
    });
  });

  group('PostcodeChecker - Spain (ES)', () {
    test('validates 5-digit Spanish postal code', () {
      final result = checker.validate(CountryCode.ES, '28001');
      expect(result.isValid, isTrue);
    });

    test('validates various Spanish postal codes', () {
      final validCodes = ['28001', '08001', '41001', '46001', '29001'];

      for (final code in validCodes) {
        final result = checker.validate(CountryCode.ES, code);
        expect(result.isValid, isTrue, reason: 'Failed to validate: $code');
      }
    });
  });

  group('PostcodeChecker - Italy (IT)', () {
    test('validates 5-digit Italian postal code', () {
      final result = checker.validate(CountryCode.IT, '00118');
      expect(result.isValid, isTrue);
    });

    test('validates various Italian postal codes', () {
      final validCodes = ['00118', '20121', '10121', '50122', '80138'];

      for (final code in validCodes) {
        final result = checker.validate(CountryCode.IT, code);
        expect(result.isValid, isTrue, reason: 'Failed to validate: $code');
      }
    });
  });

  group('PostcodeChecker - Switzerland (CH)', () {
    test('validates 4-digit Swiss postal code', () {
      final result = checker.validate(CountryCode.CH, '8001');
      expect(result.isValid, isTrue);
    });

    test('validates various Swiss postal codes', () {
      final validCodes = ['8001', '1200', '3000', '4000', '6900'];

      for (final code in validCodes) {
        final result = checker.validate(CountryCode.CH, code);
        expect(result.isValid, isTrue, reason: 'Failed to validate: $code');
      }
    });
  });

  group('PostcodeChecker - Poland (PL)', () {
    test('validates Polish postal code with hyphen', () {
      final result = checker.validate(CountryCode.PL, '00-950');
      expect(result.isValid, isTrue);
    });

    test('validates various Polish postal codes', () {
      final validCodes = ['00-950', '30-363', '50-073', '60-101', '80-001'];

      for (final code in validCodes) {
        final result = checker.validate(CountryCode.PL, code);
        expect(result.isValid, isTrue, reason: 'Failed to validate: $code');
      }
    });

    test('rejects Polish postal code without hyphen', () {
      final result = checker.validate(CountryCode.PL, '00950');
      expect(result.isValid, isFalse);
    });
  });

  group('PostcodeChecker - Sweden (SE)', () {
    test('validates Swedish postal code with space', () {
      final result = checker.validate(CountryCode.SE, '100 05');
      expect(result.isValid, isTrue);
    });

    test('validates Swedish postal code without space', () {
      final result = checker.validate(CountryCode.SE, '10005');
      expect(result.isValid, isTrue);
    });

    test('validates various Swedish postal codes', () {
      final validCodes = ['100 05', '411 01', '211 20', '751 83'];

      for (final code in validCodes) {
        final result = checker.validate(CountryCode.SE, code);
        expect(result.isValid, isTrue, reason: 'Failed to validate: $code');
      }
    });
  });

  group('PostcodeChecker - Special Territories', () {
    test('validates Monaco postal code', () {
      final result = checker.validate(CountryCode.MC, '98000');
      expect(result.isValid, isTrue);
    });

    test('validates Vatican City postal code', () {
      final result = checker.validate(CountryCode.VA, '00120');
      expect(result.isValid, isTrue);
    });

    test('validates Gibraltar postal code', () {
      final result = checker.validate(CountryCode.GI, 'GX11 1AA');
      expect(result.isValid, isTrue);
    });

    test('validates Falkland Islands postal code', () {
      final result = checker.validate(CountryCode.FK, 'FIQQ 1ZZ');
      expect(result.isValid, isTrue);
    });

    test('validates Anguilla postal code', () {
      final result = checker.validate(CountryCode.AI, 'AI-2640');
      expect(result.isValid, isTrue);
    });
  });

  group('PostcodeChecker - hasPostalCodes()', () {
    test('returns true for countries with postal codes', () {
      expect(checker.hasPostalCodes(CountryCode.US), isTrue);
      expect(checker.hasPostalCodes(CountryCode.GB), isTrue);
      expect(checker.hasPostalCodes(CountryCode.DE), isTrue);
    });

    test('returns false for countries without postal code patterns', () {
      // These countries don't have defined postal code systems in CLDR
      expect(checker.hasPostalCodes(CountryCode.AO), isFalse);
      expect(checker.hasPostalCodes(CountryCode.AG), isFalse);
    });
  });

  group('PostcodeChecker - getPostalCodePattern()', () {
    test('returns pattern for supported countries', () {
      final usPattern = checker.getPostalCodePattern(CountryCode.US);
      expect(usPattern, isNotNull);
      expect(usPattern, contains(r'\d{5}'));
    });

    test('returns null for unsupported countries', () {
      final pattern = checker.getPostalCodePattern(CountryCode.AO);
      expect(pattern, isNull);
    });
  });

  group('PostcodeChecker - supportedCountries()', () {
    test('returns list of supported countries', () {
      final countries = checker.supportedCountries();
      expect(countries, isNotEmpty);
      expect(countries.contains(CountryCode.US), isTrue);
      expect(countries.contains(CountryCode.GB), isTrue);
      expect(countries.contains(CountryCode.DE), isTrue);
    });

    test('supported countries list is reasonable size', () {
      final countries = checker.supportedCountries();
      // CLDR has patterns for ~170+ territories
      expect(countries.length, greaterThan(100));
    });
  });

  group('PostcodeChecker - Edge Cases', () {
    test('trims whitespace from postal code', () {
      final result = checker.validate(CountryCode.US, '  12345  ');
      expect(result.isValid, isTrue);
    });

    test('handles empty postal code', () {
      final result = checker.validate(CountryCode.US, '');
      expect(result.isValid, isFalse);
    });

    test('handles postal code with only whitespace', () {
      final result = checker.validate(CountryCode.US, '   ');
      expect(result.isValid, isFalse);
    });
  });

  group('PostcodeValidationResult', () {
    test('toString() shows valid result correctly', () {
      final result = PostcodeValidationResult.valid(CountryCode.US, '12345');
      final str = result.toString();
      expect(str, contains('isValid: true'));
      expect(str, contains('US'));
      expect(str, contains('12345'));
    });

    test('toString() shows invalid result correctly', () {
      final result = PostcodeValidationResult.invalid(
        CountryCode.US,
        'INVALID',
        'Test error',
      );
      final str = result.toString();
      expect(str, contains('isValid: false'));
      expect(str, contains('US'));
      expect(str, contains('INVALID'));
      expect(str, contains('Test error'));
    });
  });

  group('CountryCode Extension', () {
    test('returns correct code string', () {
      expect(CountryCode.US.code, equals('US'));
      expect(CountryCode.GB.code, equals('GB'));
      expect(CountryCode.DE.code, equals('DE'));
    });
  });

  group('PostcodeChecker - Additional Countries', () {
    test('validates Portugal postal code', () {
      final result = checker.validate(CountryCode.PT, '1000-001');
      expect(result.isValid, isTrue);
    });

    test('validates Czech Republic postal code', () {
      final result = checker.validate(CountryCode.CZ, '110 00');
      expect(result.isValid, isTrue);
    });

    test('validates Russia postal code', () {
      final result = checker.validate(CountryCode.RU, '101000');
      expect(result.isValid, isTrue);
    });

    test('validates Singapore postal code', () {
      final result = checker.validate(CountryCode.SG, '018956');
      expect(result.isValid, isTrue);
    });

    test('validates Mexico postal code', () {
      final result = checker.validate(CountryCode.MX, '01000');
      expect(result.isValid, isTrue);
    });

    test('validates Argentina postal code', () {
      final result = checker.validate(CountryCode.AR, '1000');
      expect(result.isValid, isTrue);
    });

    test('validates Argentina postal code with letter and suffix', () {
      final result = checker.validate(CountryCode.AR, 'C1425ABC');
      expect(result.isValid, isTrue);
    });

    test('validates South Africa postal code', () {
      final result = checker.validate(CountryCode.ZA, '0001');
      expect(result.isValid, isTrue);
    });

    test('validates Turkey postal code', () {
      final result = checker.validate(CountryCode.TR, '06100');
      expect(result.isValid, isTrue);
    });

    test('validates Israel postal code', () {
      final result = checker.validate(CountryCode.IL, '9100001');
      expect(result.isValid, isTrue);
    });
  });
}
