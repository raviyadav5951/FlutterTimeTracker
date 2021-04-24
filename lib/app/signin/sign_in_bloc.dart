import 'dart:async';

class SignInBloc {
  final StreamController<bool> _isLoadingController = StreamController<bool>();
  Stream<bool> get isLoadingStream => _isLoadingController.stream;

  void dispose() {
    _isLoadingController.close();
  }

  //provide method to add in sink
  void setIsLoading(bool isLoading) {
    _isLoadingController.add(isLoading);
  }
}
