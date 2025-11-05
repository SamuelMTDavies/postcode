import 'country_code.dart';

/// Result of a postal code validation.
class PostcodeValidationResult {
  /// Whether the postal code is valid.
  final bool isValid;

  /// The country code used for validation.
  final CountryCode countryCode;

  /// The postal code that was validated.
  final String postalCode;

  /// Optional error message if validation failed.
  final String? errorMessage;

  /// Creates a new validation result.
  const PostcodeValidationResult({
    required this.isValid,
    required this.countryCode,
    required this.postalCode,
    this.errorMessage,
  });

  /// Creates a successful validation result.
  factory PostcodeValidationResult.valid(
    CountryCode countryCode,
    String postalCode,
  ) {
    return PostcodeValidationResult(
      isValid: true,
      countryCode: countryCode,
      postalCode: postalCode,
    );
  }

  /// Creates a failed validation result.
  factory PostcodeValidationResult.invalid(
    CountryCode countryCode,
    String postalCode,
    String errorMessage,
  ) {
    return PostcodeValidationResult(
      isValid: false,
      countryCode: countryCode,
      postalCode: postalCode,
      errorMessage: errorMessage,
    );
  }

  @override
  String toString() {
    if (isValid) {
      return 'PostcodeValidationResult(isValid: true, countryCode: ${countryCode.code}, postalCode: $postalCode)';
    }
    return 'PostcodeValidationResult(isValid: false, countryCode: ${countryCode.code}, postalCode: $postalCode, error: $errorMessage)';
  }
}

/// A comprehensive postal code validator for countries worldwide.
///
/// This class provides validation for postal codes using ISO 3166-1 alpha-2
/// country codes and regex patterns from the Unicode CLDR (Common Locale Data
/// Repository) version 26.0.1.
///
/// Example:
/// ```dart
/// final checker = PostcodeChecker();
/// final result = checker.validate(CountryCode.US, '12345');
/// print(result.isValid); // true
/// ```
class PostcodeChecker {
  /// Creates a new postal code checker.
  const PostcodeChecker();

  /// Validates a postal code for the specified country.
  ///
  /// Returns a [PostcodeValidationResult] containing the validation status
  /// and any error messages.
  ///
  /// Example:
  /// ```dart
  /// final checker = PostcodeChecker();
  /// final result = checker.validate(CountryCode.GB, 'SW1A 1AA');
  /// if (result.isValid) {
  ///   print('Valid UK postcode!');
  /// }
  /// ```
  PostcodeValidationResult validate(
    CountryCode countryCode,
    String postalCode,
  ) {
    // Trim whitespace for consistency
    final trimmedCode = postalCode.trim();

    // Get the regex pattern for this country
    final pattern = getPostalCodePattern(countryCode);

    if (pattern == null) {
      return PostcodeValidationResult.invalid(
        countryCode,
        postalCode,
        'No postal code validation pattern available for ${countryCode.code}',
      );
    }

    // Validate against the pattern
    final regex = RegExp(pattern);
    if (regex.hasMatch(trimmedCode)) {
      return PostcodeValidationResult.valid(countryCode, postalCode);
    }

    return PostcodeValidationResult.invalid(
      countryCode,
      postalCode,
      'Postal code does not match the expected format for ${countryCode.code}',
    );
  }

  /// Gets the regex pattern for validating postal codes in the specified country.
  ///
  /// Returns `null` if no pattern is available for the country.
  ///
  /// The patterns are based on the Unicode CLDR (Common Locale Data Repository)
  /// version 26.0.1, which was the last version to include postal code data.
  ///
  /// Example:
  /// ```dart
  /// final checker = PostcodeChecker();
  /// final pattern = checker.getPostalCodePattern(CountryCode.US);
  /// print(pattern); // \d{5}([ \-]\d{4})?
  /// ```
  String? getPostalCodePattern(CountryCode countryCode) {
    switch (countryCode) {
      // United Kingdom and Crown Dependencies
      case CountryCode.GB:
        return r'GIR[ ]?0AA|((AB|AL|B|BA|BB|BD|BH|BL|BN|BR|BS|BT|CA|CB|CF|CH|CM|CO|CR|CT|CV|CW|DA|DD|DE|DG|DH|DL|DN|DT|DY|E|EC|EH|EN|EX|FK|FY|G|GL|GY|GU|HA|HD|HG|HP|HR|HS|HU|HX|IG|IM|IP|IV|JE|KA|KT|KW|KY|L|LA|LD|LE|LL|LN|LS|LU|M|ME|MK|ML|N|NE|NG|NN|NP|NR|NW|OL|OX|PA|PE|PH|PL|PO|PR|RG|RH|RM|S|SA|SE|SG|SK|SL|SM|SN|SO|SP|SR|SS|ST|SW|SY|TA|TD|TF|TN|TQ|TR|TS|TW|UB|W|WA|WC|WD|WF|WN|WR|WS|WV|YO|ZE)(\d[\dA-Z]?[ ]?\d[ABD-HJLN-UW-Z]{2}))|BFPO[ ]?\d{1,4}';

      case CountryCode.JE:
        return r'JE\d[\dA-Z]?[ ]?\d[ABD-HJLN-UW-Z]{2}';

      case CountryCode.GG:
        return r'GY\d[\dA-Z]?[ ]?\d[ABD-HJLN-UW-Z]{2}';

      case CountryCode.IM:
        return r'IM\d[\dA-Z]?[ ]?\d[ABD-HJLN-UW-Z]{2}';

      // North America
      case CountryCode.US:
        return r'\d{5}([ \-]\d{4})?';

      case CountryCode.CA:
        return r'[ABCEGHJKLMNPRSTVXY]\d[ABCEGHJ-NPRSTV-Z][ ]?\d[ABCEGHJ-NPRSTV-Z]\d';

      case CountryCode.PR:
        return r'00[679]\d{2}([ \-]\d{4})?';

      case CountryCode.VI:
        return r'008(([0-4]\d)|(5[01]))([ \-]\d{4})?';

      // Central America and Caribbean
      case CountryCode.MX:
        return r'\d{5}';

      case CountryCode.GT:
        return r'\d{5}';

      case CountryCode.HN:
        return r'\d{5}';

      case CountryCode.NI:
        return r'\d{5}';

      case CountryCode.CR:
        return r'\d{4,5}|\d{3}-\d{4}';

      case CountryCode.DO:
        return r'\d{5}';

      case CountryCode.HT:
        return r'\d{4}';

      case CountryCode.BM:
        return r'[A-Z]{2}[ ]?[A-Z0-9]{2}';

      // South America
      case CountryCode.BR:
        return r'\d{5}[\-]?\d{3}';

      case CountryCode.AR:
        return r'([A-HJ-NP-Z])?\d{4}([A-Z]{3})?';

      case CountryCode.CL:
        return r'\d{7}';

      case CountryCode.CO:
        return r'\d{6}';

      case CountryCode.EC:
        return r'\d{6}';

      case CountryCode.PE:
        return r'\d{5}';

      case CountryCode.VE:
        return r'\d{4}';

      case CountryCode.UY:
        return r'\d{5}';

      case CountryCode.PY:
        return r'\d{4}';

      case CountryCode.BO:
        return r'\d{4}';

      case CountryCode.GF:
        return r'9[78]3\d{2}';

      // Western Europe
      case CountryCode.DE:
        return r'\d{5}';

      case CountryCode.FR:
        return r'\d{2}[ ]?\d{3}';

      case CountryCode.IT:
        return r'\d{5}';

      case CountryCode.NL:
        return r'\d{4}[ ]?[A-Z]{2}';

      case CountryCode.BE:
        return r'\d{4}';

      case CountryCode.AT:
        return r'\d{4}';

      case CountryCode.CH:
        return r'\d{4}';

      case CountryCode.ES:
        return r'\d{5}';

      case CountryCode.PT:
        return r'\d{4}([\-]\d{3})?';

      case CountryCode.LU:
        return r'\d{4}';

      case CountryCode.MC:
        return r'980\d{2}';

      case CountryCode.LI:
        return r'(948[5-9])|(949[0-7])';

      case CountryCode.AD:
        return r'AD\d{3}';

      case CountryCode.SM:
        return r'4789\d';

      case CountryCode.VA:
        return r'00120';

      // Northern Europe
      case CountryCode.SE:
        return r'\d{3}[ ]?\d{2}';

      case CountryCode.NO:
        return r'\d{4}';

      case CountryCode.DK:
        return r'\d{4}';

      case CountryCode.FI:
        return r'\d{5}';

      case CountryCode.IS:
        return r'\d{3}';

      case CountryCode.FO:
        return r'\d{3}';

      case CountryCode.GL:
        return r'39\d{2}';

      case CountryCode.AX:
        return r'22\d{3}';

      case CountryCode.SJ:
        return r'\d{4}';

      // Eastern Europe
      case CountryCode.PL:
        return r'\d{2}-\d{3}';

      case CountryCode.CZ:
        return r'\d{3}[ ]?\d{2}';

      case CountryCode.SK:
        return r'\d{3}[ ]?\d{2}';

      case CountryCode.HU:
        return r'\d{4}';

      case CountryCode.RO:
        return r'\d{6}';

      case CountryCode.BG:
        return r'\d{4}';

      case CountryCode.UA:
        return r'\d{5}';

      case CountryCode.BY:
        return r'\d{6}';

      case CountryCode.MD:
        return r'\d{4}';

      case CountryCode.LT:
        return r'\d{5}';

      case CountryCode.LV:
        return r'\d{4}';

      case CountryCode.EE:
        return r'\d{5}';

      case CountryCode.RU:
        return r'\d{6}';

      // Southern Europe
      case CountryCode.GR:
        return r'\d{3}[ ]?\d{2}';

      case CountryCode.HR:
        return r'\d{5}';

      case CountryCode.SI:
        return r'\d{4}';

      case CountryCode.BA:
        return r'\d{5}';

      case CountryCode.RS:
        return r'\d{5,6}';

      case CountryCode.ME:
        return r'\d{5}';

      case CountryCode.MK:
        return r'\d{4}';

      case CountryCode.AL:
        return r'\d{4}';

      case CountryCode.XK:
        return r'\d{5}';

      case CountryCode.CY:
        return r'\d{4}';

      case CountryCode.MT:
        return r'[A-Z]{3}[ ]?\d{2,4}';

      // Asia-Pacific
      case CountryCode.JP:
        return r'\d{3}-\d{4}';

      case CountryCode.CN:
        return r'\d{6}';

      case CountryCode.KR:
        return r'\d{3}[\-]?\d{3}';

      case CountryCode.TW:
        return r'\d{3}(\d{2})?';

      case CountryCode.AU:
        return r'\d{4}';

      case CountryCode.NZ:
        return r'\d{4}';

      case CountryCode.SG:
        return r'\d{6}';

      case CountryCode.IN:
        return r'\d{6}';

      case CountryCode.PK:
        return r'\d{5}';

      case CountryCode.BD:
        return r'\d{4}';

      case CountryCode.LK:
        return r'\d{5}';

      case CountryCode.NP:
        return r'\d{5}';

      case CountryCode.BT:
        return r'\d{5}';

      case CountryCode.MV:
        return r'\d{5}';

      case CountryCode.ID:
        return r'\d{5}';

      case CountryCode.MY:
        return r'\d{5}';

      case CountryCode.TH:
        return r'\d{5}';

      case CountryCode.VN:
        return r'\d{6}';

      case CountryCode.PH:
        return r'\d{4}';

      case CountryCode.LA:
        return r'\d{5}';

      case CountryCode.KH:
        return r'\d{5}';

      case CountryCode.MM:
        return r'\d{5}';

      case CountryCode.BN:
        return r'[A-Z]{2}[ ]?\d{4}';

      case CountryCode.MN:
        return r'\d{6}';

      // Central Asia
      case CountryCode.KZ:
        return r'\d{6}';

      case CountryCode.UZ:
        return r'\d{6}';

      case CountryCode.TJ:
        return r'\d{6}';

      case CountryCode.KG:
        return r'\d{6}';

      case CountryCode.TM:
        return r'\d{6}';

      case CountryCode.AF:
        return r'\d{4}';

      // Middle East
      case CountryCode.TR:
        return r'\d{5}';

      case CountryCode.IL:
        return r'\d{5}(\d{2})?';

      case CountryCode.SA:
        return r'\d{5}';

      case CountryCode.AE:
        return r'\d{5}';

      case CountryCode.IQ:
        return r'\d{5}';

      case CountryCode.IR:
        return r'\d{5}[\-]?\d{5}';

      case CountryCode.JO:
        return r'\d{5}';

      case CountryCode.LB:
        return r'(\d{4}([ ]?\d{4})?)?';

      case CountryCode.SY:
        return r'\d{5}';

      case CountryCode.PS:
        return r'\d{5}';

      case CountryCode.OM:
        return r'(PC )?\d{3}';

      case CountryCode.KW:
        return r'\d{5}';

      case CountryCode.BH:
        return r'((1[0-2]|[2-9])\d{2})?';

      case CountryCode.QA:
        return r'\d{5}';

      case CountryCode.YE:
        return r'\d{5}';

      case CountryCode.AM:
        return r'(37)?\d{4}';

      case CountryCode.AZ:
        return r'\d{4}';

      case CountryCode.GE:
        return r'\d{4}';

      // Africa
      case CountryCode.ZA:
        return r'\d{4}';

      case CountryCode.EG:
        return r'\d{5}';

      case CountryCode.MA:
        return r'\d{5}';

      case CountryCode.DZ:
        return r'\d{5}';

      case CountryCode.TN:
        return r'\d{4}';

      case CountryCode.LY:
        return r'\d{5}';

      case CountryCode.ET:
        return r'\d{4}';

      case CountryCode.KE:
        return r'\d{5}';

      case CountryCode.NG:
        return r'\d{6}';

      case CountryCode.GH:
        return r'\d{5}';

      case CountryCode.SN:
        return r'\d{5}';

      case CountryCode.TZ:
        return r'\d{4,5}';

      case CountryCode.UG:
        return r'\d{5}';

      case CountryCode.ZM:
        return r'\d{5}';

      case CountryCode.ZW:
        return r'\d{5}';

      case CountryCode.MZ:
        return r'\d{4}';

      case CountryCode.MW:
        return r'\d{6}';

      case CountryCode.LS:
        return r'\d{3}';

      case CountryCode.SZ:
        return r'[HLMS]\d{3}';

      case CountryCode.BW:
        return r'\d{5}';

      case CountryCode.NA:
        return r'\d{5}';

      case CountryCode.RE:
        return r'9[78]4\d{2}';

      case CountryCode.MU:
        return r'(\d{3}[A-Z]{2}\d{3})?';

      case CountryCode.SC:
        return r'\d{5}';

      case CountryCode.MG:
        return r'\d{3}';

      case CountryCode.SO:
        return r'\d{5}';

      case CountryCode.DJ:
        return r'\d{5}';

      case CountryCode.SD:
        return r'\d{5}';

      case CountryCode.ER:
        return r'\d{5}';

      // Pacific Islands
      case CountryCode.GU:
        return r'969[123]\d([ \-]\d{4})?';

      case CountryCode.AS:
        return r'96799';

      case CountryCode.MP:
        return r'9695[012]([ \-]\d{4})?';

      case CountryCode.PW:
        return r'96940';

      case CountryCode.FM:
        return r'(9694[1-4])([ \-]\d{4})?';

      case CountryCode.MH:
        return r'969[67]\d([ \-]\d{4})?';

      case CountryCode.NC:
        return r'988\d{2}';

      case CountryCode.PF:
        return r'987\d{2}';

      case CountryCode.WF:
        return r'986\d{2}';

      // Overseas Territories
      case CountryCode.GP:
        return r'9[78][01]\d{2}';

      case CountryCode.MQ:
        return r'9[78]2\d{2}';

      case CountryCode.PM:
        return r'9[78]5\d{2}';

      case CountryCode.YT:
        return r'976\d{2}';

      case CountryCode.BL:
        return r'9[78]1\d{2}';

      case CountryCode.MF:
        return r'9[78]1\d{2}';

      case CountryCode.CC:
        return r'6799';

      case CountryCode.CX:
        return r'6798';

      case CountryCode.NF:
        return r'2899';

      case CountryCode.IO:
        return r'BBND 1ZZ';

      case CountryCode.FK:
        return r'FIQQ 1ZZ';

      case CountryCode.GS:
        return r'SIQQ 1ZZ';

      case CountryCode.SH:
        return r'(ASCN|STHL) 1ZZ';

      case CountryCode.PN:
        return r'PCRN 1ZZ';

      case CountryCode.TC:
        return r'TKCA 1ZZ';

      case CountryCode.AI:
        return r'AI-2640';

      case CountryCode.VG:
        return r'VG\d{4}';

      case CountryCode.KY:
        return r'KY\d[\-]\d{4}';

      case CountryCode.MS:
        return r'MSR 1[1-3]\d{2}';

      case CountryCode.GI:
        return r'GX11 1AA';

      // Countries without postal codes (return null)
      default:
        return null;
    }
  }

  /// Checks if a country uses postal codes.
  ///
  /// Returns `true` if the country has a postal code system, `false` otherwise.
  ///
  /// Example:
  /// ```dart
  /// final checker = PostcodeChecker();
  /// print(checker.hasPostalCodes(CountryCode.US)); // true
  /// print(checker.hasPostalCodes(CountryCode.AO)); // false
  /// ```
  bool hasPostalCodes(CountryCode countryCode) {
    return getPostalCodePattern(countryCode) != null;
  }

  /// Returns a list of all countries that have postal code validation patterns.
  ///
  /// Example:
  /// ```dart
  /// final checker = PostcodeChecker();
  /// final countries = checker.supportedCountries();
  /// print('Supported countries: ${countries.length}');
  /// ```
  List<CountryCode> supportedCountries() {
    return CountryCode.values.where(hasPostalCodes).toList();
  }
}
