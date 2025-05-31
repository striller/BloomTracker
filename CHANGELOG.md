# Changelog

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

