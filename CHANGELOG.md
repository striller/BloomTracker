# Changelog

## v0.4.3 (2026-05-30)

### Bug Fixes
- Fixed version inconsistency in `setup.py` (was still `0.4.1`)
- Updated `python_requires` in `setup.py` from `>=3.6` to `>=3.7` to match `pyproject.toml`

### Infrastructure
- Switched PyPI publishing to **trusted publishing** (OIDC)
  - Removed `PYPI_USERNAME` / `PYPI_PASSWORD` secrets requirement
  - Updated workflow to use `pypa/gh-action-pypi-publish`

## v0.4.2 (2026-03-28)

### Bug Fixes
- Fix dependabot config: set package-ecosystem to pip

## v0.4.1 (2025-05-31)

### Bug Fixes
- Fixed version inconsistencies across package files
- Updated dependencies for improved compatibility
- Added GitHub Actions workflow for automated PyPI publishing

## v0.4.0 (2025-05-31)

### Breaking Changes
- **Package renamed from `dwdpollen` to `bloomtracker`**
  - All import statements must be updated from `from dwdpollen import ...` to `from bloomtracker import ...`
  - CLI command renamed from `dwdpollen` to `bloomtracker`
  - Package name on PyPI changed to `bloomtracker`
  - Internal module references updated throughout codebase

### Improvements
- Fixed RuntimeWarning for async coroutines in tests
- Improved exception handling for better error messages
- Enhanced date handling in CLI to prevent serialization errors
- Added missing `aiohttp` import in test files
- Updated all documentation and examples to use new package name

## v0.3.0 (2025-05-31)

### Features
- Added caching mechanism to reduce API calls
- Added async support with AsyncDwdPollenApi
- Added command-line interface
- Added data visualization capabilities
- Improved error handling and resilience
- Added region and allergen helpers
- Added color coding for pollen levels

### Improvements
- Better type hints throughout the codebase
- Improved documentation
- Rate limiting and timeout handling
- Automatic updates feature

