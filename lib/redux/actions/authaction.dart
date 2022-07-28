part of 'actions.dart';

class SignInAction {
  final String? email;
  final String? password;

  SignInAction({this.email, this.password});
}

class ClearSignInAction {}

class SignUpAction {
  final String? name;
  final String? email;
  final String? password;

  SignUpAction({this.name, this.email, this.password});
}

class ClearSignUpAction {}
