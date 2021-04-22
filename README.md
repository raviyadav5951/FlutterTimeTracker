# new_timetracker

New Time tracker flutter

## Completed Task
- Created the custom button with concepts of Extending the classes.
- For Firebase related modules check  (https://firebase.flutter.dev/)
- Integrated the firebase auth from (https://pub.dev/packages/firebase_auth) 
- [Stream Controller DartPad practice](https://dartpad.dartlang.org/0ca5b334ec413c084575f575e0240501)
## Branch : stream
- Added stream builder to listen for Auth user from base class, 
- Remove dependency on function callback to show home screen/login screen based on user state.
- Converted Landing Page from stateful to stateless bc we dont need user to get tracked in state as we have used StreamBuilder for listening the auth state changes.

## Facebook/Google Login 
- Google Sign-In on iOS: https://firebase.google.com/docs/auth/ios/google-signin

- Google Sign-In on Android: https://firebase.google.com/docs/auth/android/google-signin

- Facebook Login for Android: https://developers.facebook.com/docs/facebook-login/android

- Facebook Login for iOS: https://developers.facebook.com/docs/facebook-login/ios

- Permissions with Facebook Login: https://developers.facebook.com/docs/facebook-login/permissions/overview
## Branch : 4_Google_Facebook_Login
- Integrating the Google sign and Facebook sign in.
- Setup steps:
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
1. field validation
2. focus nodes, 
3. conditonal enabling/disbaling buttons
4. loading state when api gets called then to avoid multiple api call request disable the buttons and input fields till api response arrives.
5. onEditingComplete, onTextChanged ,textInputAction, keyboard type attributes of Textfield

## Branch: 6_platform_dialogs
1. showDialog(context,builder) on exception 
2. Material widget for android and cupertino for ios platform

- Cupertino (iOS-style) widgets: https://flutter.dev/docs/development/ui/widgets/cupertino

- Material Components widgets: https://flutter.dev/docs/development/ui/widgets/material

## Branch 13_scopedaccess_inheritedwidget.
- Scoped Access with InheritedWidget:
### Manually creating the inherited widget to supply the common Auth object
- Problem : All widgets need Auth class (wrapper for FirebaseAuth class) just to pass the auth object to child classess through the constructor, even though they dont need it for their usage.
- Solution : We will remove this constructor injection of auth and supply auth wherever needed without the constructor approach.
- Created AuthProvider extends InheritedWidget which is a widget only and return the common AuthBase functionality once it is inserted in the widget hierarchy in main.dart.
- For usage we just have to do this ` final auth = AuthProvider.of(context);' 

### To ease the process of Inherited widget we use Provider package as wrapper and its kind of generic InheritedWidget.
- Use provider package to easily map the AuthBase class using Provider.
- We will not be using ` final auth = AuthProvider.of(context);' instead we will use more generic form 
like final auth = Provider.of<AuthBase>(context,listen: false);

- final widget tree structure:
![Screenshot](/screenshot/widget_tree_after_provider.png)

- Strategy we have used till now for accessing the object
![Screenshot](/screenshot/strategy_for_object_passing.png)

### Useful Links & Resources
1. InheritedWidget class: https://docs.flutter.io/flutter/widgets/InheritedWidget-class.html

2. provider package: https://pub.dev/packages/provider

3. dependOnInheritedWidgetOfExactType method: https://api.flutter.dev/flutter/widgets/BuildContext/dependOnInheritedWidgetOfExactType.html

4. getElementForInheritedWidgetOfExactType method: https://api.flutter.dev/flutter/widgets/BuildContext/getElementForInheritedWidgetOfExactType.html

## Branch: 14_polish_auth_flows
1. We have created a custom alert dialog for handling the exception.
2. We show dialog in case of login returns any exception.
3. We show exception only if this is not the case : ERROR_SIGN_IN_ABORTED 
4. ERROR_SIGN_IN_ABORTED is the code we are returning from the auth methods which performs login.
