# new_timetracker

New Time tracker flutter

## Completed Task
-Created the custom button with concepts of Extending the classes.
-For Firebase related modules check  (https://firebase.flutter.dev/)
-Integrated the firebase auth from (https://pub.dev/packages/firebase_auth) 
- [Stream Controller DartPad practice](https://dartpad.dartlang.org/0ca5b334ec413c084575f575e0240501)
## Branch : stream
-added stream builder to listen for Auth user from base class, 
-remove dependency on function callback to show home screen/login screen based on user state.
-converted Landing Page from stateful to stateless bc we dont need user to get tracked in state as we have used StreamBuilder for listening the auth state changes.

## Facebook/Google Login 
-Google Sign-In on iOS: https://firebase.google.com/docs/auth/ios/google-signin

-Google Sign-In on Android: https://firebase.google.com/docs/auth/android/google-signin

-Facebook Login for Android: https://developers.facebook.com/docs/facebook-login/android

-Facebook Login for iOS: https://developers.facebook.com/docs/facebook-login/ios

-Permissions with Facebook Login: https://developers.facebook.com/docs/facebook-login/permissions/overview
## Branch : 4_Google_Facebook_Login
-Integrating the Google sign and Facebook sign in.
-Setup steps:
1. https://console.developers.google.com/ 
(If you have created project in Firebaseconsole and the project is not listed then click "All Projects" from filter in google cloud console)
2. https://console.developers.google.com/apis/credentials/consent

-Steps are:

1. First we will use google_sign_in to perform google authentication.(same for fb auth)
2. If we get access token in response then we will send this token to Firebase console.
3. Firebase console will map the token and return the FirebaseUser in response.
4. Then we will continue the operation with User (from Firebase) and maintain the login session.
5. Note: Logout not only from Firebase but also from google and facebook when logout from HomePage.

## Branch : 5_email_password_login