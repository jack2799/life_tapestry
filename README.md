# Life Tapestry

A beautiful, cross-platform journaling application built with Flutter to help you document and organize life events across key life areas: Health, Work, and Relationships. Capture your moments, track your progress, and weave your unique life story.

## ✨ Features

- **Create & Manage Entries**: Write, edit, and organize your journal entries with ease
- **Smart Categorization**: Organize entries into three main categories:
  - 🏥 Health - Track wellness, fitness, and personal health milestones
  - 💼 Work - Document career achievements and professional growth
  - 💕 Relationships - Record meaningful moments with loved ones
- **Filter & Search**: Quickly find entries by category
- **Local Storage**: All data is securely stored locally using SQLite database
- **Beautiful UI**: Minimalist design with category-specific color coding
- **Cross-Platform**: Works seamlessly on iOS, Android, macOS, Windows, Linux, and Web

## 📁 Project Structure

```
lib/
├── main.dart                 # App entry point and theme configuration
├── models/
│   └── entry.dart           # Entry data model and Category enum
├── providers/
│   └── entry_provider.dart  # State management using Provider pattern
├── screens/
│   ├── home_screen.dart     # Main home screen with entry list
│   └── entry_editor_screen.dart  # Entry creation/editing screen
├── services/
│   └── database_service.dart # SQLite database operations
├── widgets/
│   ├── category_card.dart   # Category selection widget
│   ├── entry_list_item.dart # Individual entry display widget
│   ├── filter_button.dart   # Filter button component
│   └── empty_state.dart     # Empty state UI
└── utils/                    # Utility functions and helpers
```

## 🛠 Technologies Used

- **Framework**: [Flutter](https://flutter.dev/) 3.4.0+
- **State Management**: [Provider](https://pub.dev/packages/provider) 6.0.0
- **Database**: [SQLite](https://www.sqlite.org/) with [sqflite](https://pub.dev/packages/sqflite)
- **File Storage**: [path_provider](https://pub.dev/packages/path_provider)
- **Internationalization**: [intl](https://pub.dev/packages/intl)
- **Utilities**: [uuid](https://pub.dev/packages/uuid) for unique ID generation

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.4.0 or higher
- Dart 3.4.0 or higher
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/life_tapestry.git
   cd life_tapestry
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

   To run on a specific platform:
   ```bash
   flutter run -d android    # Android
   flutter run -d ios        # iOS
   flutter run -d macos      # macOS
   flutter run -d windows    # Windows
   flutter run -d linux      # Linux
   flutter run -d chrome     # Web
   ```

## 📱 Platform Support

| Platform | Status | Notes |
|----------|--------|-------|
| Android  | ✅ Supported | API level 21+ |
| iOS      | ✅ Supported | iOS 11.0+ |
| macOS    | ✅ Supported | macOS 10.11+ |
| Windows  | ✅ Supported | Windows 7+ |
| Linux    | ✅ Supported | glibc 2.17+ |
| Web      | ✅ Supported | Modern browsers |

## 📝 Usage

1. **Create an Entry**
   - Tap the "+" button on the home screen
   - Enter a title and content
   - Select a category (Health, Work, or Relationships)
   - Save the entry

2. **View Entries**
   - Entries are displayed chronologically on the home screen
   - Each entry shows the category, title, and creation date

3. **Filter by Category**
   - Use the filter buttons at the top of the home screen
   - Select multiple categories to view combined entries

4. **Edit an Entry**
   - Tap on any entry to open the editor
   - Make your changes and save

## 🎨 Design

The app features a clean, minimalist design with a warm, neutral color palette:
- **Background**: Soft cream (#F5F3F0)
- **Health**: Soft green (#D4EDD9)
- **Work**: Soft blue (#D4E1F5)
- **Relationships**: Soft rose (#F5D4DC)
- **Primary**: Deep teal (#4A6B7A)

## 🔒 Data & Privacy

All data is stored locally on your device using SQLite. No data is sent to external servers. You have complete control over your journal entries.

## 🤝 Contributing

Contributions are welcome! Feel free to fork this repository and submit pull requests with improvements.

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 📧 Support

For issues, questions, or suggestions, please open an issue on the GitHub repository.

---

**Made with ❤️ - Your personal journal, your way.**
