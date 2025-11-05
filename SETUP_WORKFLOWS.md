# GitHub Actions Workflow Setup

The GitHub Actions workflow files couldn't be pushed automatically due to GitHub App permissions. You need to add them manually.

## Workflow Files to Add

Two workflow files are located in `.github/workflows/`:

1. **ci.yml** - Continuous Integration
2. **publish.yml** - Automated Publishing

## Manual Setup Steps

### Option 1: Via GitHub Web Interface

1. **Go to your repository** on GitHub
   - https://github.com/SamuelMTDavies/postcode

2. **Create the workflows directory**
   - Click "Add file" → "Create new file"
   - Type: `.github/workflows/ci.yml`
   - This creates the directory structure

3. **Add ci.yml workflow**
   - Copy the content from `.github/workflows/ci.yml` (shown below)
   - Paste into the file
   - Click "Commit new file"

4. **Add publish.yml workflow**
   - Click "Add file" → "Create new file"
   - Name: `.github/workflows/publish.yml`
   - Copy the content from `.github/workflows/publish.yml` (shown below)
   - Paste into the file
   - Click "Commit new file"

### Option 2: Via Git Command Line

If you have write access to the repository:

```bash
# Clone the repository (if not already cloned)
git clone https://github.com/SamuelMTDavies/postcode.git
cd postcode

# Create workflows directory
mkdir -p .github/workflows

# Copy the workflow files
# (Copy the content below into these files)

# Commit and push
git add .github/workflows/
git commit -m "ci: add GitHub Actions workflows for CI/CD"
git push origin main
```

## Workflow File Contents

### `.github/workflows/ci.yml`

```yaml
name: CI

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main, develop ]

jobs:
  test:
    name: Test on Dart ${{ matrix.sdk }}
    runs-on: ubuntu-latest

    strategy:
      matrix:
        sdk: [stable, beta, dev]
      fail-fast: false

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Setup Dart SDK
        uses: dart-lang/setup-dart@v1
        with:
          sdk: ${{ matrix.sdk }}

      - name: Print Dart version
        run: dart --version

      - name: Install dependencies
        run: dart pub get

      - name: Verify formatting
        run: dart format --output=none --set-exit-if-changed .
        if: matrix.sdk == 'stable'

      - name: Analyze code
        run: dart analyze --fatal-infos

      - name: Run tests
        run: dart test

      - name: Check pub publish
        run: dart pub publish --dry-run
        if: matrix.sdk == 'stable'

  coverage:
    name: Code Coverage
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Setup Dart SDK
        uses: dart-lang/setup-dart@v1
        with:
          sdk: stable

      - name: Install dependencies
        run: dart pub get

      - name: Collect coverage
        run: dart test --coverage=coverage

      - name: Convert coverage to LCOV
        run: |
          dart pub global activate coverage
          dart pub global run coverage:format_coverage --lcov --in=coverage --out=coverage/lcov.info --report-on=lib

      - name: Upload coverage to Codecov
        uses: codecov/codecov-action@v4
        with:
          files: coverage/lcov.info
          fail_ci_if_error: false
```

### `.github/workflows/publish.yml`

```yaml
name: Publish to pub.dev

on:
  release:
    types: [published]

jobs:
  publish:
    name: Publish package
    runs-on: ubuntu-latest

    permissions:
      id-token: write # Required for OIDC publishing

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Setup Dart SDK
        uses: dart-lang/setup-dart@v1
        with:
          sdk: stable

      - name: Install dependencies
        run: dart pub get

      - name: Verify formatting
        run: dart format --output=none --set-exit-if-changed .

      - name: Analyze code
        run: dart analyze --fatal-infos

      - name: Run tests
        run: dart test

      - name: Check publish
        run: dart pub publish --dry-run

      - name: Publish to pub.dev
        run: dart pub publish --force
```

## Verification

After adding the workflows:

1. **Check Actions tab**
   - Go to https://github.com/SamuelMTDavies/postcode/actions
   - You should see the workflows listed

2. **Test CI workflow**
   - Make a small change and push to main
   - The CI workflow should run automatically

3. **Test publish workflow**
   - Create a test release (you can delete it later)
   - The publish workflow should trigger

## Setting Up Codecov (Optional)

For code coverage badges:

1. Go to https://codecov.io
2. Sign in with GitHub
3. Add your repository
4. Copy the upload token
5. Add it to GitHub repository secrets:
   - Go to Settings → Secrets and variables → Actions
   - Click "New repository secret"
   - Name: `CODECOV_TOKEN`
   - Value: (paste token)

## Troubleshooting

### Workflows not appearing

- Ensure files are in `.github/workflows/` directory
- Check that file names are exactly `ci.yml` and `publish.yml`
- Verify YAML syntax is correct

### Workflows not running

- Check that branch names match (main, develop)
- Ensure GitHub Actions are enabled in repository settings
- Check workflow run history in Actions tab

### Publish workflow fails

- Ensure you have permissions on pub.dev
- Check that version in pubspec.yaml is updated
- Verify all tests pass locally

## Next Steps

After setting up workflows:

1. ✅ Workflows are active
2. ✅ CI runs on every push/PR
3. ✅ Publishing automated via releases
4. ✅ Code coverage tracked

You're all set for automated publishing!

---

**Need help?** Open an issue: https://github.com/SamuelMTDavies/postcode/issues
