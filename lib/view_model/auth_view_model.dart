import 'package:flutter/material.dart';
import 'package:flutter_application/models/user.dart';
import 'package:flutter_application/services/api_status.dart';
import 'package:flutter_application/services/auth_services.dart';
import 'package:flutter_application/utils/entityError.dart';

class AuthViewModel extends ChangeNotifier {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _rememberPassword = false;
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  bool get rememberPassword => _rememberPassword;
  GlobalKey<FormState> get formKey => _formKey;
  bool _loading = false;
  EntityError? _authError;
  UserModel _userModel = UserModel();

  bool get loading => _loading;
  EntityError? get authError => _authError;
  UserModel get userModel => _userModel;

  setLoading(bool loading) async {
    _loading = loading;
  }

  setAuthError(EntityError authError) {
    _authError = authError;
  }

  void setFullName(String fullName) {
    _userModel.fullname = fullName;
  }

  void setEmail(String email) {
    _userModel.email = email;
  }

  void setPassword(String pass) {
    _userModel.password = pass;
  }

  void toggleRememberPassword(bool? value) {
    _rememberPassword = !_rememberPassword;
  }

  setAuthenticated(bool isAuthenticated) {
    _isAuthenticated = isAuthenticated;
  }

  setUserModel(UserModel userModel) {
    _userModel = userModel;
  }

  Future<void> signUp(UserModel user) async {
    setLoading(true);

    var response = await AuthService.signUp(user);

    if (response is Success) {
      setUserModel(response.response as UserModel);
    } else if (response is Failure) {
      EntityError authError = EntityError(
          code: response.code, message: response.errorResponse.toString());
    }

    setLoading(false);
  }

  Future<void> signIn(UserModel user) async {
    setLoading(true);

    var response = await AuthService.signIn(_userModel);
    setAuthenticated(true);

    print(response);
    if (response is Success) {
      setUserModel(response.response as UserModel);
    } else if (response is Failure) {
      EntityError authError = EntityError(
          code: response.code, message: response.errorResponse.toString());
    }

    setLoading(false);
  }

  void logout() {
    _isAuthenticated = false;
    notifyListeners();
  }
}
