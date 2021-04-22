import 'package:flutter/material.dart';
import 'package:new_timetracker/app/services/auth.dart';

/// We will be replacing this inherited widget once we use Provider as an wrapper around inherited widget.
/// We dont want to do this hassle for each provider thats why we will discard this class.
class AuthProvider extends InheritedWidget {
  final AuthBase auth;
  final Widget child;

  /// This constructor will be used when we insert this widget in our widget hierarchy in main.dart
  AuthProvider({@required this.auth, @required this.child});

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }

  /// usage: AuthBase auth= AuthBase.of(context);
  static AuthBase of(BuildContext context) {
    AuthProvider provider =
        context.dependOnInheritedWidgetOfExactType<AuthProvider>();
    return provider.auth;
  }
}
