# Publishing Guide

This guide explains how to publish postcode_checker to pub.dev and maximize pub points.

## Prerequisites

1. **pub.dev Account**: Create an account at [pub.dev](https://pub.dev)
2. **Email Verification**: Verify your email address
3. **Dart SDK**: Ensure you have Dart SDK 3.0.0 or higher installed

## Pre-Publishing Checklist

Before publishing, ensure:

- [ ] All tests pass (`dart test`)
- [ ] Code is formatted (`dart format .`)
- [ ] No analysis issues (`dart analyze --fatal-infos`)
- [ ] Version number is updated in `pubspec.yaml` (follow [SemVer](https://semver.org/))
- [ ] `CHANGELOG.md` is updated with changes
- [ ] `README.md` includes usage examples
- [ ] All files are committed to git

## Pub Points Optimization

The package is optimized for maximum pub points (160/160):

### ✅ Follow Dart file conventions (20 points)
- Uses standard Dart file structure
- Follows naming conventions
- Proper library exports

### ✅ Provide documentation (30 points)
- Comprehensive README.md with examples
- API documentation with dartdoc comments
- CHANGELOG.md with version history
- Example code in `/example`

### ✅ Platform support (20 points)
- Supports all platforms (Android, iOS, Web, Windows, macOS, Linux)
- Pure Dart package with no platform-specific code

### ✅ Pass static analysis (30 points)
- Uses `package:lints` with strict rules
- No static analysis issues
- Follows Dart best practices

### ✅ Support latest stable SDK (20 points)
- Supports Dart SDK ^3.0.0
- Uses null safety

### ✅ Tag published versions (20 points)
- Git tags match published versions
- Automated via GitHub releases

### ✅ Support sound null safety (20 points)
- Fully null-safe code
- No unsafe null operations

## Publishing Steps

### 1. Dry Run

First, test the publish process:

```bash
dart pub publish --dry-run
```

This will:
- Validate the package structure
- Check for any errors
- Show what will be published
- **Not actually publish anything**

Review the output carefully. Fix any warnings or errors.

### 2. Publish to pub.dev

Once the dry run succeeds:

```bash
dart pub publish
```

You'll be asked to:
1. Confirm the package contents
2. Authenticate with your Google account
3. Grant pub.dev permission to publish

### 3. Create Git Tag

After publishing, tag the release:

```bash
git tag v1.0.0
git push origin v1.0.0
```

### 4. Create GitHub Release

1. Go to https://github.com/SamuelMTDavies/postcode/releases
2. Click "Create a new release"
3. Choose the tag you just created (v1.0.0)
4. Set release title: "v1.0.0 - Initial Release"
5. Copy relevant section from CHANGELOG.md
6. Publish release

This will:
- Trigger the GitHub Actions publish workflow
- Automatically publish to pub.dev
- Create release notes

## Automated Publishing

### Using GitHub Actions

The package includes automated publishing via GitHub Actions:

1. **Create a new release** on GitHub with a version tag (e.g., `v1.0.1`)
2. The workflow automatically:
   - Runs tests
   - Checks formatting
   - Runs static analysis
   - Publishes to pub.dev using OIDC

**Note**: For automated publishing to work, you need to:
1. Enable GitHub Actions in your repository
2. Set up pub.dev publishing permissions (done automatically via OIDC)

### Manual Publishing

If you prefer manual publishing:

```bash
# Ensure you're on the main branch
git checkout main
git pull

# Update version in pubspec.yaml
# Update CHANGELOG.md

# Run checks
dart format .
dart analyze --fatal-infos
dart test

# Publish
dart pub publish

# Tag and push
git tag v1.0.x
git push origin v1.0.x
```

## Version Numbering

Follow [Semantic Versioning](https://semver.org/):

- **MAJOR** version (1.0.0 → 2.0.0): Breaking changes
- **MINOR** version (1.0.0 → 1.1.0): New features, backward compatible
- **PATCH** version (1.0.0 → 1.0.1): Bug fixes, backward compatible

### Examples:

```
1.0.0 → 1.0.1  Adding missing country pattern
1.0.0 → 1.1.0  Adding format validation feature
1.0.0 → 2.0.0  Changing API to use async methods
```

## After Publishing

1. **Verify on pub.dev**: Check https://pub.dev/packages/postcode_checker
2. **Monitor pub points**: Aim for 160/160 points
3. **Check package score**: Should be 100+ within 24 hours
4. **Update README badges**: Add pub.dev version badge
5. **Announce**: Share on social media, forums, etc.

## Troubleshooting

### "Email not verified"
- Verify your email on pub.dev before publishing

### "Version already exists"
- Update version number in pubspec.yaml
- Each publish must have a unique version

### "Analysis errors"
- Run `dart analyze --fatal-infos`
- Fix all errors and warnings

### "Failed to publish"
- Ensure you're authenticated: `dart pub logout` then `dart pub publish`
- Check network connection
- Verify pub.dev is accessible

## Continuous Integration

The package includes CI workflows that run on every push:

- **Testing**: Runs on Dart stable, beta, and dev channels
- **Analysis**: Checks code formatting and static analysis
- **Coverage**: Generates code coverage reports
- **Publish**: Automatically publishes on new releases

View workflow status at: https://github.com/SamuelMTDavies/postcode/actions

## Support

For publishing issues:
- Check [pub.dev documentation](https://dart.dev/tools/pub/publishing)
- Open an issue in the repository
- Contact pub.dev support

---

**Last Updated**: 2025-11-05
