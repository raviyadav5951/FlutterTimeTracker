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
5. Convert sign_in_page.dart to stateful widget to add loading state when user performs login.
when user login using any of the option deactiavte other buttons and show loader.
6. Added loading state and disabled buttons and show loader.
7. Dispose the objects not needed in email_sign_in_form

## Branch: 15_BLOC

## NOTE: use BLOC with stream of immutable objects.(To update the model classes objects we have to make the copy of objects and update the objects then add in stream)
- We will be using Streams, Stream Builder ,Provider to create and implement BLOC.
 Blocs are in the Data Layer.

1. Rules for BlOC
- Blocs only expose sinks and sources.
- Blocs have no UI code
- Blocs communicate with outside world via service(e.g. AuthService)
2. Created a signinBloc (methods for handling loading state==>stream controller +stream) and provided the bloc with the help of Provider.
3. Now we have to track the loading state through SignInBloc.
4. We will now provide the SignInBloc with the help of Provider in the same way like we did for AuthBase in LandingPage.
5. We have added StreamController in SignInPage to listen for the loading state through stream (not using state), since we have converted our signinpage to stateless widget.
6. In all the signinpage login methods we have used `final bloc = Provider.of<SignInBloc>(context, listen: false);`
    `bloc.setIsLoading(true);` to access/update the loading state.
### After using the consumer widget alternative of Provider
7. We have to use the `final bloc = Provider.of<SignInBloc>(context, listen: false);` in multiple places so we can use CONSUMER and pass the bloc reference in the constructor using Consumer through the constructor.
8. Dispose the bloc in provider.
### Moving the Auth logic from UI (SignInPage) to BLOC(SignInBloc)
9. We moved the AuthBase object in SignInBLoc using constructor from SignInPage.
we got the AuthBase auth from `final auth = Provider.of<AuthBase>(context,listen;false)` and passed in SignInBloc constructor.
10. We created custom `_signIn` method which accepts function as an argument which will perform login for us and return the User.
### Creating BLOC for EmailSignIn
11. Create a EmailSignInModel class to move all the state vars into the EmailSignInModel class.
12. Create a Bloc class around EmailSignInModel class. Stream<EmailSignInModel>
13. Instead of setState we have created updateWith in Bloc class to update the attribute using this method. e.g. when we have to update loading state we use `widget.bloc.updateWith(isLoading:true)`
14. Also created default constructor to init the EmailSignInModel with default values.
15. We wrapped the email_sign_in_form build widget with StreamController which listen to stream changes whenever we update any attribute. (same like sign_in_page build method)
16. We moved all the state variables inside the bloc.
17. Next step we moved the email,password error text, all the logics inside model class to get the values directly from the objects.

- final widget tree structure:
![Screenshot](/screenshot/widget_tree_bloc.png)

- Responsiblities of each component after implementing bloc
![Screenshot](/screenshot/bloc_responsibilities.png)

## Branch : 16_state_manage_provider
- Start with following migration :
-  Stream/Stream Controller ==> ValueNotifier
- Stream Builder ==> ChangeNotifierProvider/Consumer
- Concept is of subsctibe and listen model :
 ChangeNotifierProvider -->CreateValueNotifier
 Consumer --> Register for updates .

## NOTE: use ChangeNotifier with mutable objects.(At a time we have single objects copy is maintained unlike BLOC)
### Using ValueNotifier to check isLoading(bool) value change (SignInPage).
 - Here we have to track the isLoading (bool) to show progress bar that's why we have used `ValueNotifier` . In Later part in EmailSignInForm where we want to track model at that time we will be using `ChangeNotifier`
 - We will replace the code in sign_in_bloc where earlier we used to check loading state via stream in provider we will change isLoading value using isLoading.value .
 - Renamed sign_in_bloc to sign_in_manager
 - we have taken a isLoading as class variable and passed in constructor.
 - We have used Consumers to listen for the changes and rebuild widgets.

## NOTE: use ChangeNotifier with mutable objects.(At a time we have single objects copy is maintained unlike BLOC)
 ### ChangeNotifier to notify about model change(EmailSignInForm)
 - Approach is as below:
 1. First we will create New `EmailSignInModel` with `ChangeNotifier`.
 2. Add sumit method from `EmailSignInBloc`.
 3. Create New class from `EmailSignInFormBlocBased` -> `EmailSignInChangeNotifier`to use new model class.
 
 ### BLOC: immutable with Streams and ChangeNotifier (mutable)
 - First we have create a copy from `EmailSignInModel` to new class `EmailSignInChangeModel` and used `ChangeNotifier` as mixin.
 - Then remove the final fields from `EmailSignInChangeModel`.
 - Copied methods like toggleFormType and submit from `EmailSignInBloc` to `EmailSignInChangeModel`.
 - Create copy of new class `EmailSignInChangeNotifier` from `EmailSignInFormBlocBased`.
 - `EmailSignInChangeNotifier` class update the reference of `EmailSignInBloc bloc` with `EmailSignInChangeModel model' and remove dispose method.
 - After that remove the parent `StreamBuilder` widget from the build method in `EmailSignInChangeNotifier` and replace the model class with widget.model with the help of  getter method `EmailSignInChangeModel get model => widget.model;`
 - Last step we have to call our `EmailSignInChageNotifier` from `EmailSignInPage`instead of 
 `EmailSignInFormBlocBased.create()`

 ### When to choose between ValueNotifier and ChangeNotifier
 - Difference between ValueNotifier and ChangeNotifier :
   
   ValueNotifier is implementation of ChangeNotifier which implicitly call `notifyListeners()` so when value is updated it compares and return the updated value.

    `ChangeNotifier` gives us control to call `notifyListeners()` check the `EmailSignInChangeModel --> updateWith()`
 - So when to choose between them :
 - `ValueNotifier` is useful when we have to change the value for single type . i.e in our case `SignInPage` needed loading state.
 - `ChangeNotifier` can be useful for `EmailSignInChageNotifier` where we need to track the multiple objects at once.

 ### Useful links
 - Pragmatic State Management in Flutter (Google I/O'19): https://www.youtube.com/watch?v=d_m5csmrf7I

- My Reference Authentication Flow with Flutter & Firebase: https://github.com/bizz84/firebase_auth_demo_flutter

- Provider package: https://pub.dev/packages/provider

- ValueNotifier class: https://api.flutter.dev/flutter/foundation/ValueNotifier-class.html

- ChangeNotifier class: https://api.flutter.dev/flutter/foundation/ChangeNotifier-class.html


 