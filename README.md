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


 ## Branch: 17_db_cloud_firestore
 - Tasks that we will perform :
  1. Create a new Job.
  2. List all jobs.
  3. Edit an existing job.
  4. Delete existing job with all entries.
-------------------
  5. Create entry for a job.
  6. List all entry for a job.
  7. Edit entry for job.
  8. Delete entry for job.
-------------------
  9. View breakdown of all jobs,showing total hours worked and the pay. 

  - Database schema:
  ![Screenshot](/screenshot/db_schema.png)

  ### Firestore (NoSQL database)
  - Consist of `document` and `collection`
  - `Document` is a json key-value pair known as fields.
  - `Collection` is a colllection of `documents`
  
  ## Rule for accessing the document
  - e.g -> "users/user_123/jobs/job_abc"
  - `users` and `jobs` are collection is at odd position.
  - `user_123` and `job_abc` is document at even position.
  ![Screenshot](/screenshot/rule.png)
  
  ### Proceed with Firestore installation
  - Add latest dependency of cloud_firestore in pubspec.yaml.
  - Rename `HomePage` to `JobsPage`.
  - Add the FloatingActionButton in the JobsPage.
  - Created abstract class for `Database` and `FirestoreDatabase` and add the methods for accesing the firestore cloud apis.
  - Create a model class called `Job` which will be convert the object toMap() using the `toMap()` function.
   So whenever we have to create the key-value pair of job data we have to make a new instance of `Job(name:'blogging' ,ratePerHour:10)` as usage. 
   - On Firebase console update the rules for read/write permission
   `rules_version = '2';
    service cloud.firestore {
      
      match /databases/{database}/documents {
      //match is for path 
      // allow is for permission.
      //here we allow write only of uid is of logged in user.

      
      match /users/{uid}/jobs/{document=**} {
        allow read, write: if request.auth.uid == uid;
      }}}
  - `_createJob` defined in `JobsPage` create new Job for user when FloatingActionButton(+) is clicked.
  ### Next task is to read the jobs
  - We have created `jobsStream()` method in `database.dart` to read the list of jobs and return it as stream. But one thing important to note is we get the result in snapshot. And we have to map these data into our own model called `Job` . so we used the map operator.
  - We convert the map .toList() return the list of Stream<Job>
  - Create a static instance so that single instance of `FirestoreService` class can be always created.
  - Now we will create the new class FirestoreService which contains the single firestore instance and all firestore related methods making the `database.dart` and `FirestoreService` hold separate functions.
  ### Useful Links & Resources
  - Choose a Database: Cloud Firestore or Realtime Database: https://firebase.google.com/docs/database/rtdb-vs-firestore

  - What is a NoSQL database (video): https://www.youtube.com/watch?v=v_hR4K4auoQ

  - Enable multidex for apps with over 64K methods: https://developer.android.com/studio/build/multidex

  - FloatingActionButton class: https://api.flutter.dev/flutter/material/FloatingActionButton-class.html

  - Get started with Cloud Firestore Security Rules: https://firebase.google.com/docs/firestore/security/get-started

  - Factory constructors: https://dart.dev/guides/language/language-tour#factory-constructors

  - ListView class: https://api.flutter.dev/flutter/widgets/ListView-class.html
  
  ## Branch: 18_forms_cloud_firestore
  - Create a new Job form `AddJobPage` which will contain the form.
  - Create a `GlobalKey` to keep the track of the form variable state.
  - We have added a save TextButton on `AppBar` which will validate the form ,save the form and submit the details to firestore.
  - We used 'onSaved` and `validator` in `TextFormField` to get the values and show error when they are empty.
  - Now when saving the data we need access to `Database` but since our `AddJobPage` is not having the common ancestor we cant directly get the `Database` with the provider. so we can do is we can pass the `Database` instance from `JobsPage` because the `JobsPage` ancestor is the Provider (Database).
  - Now we will create a constructor in `AddJobPage` and call it from `show` method.
  - Enforce unique job name : so before submit fetch the latest snapshot stream of jobs as list and compare the newly added jobname in form is present in the list or not.
  - We renamed `AddJobPage` to `EditJobPage`.
  - We created `JobListTile` to display the list of jobs as a tile and created it as custom view to handle click event.
  - We now will use the `EditJobPage` to edit the exixting job by click on job tile and also to create new Job by sending the job as parameter.
  - We will send `job:null` for adding new job and to edit the job we will use the same form and populate the form field by extracting job value.
  ### To edit job we need job id (DocumentId is generic name for job_id in our case) as every entry is recognised as Document so to uniquely identify we call is documentId=Job_id.

  - To edit the job we need the job id so we need to change the `FirestoreService` because we are not using the job id so we need to change the model classes.
  - We change `collectionStream` function arg to accept the `documentId` and made changes from the respective `database` method.
  - We will now use the `createJob` method and rename to `createOrUpdateJob` from `edit_job.dart` class to create/update the job. We pass the job.id if its not null otherwise we pass `documentIdFromCurrentDate()` to create the new job with unique job id.
  - We also have to take care of the condition which checks the unique names before creating new job, that condition should be changed to handle the duplicate job name when we are just updating the job.

  - Form class: https://api.flutter.dev/flutter/widgets/Form-class.html
  - TextFormField class: https://api.flutter.dev/flutter/material/TextFormField-class.html
  - When user submits the request we made `isLoading=true` which hides `save` and show `loader'
  - Add `isLoading` in `edit_job.dart` to handle the loading state.
  - On Loading state used `Visibility` widget to hide the `save` and show `Loader` on `ActionBar-> action`.
  - So by doing this when we hide the save button no dupicate request can be made and loading is also controlled.

  ## Branch: 19_listviews_ui_states 
  ### We will be setting views for empty state,error 
  - We will handle the ui states like loading, empty and other states using `ListItemsBuilder<T>` class.
  - Use `ListView.Builder` is useful to load only those items which are visible . very useful for showing large list.Performance will also increase.(316)
  - We will use our custom created class called `ListItemsBuilder` in `jobs_page` to load the items as well as the ui states like empty,loading and error.
  - Divider : To add the divider between the list items we use `ListItemsBuilder.separated` through which we can add a `Divider` between the items using `height` attribute.

  ### Delete items using swipe gesture from firestore database.
  - Create method in `FirestoreService` and `database` class to delete the data. We need to pass the path to delete the job.
  - `Dismissible` widget to add swipe to dismiss feature on `ListTile`.
  - We can add the `direction` to apply for the swipe direction.
  - We can also supply the action/method in `onDismissed` to delete the item from database.
   
  ### Flutter Slidable: https://pub.dev/packages/flutter_slidable 

  ## Branch 20_datetime_pickers
  - We added the entries collection inside user path in firestore database.
  - Now earlier we show `EditJobPage` on click of list item tile , now we add one more route `JobEntriesPage` to show the entries for specific job.
  - But since database was not accesible using provider in `EditJobPage` because we inserted the `JobEntriesPage` route in between so we have passed the reference of `Datbase` in show method to perform the new job entry and edit the job entry which required `Database` from the `JobEntriesPage`.
  - In `EntryListItem` we used `inkwell` widget to show material effect.
  - Spread, collection if and collection for are special dart features which is useful when we want to add widgets based on certain condition.
  - Created a custom widget called `DateTimePicker` which includes `InputDropdown` custom widget and calls `showDatePicker` or `showTimePicker` methods to launch date/time picker.
  - video 333: When we update the job details on firestore and keep the job entry opened `JobEntriesPage` in the app then it will not reflect in the app because we need to add the Stream builder around in `JobEntriesPage`.
  - We have to add one method in `Database` to fetch the stream of job and then we wrap using the `StreamBuilder` in `JobEntriesPage`.
  ### Useful links

 - intl package: https://pub.dev/packages/intl

 - NumberFormat class: https://api.flutter.dev/flutter/intl/NumberFormat-class.html

 - DateFormat class: https://api.flutter.dev/flutter/intl/DateFormat-class.html

 - Making Dart a Better Language for UI: https://medium.com/dartlang/making-dart-a-better-language-for-ui-f1ccaf9f546c

 - Flutter Gallery source code: https://github.com/flutter/gallery

 - Cupertino (iOS-style) widgets: https://flutter.dev/docs/development/ui/widgets/cupertino

  
  ## Branch 21_bottom_navigation_cupertino
  ### Achieve: Multiple Navigation States.
  ### When navigating from one section. e.g Jobs->JObslist and then move to entries tab and pressing back we should come to JobsList.(Multiple Navigation State) thats why we used `CupertinoTabScaffold`

  - We need an additional page when user log in.
  - We need an additional page when user log in.
  - We will replace the `JobsPage` by `HomePage` which contains the `BottomNavigation` flow.
  - `HomePage` will keep the track of which page is getting selected.
  - Created model class and enum `TabItemData` which contains attribute of tab item name and icon.
  - Created enums of `TabItem` with `jobs,entries,account` tab.
  - We removed floatbutton from `JobsPage` and `JobEntriesPage` as it was overlapping with the `CupertinoBottomNavigation` so we removed and pushed `IconButton` at the action bar action.
  - Removed logout from the entries page and pushed to `AccountPage`.
  - In the new class `HomePage` updated the page to be loaded during navigation in `WidgetBuilders` map.

  ### Remove the add Job screen from Job entries flow and show it as independent.
  - We will show AddJob screen as full screen , we dont need bottom navigation there so we will have to attach the page at different level of view hierarchy.
  - `rootNavigator: true` :When using the `EditJobPage` we use navigator so if we dont need bottom navigation on `EditJobPage` then use `Navigator.of(context,rootNavigator: true)` while showing the route and same while showing the  `EntryPage`

  ### For modal and fullscreen dialog use `rootNavigator: true`, non modal dialogs omit the `rootNavigator` attribute.

  ### Handling back navigation for the tabs on android
  - We created the map of `navigatorKeys` which will track the navigation for each tab.
  - Conected the `navigatorKeys` with `CupertinoTabView` and passing the navigators.
  - We wrapped the `CupertinoHomeScaffold` with `WillPopScope` which will handle back navigation.
  - In `WillPopScope` we add `onWillPop` attribute which uses maybePop() which will return true/false when popped.
  - If there are more than one route then it pops and return true,otherwise it doesn't pop and give false.
  - Move to main route when click on bottom tab icons.

  ### Helpful resources

 - CupertinoTabScaffold class: https://api.flutter.dev/flutter/cupertino/CupertinoTabScaffold-class.html

 - CupertinoTabBar class: https://api.flutter.dev/flutter/cupertino/CupertinoTabBar-class.html

 - CupertinoTabView class: https://api.flutter.dev/flutter/cupertino/CupertinoTabView-class.html

 - CupertinoPageScaffold class: https://api.flutter.dev/flutter/cupertino/CupertinoPageScaffold-class.html

 - Flutter Bottom Navigation Bar with Multiple Navigators: A Case Study: https://codewithandrea.com/articles/multiple-navigators-bottom-navigation-bar/




  