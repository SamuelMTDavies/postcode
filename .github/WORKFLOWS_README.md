# GitHub Actions Workflows

## ⚠️ Action Required

The GitHub Actions workflow files are ready in `.github/workflows/` but **could not be automatically pushed** due to GitHub App permission restrictions.

## What You Need to Do

You must **manually add these workflow files** to your repository:

### Quick Option: Copy/Paste via GitHub Web

1. Go to https://github.com/SamuelMTDavies/postcode
2. Navigate to `.github/workflows/`
3. Create two new files by copying content from the local files:
   - `ci.yml` (CI/CD workflow)
   - `publish.yml` (Auto-publish on releases)

### Detailed Instructions

See **[SETUP_WORKFLOWS.md](../../SETUP_WORKFLOWS.md)** in the root directory for:
- Complete workflow file contents
- Step-by-step setup guide
- Verification steps
- Troubleshooting help

## Workflow Files Location

The workflow files are available locally at:
- `.github/workflows/ci.yml`
- `.github/workflows/publish.yml`

They are **fully functional and ready to use** - they just need to be added to the GitHub repository manually.

## Why Manual Setup?

GitHub restricts automated creation of workflow files for security reasons. This is a one-time manual step.

## After Setup

Once workflows are added:
- ✅ CI runs on every push/PR
- ✅ Auto-publishing on releases
- ✅ Code coverage tracking
- ✅ Multi-version testing

---

**Need help?** See SETUP_WORKFLOWS.md or open an issue.
