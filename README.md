![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)  ![Firebase](https://img.shields.io/badge/firebase-%23039BE5.svg?style=for-the-badge&logo=firebase) ![Android Studio](https://img.shields.io/badge/Android%20Studio-3DDC84.svg?style=for-the-badge&logo=android-studio&logoColor=white)
# Survey mobile Application

## Features of the application

  - Take easy surveys with this survey mobile app.
  - Stores result in firebase.
  - Has an Admin page where the admin can view the results of the survey.
  - Providing a downloadable pdf file for results.
  - Amazing UI


> Note: Please register your app with firebase and download the services.json fill it into the app folder
> >  Also enable email authentication and fire store in firebase 

You can Follow any youtube video for the firebase setup.

# Cloning and running

  After cloning the project run
```
  flutter pub get
```
Then configure your virtual device or your mobile and run,

```
flutter run 
```

  Every dependency are up to data as of 05/03/2022.

## Packages Used

  + **firebase_auth** for admin login
  + **cloud_firestore** for storing results of survey
  + **flutter_svg** for having svg background
  + **fluttertoast** for successful login and error messages
  + **country_list_pick** api for selecting country for user.
  + **syncfusion_flutter_pdf** for creating pdf.
  + **path_provider**,**open_file** for downloading pdf and prompting storage permissions.

> Please refer to `pubspec.yaml` for versions of the pacakges.

This project is a starting point for a Flutter application with firebase authentication and read ,write data in  firebase.
#### Links

  The ui of the survey app is an abstract from this [repo](https://github.com/abuanwar072/Quiz-App-Flutter).
  
For help getting started with Flutter development, view the [online documentation](https://docs.flutter.dev), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
