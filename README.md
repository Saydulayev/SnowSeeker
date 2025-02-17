# SnowSeeker

SnowSeeker is a demo SwiftUI application that displays ski resorts from a local JSON file. It features a searchable list, sorting options (default, alphabetical, and country), and a favorites functionality with persistence using UserDefaults.

## Main Features
- **Resort List**: Displays data from `resorts.json`.
- **Search**: Filter resorts by name.
- **Sorting**: Sort resorts by default order, alphabetical order, or by country.
- **Favorites**: Add and remove resorts from favorites with persistence.
- **Detail Views**: Show detailed resort information including facilities and other specifics.

## Project Structure
- **`SnowSeekerApp.swift`**: Application entry point.
- **`ContentView.swift`**: Main view with the resort list, search, and sorting.
- **`Favorites.swift`**: Manages favorite resorts and handles persistence with UserDefaults.
- **`Resort.swift`**: Data model for resorts.
- **`ResortView.swift`** and related views: Display detailed information for each resort.
- **`Bundle+Decode.swift`**: Utility extension for decoding JSON files.
- **Other Files**: Additional views like `Facility.swift`, `ResortDetailsView.swift`, `SkiDetailsView.swift`, and `WelcomeView.swift` support the app’s functionality.

## How to Run
1. Clone the repository:
   ```bash
   git clone https://github.com/Saydulayev/SnowSeeker.git
   ```
2. Open the project in Xcode:
   ```bash
   cd SnowSeeker
   open SnowSeeker.xcodeproj
   ```
3. Run the project on a simulator or device.

## Acknowledgments
- Data and inspiration from [Paul Hudson (@twostraws)](https://www.hackingwithswift.com).

## License
This project is open source under the MIT License. See the [LICENSE](LICENSE) file for details.
