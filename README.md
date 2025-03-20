# DocuCare

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

## Prerequisites
- The prerequisite of the Lentho Mobile application is to always have the latest
version.
- Flutter version must be(minimum) : Flutter 2.5 • channel stable
- Dart version must be(minimum) : Dart 2.14.0
- Make sure your flutter and dart versions are correct. Follow the flutter
documentation from [Download Flutter](https://flutter.dev/docs/get-started/install) to install the given version of a flutter on your pc/mac/linux.

## Enviornment Setup
- Create one environment file on the root level of the project- ```.env.variables```
- Create two variables: 
    - ```SUPABASEURL = ENTER YOUR SUPABASE URL``` 
    - ```SUPABASE_KEY = ENTER SUPABASE ANON KEY```

## Run Flutter Application 
- Clone the Github repository an store it on a folder.
- Install Android Studio from [this link](https://developer.android.com/studio)
- If you prefer visual studio code, download vscode from [this link](https://code.visualstudio.com/Download)
- Install the emulator from the android studio.
- After installing, open terminal and run ```flutter doctor``` to check everything is working fine or not.
- Open the folder in your android studio/vscode.
- Even if you are building an app for ios, use android studio/vscode for the build.
- Then in your android studio terminal run: ```flutter pub get``` to get all 3rd party packages from pub.dev
- Then open the emulator and in terminal run: ```flutter run``` to build the app.
