# Novelist Plus

Novelist Plus is a Flutter application designed to help novelists and writers organize their stories, characters, and plotlines. It provides a rich text editor with Markdown support, along with tools for managing projects, scenes, and items. The app is designed to be cross-platform, with support for mobile, desktop, and web.

## Features

- **Project Management**: Create and manage multiple writing projects, each with its own set of characters, scenes, and settings.
- **Rich Text Editor**: A powerful Markdown editor with support for custom syntax, including callouts and wikilinks.
- **Character and Item Tracking**: Keep track of characters, locations, props, and other items in your story.
- **Scene Organization**: Organize your story into scenes, and link them to characters and items.
- **Cross-Platform**: Built with Flutter, Novelist Plus is designed to run on mobile, desktop, and web from a single codebase.
- **Theming**: Includes both light and dark themes to suit your preferences.

## Project Structure

The project is organized into the following directories:

- `lib/`: The main source code for the application.
  - `app/`: Contains the application's router and theme.
  - `core/`: Core utilities, including the dependency injection setup.
  - `data/`: The data layer, including the database service, models, and repositories.
  - `domain/`: The domain layer, containing the core business logic and entities.
  - `features/`: The feature modules of the application, such as the dashboard, notes, and project screens.
  - `widgets/`: Shared widgets that are used across multiple features.
  - `src/`: Additional source files, including more shared widgets.
  - `main.dart`: The main entry point for the application.
- `assets/`: Contains static assets, such as templates and images.
- `test/`: Contains the unit and widget tests for the application.

## Getting Started

To get started with the project, you will need to have the Flutter SDK installed. You can find instructions for installing Flutter [here](https://docs.flutter.dev/get-started/install).

Once you have Flutter installed, you can clone the repository and run the application using the following commands:

```bash
# Clone the repository
git clone https://github.com/your-username/novelist-plus.git

# Navigate to the project directory
cd novelist-plus

# Install the dependencies
flutter pub get

# Run the application
flutter run
```

## State Management

The application uses the [Riverpod](https://riverpod.dev/) package for state management. Providers are defined in the `lib/core/di.dart` file and are used to provide instances of repositories and other services to the rest of the application.

## Database

The application uses a platform-specific database service to store data.

- **Mobile and Desktop**: The application uses the [Isar](https://isar.dev/) database for mobile and desktop platforms. Isar is a fast, full-text searchable, and easy-to-use database for Flutter.
- **Web**: For the web, the application uses an in-memory database. This is intended for demonstration purposes, and in a real-world application, you would likely want to use a more persistent storage mechanism like IndexedDB or local storage.

The database service is provided through the `databaseServiceProvider` in `lib/core/di.dart`, which is overridden in `lib/main.dart` with the appropriate platform-specific implementation.