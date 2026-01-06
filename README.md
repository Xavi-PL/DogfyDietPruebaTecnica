# DogfyDiet - Dog Profile Wizard by Xavi Pineda

A Flutter application that guides users through creating a comprehensive profile for their dogs, with support for draft saving and automatic address detection.

## Table of Contents

- [Running the App Locally](#running-the-app-locally)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Running on Emulator](#running-on-emulator)
  - [Running on Physical Device](#running-on-physical-device)
- [Architecture](#architecture)
  - [Clean Architecture](#clean-architecture)
  - [Layer Structure](#layer-structure)
  - [Dependency Injection](#dependency-injection)
- [Running Tests](#running-tests)
- [Screenshots](#screenshots)

---

## Running the App Locally

### Prerequisites

The project was created with the following tools:

- **Flutter SDK**: 3.38.5
- **An IDE**: Google Antigravity

### Installation

1. **Clone the repository** (if not already done):
   ```bash
   git clone <repository-url>
   cd dogfy_diet_prueba_tecnica
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Verify Flutter installation**:
   ```bash
   flutter doctor
   ```
   This command checks your environment and displays a report of the status of your Flutter installation. Fix any issues that are reported.

### Running on Emulator

#### Android Emulator

1. **Start an Android Emulator**:
   - On Google Antigravity, select the emulator you want to use and click on the play button.
   - Or use command line:
     ```bash
     flutter emulators --launch <emulator-name>
     ```

2. **Run the app**:
   ```bash
   flutter run
   ```

#### iOS Simulator (macOS only)

1. **Start the iOS Simulator**:
   - On Google Antigravity, select the simulator you want to use and click on the play button.
   - Or use command line:
     ```bash
     open -a Simulator
     ```

2. **Run the app**:
   ```bash
   flutter run
   ```

### Running on Physical Device

#### Android Device

1. **Enable Developer Options and USB Debugging** on your Android device:
   - Go to Settings → About Phone → Tap "Build Number" 7 times
   - Go to Settings → Developer Options → Enable "USB Debugging"

2. **Connect your device** via USB

3. **Verify device connection**:
   ```bash
   flutter devices
   ```

4. **Run the app**:
   ```bash
   flutter run
   ```

#### iOS Device (macOS only)

1. **Connect your iOS device** via USB

2. **Trust your computer** on the device when prompted

3. **Configure signing** in Xcode:
   - Open `ios/Runner.xcworkspace` in Xcode
   - Select your device as the target
   - Configure your development team in Signing & Capabilities

4. **Run the app**:
   ```bash
   flutter run
   ```

---

## Architecture

This project follows **Clean Architecture** principles with a clear separation of concerns across multiple layers. The architecture ensures maintainability, testability, and scalability.

### Clean Architecture

The application is structured in three main layers:

```
lib/
├── core/                    # Shared utilities and platform services
│   ├── di/                 # Dependency injection setup
│   ├── platform/           # Platform-specific services (location, etc.)
│   └── utils/              # Shared utilities
│
└── features/               # Feature modules
    └── profile/           # Dog profile feature
        ├── data/          # Data layer (repositories, data sources, DTOs)
        ├── di/            # Dependency injection setup
        ├── domain/        # Domain layer (entities, repositories, use cases)
        └── presentation/  # Presentation layer (BLoC, UI)
            ├── bloc/      # BLoC pattern implementation
            ├── view/      # UI views
            └── widgets/   # UI widgets used on all views
```

### Layer Structure

#### 1. Domain Layer (`domain/`)

The **innermost layer** containing business logic and entities. It has no dependencies on other layers.

**Components:**
- **Models** (`model/`): Core business entities
  - `DogProfile`: Main entity representing a dog's profile
  - `Breed`: Dog breed information
  - `Owner`: Owner information
  - Enums: `DogSex`, `DogSize`, `DogActivity`, `DogGastronomy`, `Country`

- **Repositories** (`repository/`): Abstract interfaces defining data operations
  - `DogProfileLocalRepository`: Interface for local draft storage
  - `DogProfileRemoteRepository`: Interface for remote API operations

- **Use Cases** (`usecase/`): Business logic operations (Single Responsibility Principle)
  - `SaveDogProfileDraftUseCase`: Save draft locally
  - `LoadDogProfileDraftUseCase`: Load draft from local storage
  - `ClearDogProfileDraftUseCase`: Clear saved draft
  - `HasDogProfileDraftUseCase`: Check if draft exists
  - `GetDogBreedsUseCase`: Fetch available breeds
  - `CreateDogProfileUseCase`: Submit profile to server

#### 2. Data Layer (`data/`)

**Implements domain interfaces** and handles data operations.

**Components:**
- **Data Sources** (`datasource/`): 
  - `DogProfileLocalDataSourceImpl`: Hive-based local storage for drafts
  - `DogProfileRemoteDataSourceImpl`: Mock remote API (loads from assets/mock/breeds.json, simulates 80% success rate)

- **Repositories** (`repository/`): 
  - `DogProfileLocalRepositoryImpl`: Implements `DogProfileLocalRepository`
  - `DogProfileRemoteRepositoryImpl`: Implements `DogProfileRemoteRepository`

- **Models/DTOs** (`model/`): Data Transfer Objects for JSON serialization

- **Mappers** (`mapper/`): Convert between domain entities and DTOs
  - `DogProfileMapper`: Maps DogProfile ↔ DTO
  - `BreedMapper`: Maps Breed ↔ DTO

**Technologies:**
- **Hive**: Local NoSQL database for draft persistence

#### 3. Presentation Layer (`presentation/`)

**UI and state management** using BLoC pattern.

**Components:**
- **BLoC** (`bloc/`):
  - `DogProfileBloc`: Manages state for the entire wizard
  - `DogProfileEvent`: All user actions (breed selection, name input, etc.)
  - `DogProfileState`: Current state of the wizard (current step, profile data, loading states)

- **Views** (`view/`):
  - `DogProfileWizardScreen`: Main wizard screen with 9 steps
  - `DogProfileWizardStep`: Reusable step view
  - `ProfileWizardFinish`: Success screen
  - `ProfileWizardLoading`: Loading screen

- **Widgets** (`widgets/`): Reusable UI components for input fields and selectors, most of the widgets are built in order to be usable on all views.

---

**Platform Services** (`core/platform/`): 
Platform-specific services (location). Moved here because this feature would be used in other features in the future and, even now that's only for profile, it's a common reused feature. Built also with Clean Architecture principles in mind.

---

**Key Features:**
- **Multi-step wizard** with 9 steps (breed, name, gender/sterilization, birth date, size/weight, activity, illness, gastronomy, owner info)
- **Draft auto-save**: Automatically saves progress after each step
- **Draft restoration**: Resumes from last completed step on app restart
- **Automatic address detection**: Uses geolocation services (with permission handling)
- **Form validation**: Real-time validation with error messages

### Dependency Injection

The app uses **GetIt** for dependency injection, configured in `lib/core/di/injection.dart`.

**Module Structure:**
- `registerLocationModule()`: Platform services (geolocation, geocoding)
- `registerDogProfileModule()`: Profile feature dependencies

**Initialization:**
```dart
Future<void> setupInjection() async {
  await _initializeHive();
  initializeDateFormatting();
  registerLocationModule();
  registerDogProfileModule();
}
```

All dependencies are registered at app startup in `main.dart`.

---

## Running Tests

This project includes comprehensive unit tests for the data layer.

### Running All Tests

```bash
flutter test
```

### Test Structure

The test suite follows the same structure as the main code:

```
test/
├── features/
│   └── profile/
│       ├── data/
│       │   ├── datasource/
│       │   ├── mapper/
│       │   └── repository/
│       ├── domain/
│       │   └── usecase/
│       └── presentation/
│           └── bloc/
└── widget_test.dart
```

## Project Features

✅ **Multi-step dog profile creation wizard**  
✅ **Draft auto-save and restoration**  
✅ **Automatic address detection via GPS**  
✅ **Clean Architecture with clear separation of concerns**  
✅ **Comprehensive error handling with user-friendly messages**  
✅ **Form validation and input formatters**  
✅ **Mock backend with configurable success rates**  
✅ **Unit tests for data layer**  

## Screenshots

![Screenshot](https://i.imgur.com/Zm6GmQt.png)
![Screenshot](https://i.imgur.com/uOvc5tt.png)
![Screenshot](https://i.imgur.com/qFGqiFZ.png)

