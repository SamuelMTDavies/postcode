/// Types of validation errors that can occur.
enum PostcodeValidationError {
  /// The country does not have a defined postal code system.
  noPostalCodeSystem,

  /// The postal code format is invalid for the specified country.
  invalidFormat,

  /// The postal code is empty or contains only whitespace.
  emptyPostalCode,

  /// The country code is not supported or recognized.
  unsupportedCountry,
}

/// Extension to provide user-friendly error messages.
extension PostcodeValidationErrorExtension on PostcodeValidationError {
  /// Returns a developer-friendly error message.
  String get message {
    switch (this) {
      case PostcodeValidationError.noPostalCodeSystem:
        return 'This country does not use postal codes or no validation pattern is available.';
      case PostcodeValidationError.invalidFormat:
        return 'The postal code does not match the expected format for this country.';
      case PostcodeValidationError.emptyPostalCode:
        return 'Postal code cannot be empty or contain only whitespace.';
      case PostcodeValidationError.unsupportedCountry:
        return 'The specified country code is not supported.';
    }
  }

  /// Returns a short error code for logging or debugging.
  String get code {
    switch (this) {
      case PostcodeValidationError.noPostalCodeSystem:
        return 'NO_POSTAL_CODE_SYSTEM';
      case PostcodeValidationError.invalidFormat:
        return 'INVALID_FORMAT';
      case PostcodeValidationError.emptyPostalCode:
        return 'EMPTY_POSTAL_CODE';
      case PostcodeValidationError.unsupportedCountry:
        return 'UNSUPPORTED_COUNTRY';
    }
  }
}
