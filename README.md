# 🛸 Rick & Morty Explorer

<div align="center">
  <img src="https://github.com/user-attachments/assets/e46e2587-628a-434a-b65a-86044e70ea0f" alt="Rick & Morty Explorer" width="200"/>
  
  **A beautifully crafted Flutter app to explore the multiverse of Rick and Morty characters**
  
  [📱 View Demo](#-demo) • [🚀 Features](#-features) • [📸 Screenshots](#-screenshots) • [⚡ Quick Start](#-quick-start)
</div>

---

## 🌟 Overview

Dive into the chaotic multiverse of Rick and Morty with this polished Flutter application. Built with clean architecture principles and modern UI patterns, this app delivers a seamless experience for exploring characters, managing favorites, and browsing offline with stunning animations and intuitive design.

## 🚀 Features

### 🎯 Core Functionality
- **📜 Character Discovery** - Infinite scroll through hundreds of characters with shimmer loading effects
- **🔍 Smart Search** - Debounced search by name with real-time filtering
- **⚡ Advanced Filtering** - Filter by status (Alive, Dead, Unknown) with animated filter chips
- **❤️ Favorites Management** - Save and organize your favorite characters locally
- **🌐 Offline Support** - Seamless offline experience with cached data and connectivity indicators

### 🎨 User Experience
- **🎭 Hero Animations** - Smooth transitions between character list and detail views
- **✨ Shimmer Effects** - Beautiful loading placeholders throughout the app
- **🎨 Themed UI** - Portal green and sci-fi blue color palette inspired by the show
- **📱 Responsive Design** - Optimized for all screen sizes and orientations

### 🛠️ Technical Excellence
- **🏗️ Clean Architecture** - Separation of concerns with presentation, domain, and data layers
- **🔄 State Management** - Robust BLoC pattern implementation
- **💾 Smart Caching** - Intelligent local storage with Hive database
- **🌐 Network Resilience** - Graceful error handling and offline fallbacks

---

## 📸 Screenshots

<div align="center">

### 🏠 Main Experience
<table>
  <tr>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/8c193514-6f16-4bc5-a9cc-a0e60b3f76e6" width="200"/>
      <br><b>🔍 Smart Search</b>
      <br><sub>Real-time character search with debounce</sub>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/59e6e7a9-602d-4b36-b454-d001015a4e67" width="200"/>
      <br><b>⚡ Advanced Filters</b>
      <br><sub>Filter by character status with animations</sub>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/b44a081e-4e27-4256-90aa-54a08d7380a7" width="200"/>
      <br><b>📋 Character Details</b>
      <br><sub>Rich detail view with hero animations</sub>
    </td>
  </tr>
</table>

### ❤️ Favorites & Connectivity
<table>
  <tr>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/7acfe096-49a7-40b0-8a88-0959db2945e2" width="200"/>
      <br><b>❤️ Favorites Collection</b>
      <br><sub>Manage your favorite characters</sub>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/d7249fff-fe76-4ce4-b341-12d96408cd43" width="200"/>
      <br><b>📭 Empty State</b>
      <br><sub>Elegant empty favorites screen</sub>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/db79d075-4cc1-4c3a-ba6d-024e2d184548" width="200"/>
      <br><b>🌐 Offline Mode</b>
      <br><sub>Seamless offline experience</sub>
    </td>
  </tr>
</table>

### 🔗 Connectivity States
<table>
  <tr>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/9fa9d703-ecea-485a-acae-0ec1c4d43ebd" width="300"/>
      <br><b>📡 Connection Status</b>
      <br><sub>Real-time connectivity indicators</sub>
    </td>
  </tr>
</table>

</div>

---

## 🏗️ Architecture

### 📐 Architecture Pattern
Built with **Clean Architecture** principles and **BLoC** state management for scalability and maintainability.

<div align="center">
  <img src="https://github.com/user-attachments/assets/fa34287e-a971-410e-b7fd-26c2cd3b52a8" alt="Architecture Diagram" width="600"/>
</div>

### 🎯 Layer Structure
- **🎨 Presentation Layer** - Flutter UI components with BLoC state management
- **🧠 Domain Layer** - Business logic, entities, and repository abstractions
- **💾 Data Layer** - API clients, local storage, and repository implementations

### 🛠️ Tech Stack
| Category | Technology |
|----------|------------|
| **Framework** | Flutter 3.22+ |
| **State Management** | BLoC Pattern with `flutter_bloc` |
| **Dependency Injection** | `get_it` |
| **Networking** | `dio` + `retrofit` |
| **Local Storage** | `hive` |
| **Code Generation** | `freezed`, `json_serializable` |
| **UI/UX** | Custom animations, Hero transitions, Shimmer effects |

```
lib/
├── 🏗️ core/
│   ├── di/                 # Dependency injection setup
│   ├── helpers/            # Utilities (debouncer, extensions)
│   ├── network/            # Network layer & error handling
│   ├── routes/             # App navigation
│   ├── theming/            # UI theme & styling
│   └── widgets/            # Shared UI components
└── 📱 features/
    └── characters/
        ├── 💾 data/
        │   ├── datasources/    # Remote API & local cache
        │   ├── models/         # Data transfer objects
        │   └── repos/          # Repository implementation
        ├── 🧠 domain/
        │   ├── entities/       # Core business objects
        │   ├── repositories/   # Repository contracts
        │   └── usecases/       # Business logic
        └── 🎨 presentation/
            ├── bloc/           # State management
            ├── screens/        # UI screens
            └── widgets/        # Feature-specific widgets
```

---

## ⚡ Quick Start

### 📋 Prerequisites
- Flutter 3.22 or higher
- Dart 3.0 or higher
- Android Studio / VS Code with Flutter extensions

### 🚀 Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/rick-morty-explorer.git
   cd rick-morty-explorer
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

---

## 🧪 Testing

### Run Tests
```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage
```

### 📊 Test Coverage
- ✅ Unit tests for all use cases
- ✅ Widget tests for critical UI components

---

## 📱 Demo

<div align="center">
  
**🎬 Watch the full demo video**
  
[![Demo Video](https://img.shields.io/badge/📹_Watch_Demo-blue?style=for-the-badge&logo=google-drive)](https://drive.google.com/drive/folders/18adahAZI_CQddwLpGpVY0jHI2zKGxV-D)

*Experience the app in action with smooth animations and seamless interactions*

</div>

---

## 🌐 API Integration

**Powered by the Rick and Morty API**
- Base URL: `https://rickandmortyapi.com/api`
- Real-time character data
- Comprehensive character information
- Reliable and well-documented endpoints

---

## 🎨 Design Philosophy

### 🌈 Color Palette
- **Portal Green** - Primary accent inspired by Rick's portal gun
- **Sci-Fi Blue** - Secondary colors for futuristic feel
- **Dark Theme** - Immersive experience matching the show's aesthetic

### ✨ Animation Principles
- **Hero Animations** - Seamless navigation transitions
- **Shimmer Loading** - Engaging loading states
- **Micro-interactions** - Delightful user feedback

---



## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Credits & Acknowledgments

- **[Rick and Morty API](https://rickandmortyapi.com/)** - Providing the excellent character data
- **Flutter Community** - For the amazing packages that make this app possible
- **Adult Swim** - For creating the incredible Rick and Morty universe

---

<div align="center">
  
**Built with ❤️ and lots of ☕**

*Get schwifty with Flutter development!* 🛸

</div>
