# BloomTracker - DWD Pollen API Client

[![PyPI version](https://badge.fury.io/py/bloomtracker.svg)](https://badge.fury.io/py/bloomtracker)

A Python client for the DWD (Deutscher Wetterdienst) pollen forecast API, providing current and future pollen load information across Germany. This package offers both synchronous and asynchronous interfaces, data caching, CLI tools, and visualization capabilities.

The DWD publishes this data as a [JSON endpoint](https://opendata.dwd.de/climate_environment/health/alerts/s31fg.json) and documents it in this [German PDF](https://opendata.dwd.de/climate_environment/health/alerts/Beschreibung_pollen_s31fg.pdf).

## Features

- **Synchronous & Asynchronous APIs**: Choose between traditional blocking calls or async operations
- **Data Caching**: Reduce API calls with local caching
- **Command-Line Interface**: Easy access to pollen data from your terminal
- **Data Visualization**: Generate charts and visualizations of pollen forecasts
- **Comprehensive Region Coverage**: All German regions supported by the DWD API
- **Rich Data Formatting**: Human-readable descriptions and numerical values
- **Error Handling**: Robust retry mechanisms and error reporting

## Installation

```bash
pip install bloomtracker
```

Requires Python 3.12 or higher.

## Command-Line Usage

After installation, you can use the `bloomtracker` command to get pollen data:

```bash
# Get pollen data for Berlin/Brandenburg
bloomtracker -r 50 -p -1

# List all available regions
bloomtracker --list

# Export data as JSON
bloomtracker -r 50 -p -1 --format json

# Save to file
bloomtracker -r 50 -p -1 --format json -o pollen_data.json

# Force update (bypass cache)
bloomtracker -r 50 -p -1 --no-cache
```

## API Usage

### Basic Usage

```python
from bloomtracker import DwdPollenApi

# Initialize the API client
api = DwdPollenApi()

# Get data for Berlin/Brandenburg (region_id=50, partregion_id=-1)
data = api.get_pollen(50, -1)

# Display region name
print(f"Region: {data['region_name']}")

# Access specific allergen data
birke_data = data['pollen'].get('Birke', {})
for date, info in birke_data.items():
    print(f"Date: {date}, Load: {info['human']} ({info['value']})")
```

### Asynchronous Usage

```python
import asyncio
from bloomtracker import AsyncDwdPollenApi

async def get_pollen_data():
    # Initialize the async API client
    api = AsyncDwdPollenApi()
    
    # Update data from the API
    await api.update()
    
    # Get data for Berlin/Brandenburg
    data = await api.get_pollen(50, -1)
    print(f"Region: {data['region_name']}")
    
    # Get available allergens
    allergens = await api.get_allergen_names()
    print(f"Available allergens: {allergens}")

# Run the async function
asyncio.run(get_pollen_data())
```

### Data Visualization

```python
from bloomtracker import DwdPollenApi
from bloomtracker.visualization import generate_chart

# Initialize the API
api = DwdPollenApi()
data = api.get_pollen(50, -1)

# Generate a heatmap of all allergens and dates
generate_chart(data, output_path="pollen_heatmap.png")

# Show forecast for a specific allergen
generate_chart(data, allergen_name="Birke", output_path="birke_forecast.png")

# Show all allergens for a specific date
today = datetime.datetime.now().strftime('%Y-%m-%d')
generate_chart(data, date_str=today, output_path="today_allergens.png")
```

## Region IDs and Partregion IDs
The API uses the `region_id` and `partregion_id` to identify the different regions in Germany. The following regions are available:

| Region                         | `region_id` | Partregion                                         | `partregion_id` |
| ------------------------------ | ----------- | -------------------------------------------------- | --------------- |
| Schleswig-Holstein und Hamburg | 10          | Inseln und Marschen                                | 11              |
|                                |             | Geest, Schleswig-Holstein und Hamburg              | 12              |
| Mecklenburg-Vorpommern         | 20          |                                                    | -1              |
| Niedersachsen und Bremen       | 30          | Westl. Niedersachsen/Bremen                        | 31              |
|                                |             | Östl. Niedersachsen                                | 32              |
| Nordrhein-Westfalen            | 40          | Rhein.-Westfäl. Tiefland                           | 41              |
|                                |             | Ostwestfalen                                       | 42              |
|                                |             | Mittelgebirge NRW                                  | 43              |
| Brandenburg und Berlin         | 50          |                                                    | -1              |
| Sachsen-Anhalt                 | 60          | Tiefland Sachsen-Anhalt                            | 61              |
|                                |             | Harz                                               | 62              |
| Thüringen                      | 70          | Tiefland Thüringen                                 | 71              |
|                                |             | Mittelgebirge Thüringen                            | 72              |
| Sachsen                        | 80          | Tiefland Sachsen                                   | 81              |
|                                |             | Mittelgebirge Sachsen                              | 82              |
| Hessen                         | 90          | Nordhessen und hess. Mittelgebirge                 | 91              |
|                                |             | Rhein-Main                                         | 92              |
| Rheinland-Pfalz und Saarland   | 100         | Saarland                                           | 103             |
|                                |             | Rhein, Pfalz, Nahe und Mosel                       | 101             |
|                                |             | Mittelgebirgsbereich Rheinland-Pfalz               | 102             |
| Baden-Württemberg              | 110         | Oberrhein und unteres Neckartal                    | 111             |
|                                |             | Hohenlohe/mittlerer Neckar/Oberschwaben            | 112             |
|                                |             | Mittelgebirge Baden-Württemberg                    | 113             |
| Bayern                         | 120         | Allgäu/Oberbayern/Bay. Wald                        | 121             |
|                                |             | Donauniederungen                                   | 122             |
|                                |             | Bayern n. der Donau, o. Bayr. Wald, o. Mainfranken | 123             |
|                                |             | Mainfranken                                        | 124             |

## Usage

The API will return the data on a best effort basis.

```
import bloomtracker
api = bloomtracker.DwdPollenApi()
api.get_pollen(50, -1)
```

```
{'region_id': 50,
 'region_name': 'Brandenburg und Berlin ',
 'partregion_id': -1,
 'partregion_name': '',
 'last_update': datetime.datetime(2019, 4, 18, 11, 0),
 'next_update': datetime.datetime(2019, 4, 19, 11, 0),
 'pollen': {'Graeser': {'2019-04-19': {'value': 0.0,
    'raw': '0',
    'human': 'keine Belastung'},
   '2019-04-20': {'value': 0.0, 'raw': '0', 'human': 'keine Belastung'}},
  'Roggen': {'2019-04-19': {'value': 0.0,
    'raw': '0',
    'human': 'keine Belastung'},
   '2019-04-20': {'value': 0.0, 'raw': '0', 'human': 'keine Belastung'}},
  'Hasel': {'2019-04-19': {'value': 0.0,
    'raw': '0',
    'human': 'keine Belastung'},
   '2019-04-20': {'value': 0.0, 'raw': '0', 'human': 'keine Belastung'}},
  'Beifuss': {'2019-04-19': {'value': 0.0,
    'raw': '0',
    'human': 'keine Belastung'},
   '2019-04-20': {'value': 0.0, 'raw': '0', 'human': 'keine Belastung'}},
  'Esche': {'2019-04-19': {'value': 2.0,
    'raw': '2',
    'human': 'mittlere Belastung'},
   '2019-04-20': {'value': 2.0, 'raw': '2', 'human': 'mittlere Belastung'}},
  'Birke': {'2019-04-19': {'value': 3.0,
    'raw': '3',
    'human': 'hohe Belastung'},
   '2019-04-20': {'value': 3.0, 'raw': '3', 'human': 'hohe Belastung'}},
  'Erle': {'2019-04-19': {'value': 0.0,
    'raw': '0',
    'human': 'keine Belastung'},
   '2019-04-20': {'value': 0.0, 'raw': '0', 'human': 'keine Belastung'}},
  'Ambrosia': {'2019-04-19': {'value': 0.0,
    'raw': '0',
    'human': 'keine Belastung'},
   '2019-04-20': {'value': 0.0, 'raw': '0', 'human': 'keine Belastung'}}}}

```

## Development

### Development Workflow

This project includes comprehensive development tooling for code quality and dependency management.

#### Prerequisites

1. Install the package in development mode:
   ```bash
   pip install -e .
   ```

2. Install development dependencies:
   ```bash
   pip install pylint licensecheck pytest pytest-asyncio
   ```

3. Or use the included virtual environment setup:
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   pip install -e .
   pip install pylint licensecheck pytest pytest-asyncio
   ```

#### Development Scripts

Use the development script for common tasks:

```bash
# Lint the code with pylint
./scripts/dev.sh lint

# Check license compatibility 
./scripts/dev.sh license-check

# Run tests
./scripts/dev.sh test

# Run all checks (lint + license + tests)
./scripts/dev.sh check-all
```

#### Code Quality

- **Pylint Score**: All individual files achieve 10.00/10
- **Package Score**: 9.84/10 (only duplicate code warnings between sync/async clients)
- **License Compatibility**: All 29 dependencies are GPL-3.0+ compatible

#### Pre-commit Hooks

The project includes pre-commit hooks for automatic license checking:

```bash
# Install pre-commit (if not already installed)
pip install pre-commit

# Install the hooks
pre-commit install

# Run manually
pre-commit run --all-files
```

#### License Management

All dependencies are checked for GPL-3.0+ compatibility using `licensecheck`. The configuration is in `.licensecheck.ini` and integrated into the CI/CD pipeline.

## License
bloomtracker - API client for the "Deutscher Wetterdienst" to get the current pollen load in Germany
Copyright (C) 2025  Sascha Triller

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
