# Security Policy

## Supported Versions

We release patches for security vulnerabilities for the following versions:

| Version | Supported          |
| ------- | ------------------ |
| 1.0.x   | :white_check_mark: |
| < 1.0   | :x:                |

## Reporting a Vulnerability

We take the security of postcode_checker seriously. If you believe you have found a security vulnerability, please report it to us as described below.

### Please Do Not:

- Open a public GitHub issue for security vulnerabilities
- Discuss the vulnerability in public forums, social media, or chat channels

### Please Do:

**Report security vulnerabilities privately via:**

1. **GitHub Security Advisories** (Recommended)
   - Go to https://github.com/SamuelMTDavies/postcode/security/advisories
   - Click "New draft security advisory"
   - Provide details about the vulnerability

2. **Direct Email**
   - Email: [your-security-email@example.com]
   - Subject: "[SECURITY] postcode_checker vulnerability report"

### What to Include:

Please include the following information in your report:

- **Type of vulnerability** (e.g., ReDoS, injection, etc.)
- **Full path** of source file(s) related to the vulnerability
- **Location** of the affected source code (tag/branch/commit or direct URL)
- **Step-by-step instructions** to reproduce the issue
- **Proof-of-concept or exploit code** (if possible)
- **Impact** of the vulnerability
- **Suggested fix** (if you have one)

### What to Expect:

- **Acknowledgment**: We will acknowledge receipt of your vulnerability report within 48 hours
- **Communication**: We will keep you informed about our progress
- **Timeline**: We aim to provide a fix within 90 days
- **Credit**: If you wish, we will publicly credit you for the discovery

## Security Considerations

### Regex Patterns

The postal code validation patterns in this package are based on the Unicode CLDR data and other official sources. However:

- **ReDoS (Regular Expression Denial of Service)**: Some complex patterns may be vulnerable to ReDoS attacks
- **Input validation**: Always validate and sanitize user input before passing to this package
- **Rate limiting**: Consider implementing rate limiting for user-facing validation endpoints

### Best Practices

When using postcode_checker:

1. **Validate input length**: Check postal code length before validation
   ```dart
   if (postalCode.length > 20) {
     // Reject abnormally long input
   }
   ```

2. **Implement timeouts**: Set reasonable timeouts for validation operations
   ```dart
   Future<bool> validateWithTimeout(String code) async {
     return await Future.value(
       PostcodeChecker.validate(CountryCode.US, code).isValid
     ).timeout(Duration(milliseconds: 100));
   }
   ```

3. **Rate limiting**: Limit validation requests per user/IP
4. **Logging**: Log validation attempts for security monitoring
5. **Error handling**: Handle validation errors gracefully

### Known Limitations

- This package performs format validation only, not existence validation
- Complex regex patterns may have performance implications
- Some patterns allow broad character ranges for compatibility

## Security Updates

Security updates will be released as:

- **Patch versions** for minor security fixes (1.0.x)
- **Minor versions** for moderate security fixes (1.x.0)
- **Major versions** for breaking security fixes (x.0.0)

Security updates will be:
- Published to pub.dev immediately
- Announced in CHANGELOG.md
- Documented in GitHub Security Advisories
- Tagged with `[SECURITY]` in release notes

## Disclosure Policy

- **Private disclosure**: 90 days before public disclosure
- **Coordinated disclosure**: We will work with you on timing
- **CVE assignment**: We will request CVEs for applicable vulnerabilities
- **Public announcement**: After fix is released and deployed

## Hall of Fame

We appreciate security researchers who help keep postcode_checker secure. Contributors will be listed here (with permission):

<!-- Security researchers who have responsibly disclosed vulnerabilities -->

*No security vulnerabilities have been reported yet.*

## Additional Resources

- [OWASP Regular Expression Security Cheatsheet](https://cheatsheetseries.owasp.org/cheatsheets/Regular_Expression_Security_Cheat_Sheet.html)
- [Dart Security Best Practices](https://dart.dev/guides/language/language-tour#security)

---

**Last Updated**: 2025-11-05
