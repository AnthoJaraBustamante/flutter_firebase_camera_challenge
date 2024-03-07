# Flutter Photo Upload App

## Objective

Develop a Flutter app that enables users to capture and upload photos using the device's camera. The app should leverage Riverpod for state management, integrate the CameraAwesome package for camera functionality, and communicate with a Firebase project for photo storage and Firestore database updates.

## Requirements

- **Riverpod (version 2.3.6):** Utilized for efficient state management within the app.
- **CameraAwesome (version 1.4.0):** Integrated to provide robust camera functionality.
- **Firebase Integration:**
  - The app interacts with a Firebase project, which should be created and configured for use with the Flutter project.
  - Photos captured are uploaded to Firebase Storage.
  - Information about each upload, including URL and timestamp, is stored in a Firestore document.

## App Structure

The app comprises at least three screens:

1. **Home Screen:**
   - Contains a button to open the camera screen.
   - Displays a list with information about previous photo uploads.

2. **Camera Screen:**
   - The second screen allows users to capture photos using the device's camera.
   - Utilizes the CameraAwesome package for camera functionality.

3. **Uploaded Photo Screen:**
   - This additional screen showcases uploaded photos with detailed information.

## Usage

1. Clone the repository.
2. Ensure that Flutter is installed on your development environment.
3. Run `flutter pub get` to fetch the required dependencies.
4. Launch the app using `flutter run`.
