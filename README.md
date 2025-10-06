# Sports Tech Skills App
A simple and attractive Flutter application designed to display a list of sports skills, elegantly grouped by level (Basic, Intermediate, and Advanced) in a horizontally scrolling UI.

## Features

- **Grouped by Skill Level:** Skills are parsed from a local JSON source and automatically organized into three distinct categories.

- **Ordered Display:** Categories are presented in a logical progression: Basic → Intermediate → Advanced.

- **Horizontal Carousels:** Each skill level is displayed in its own smooth, horizontally scrolling carousel.

- **Attractive UI:** Features a modern, bright UI with vibrant colors, custom gradients, and a "frosted glass" effect on skill cards for clear text visibility.

- **Responsive Design:** The layout is built to be responsive and works well on various screen sizes.

- **Local Asset Management:** Loads all skill images from the local assets folder for fast, offline-first performance.

Screenshot
<p align="center">
<img src="assets/images/app sc1.jpg" alt="Screen 1" width="250"/>
<img src="assets/images/app sc2.jpg" alt="Screen 2" width="250"/>
</p>

## Getting Started

To get a local copy up and running, follow these simple steps.

**Prerequisites**
You must have Flutter installed on your machine. For installation instructions, see the official Flutter documentation.

**Installation**

1. *Clone the repo*
```sh
git clone [https://github.com/your_username/sports_tech_app.git](https://github.com/your_username/sports_tech_app.git)
```

2. *Navigate to the project directory*
```sh
cd sports_tech_app
```
3. *Install dependencies*
```sh 
flutter pub get
```

4. *Run the app*
```sh 
flutter run
```

## Folder Structure
The project follows a standard Flutter structure. All the application logic is contained within lib/main.dart.
```sh 
sports_tech_app/
├── assets/
│   └── images/         # Contains all the skill images
├── lib/
│   └── main.dart       # Main application file
└── pubspec.yaml        # Project dependencies and asset declarations
```

## Built With
- [Flutter](https://flutter.dev/) - The UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
- [Dart](https://dart.dev/) - The programming language used by Flutter.