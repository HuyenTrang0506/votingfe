import 'package:flutter/material.dart';
import 'package:flutter_application/models/user.dart';
import 'package:flutter_application/services/api_status.dart';
import 'package:flutter_application/services/user_services.dart';
import 'package:flutter_application/utils/entityError.dart';
import 'package:flutter_application/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class UsersViewModel extends ChangeNotifier {
  bool _loading = false;
  EntityError? _userError;

  bool get loading => _loading;
  List<UserModel> _userListModel = [];
  UserModel _selectedUser = UserModel();
  UserModel _addingUser = UserModel();

  //getter
  List<UserModel> get userListModel => _userListModel;
  EntityError? get userError => _userError;
  UserModel get selectedUser => _selectedUser;
  UserModel get addingUser => _addingUser;
  setLoading(bool loading) async {
    _loading = loading;
    //dont need call notifyListeners() everytime because when we set value of loading to false, it will update all the value of this object
    notifyListeners();
  }

  setUserListModel(List<UserModel> userListModel) {
    _userListModel = userListModel;
  }

  setUserError(EntityError userError) {
    _userError = userError;
  }

  setSelectedUser(UserModel userModel) {
    _selectedUser = userModel;
  }

  addUser() async {
    if (!isValid()) {
      return;
    }
    _userListModel.add(addingUser);
    _addingUser = UserModel();
    notifyListeners();
    return true;
  }

  isValid() {
    if (addingUser.fullname == null || addingUser.fullname!.isEmpty) {
      return false;
    }
    if (addingUser.email == null || addingUser.email!.isEmpty) {
      return false;
    }
    return true;
  }

  Future<void> getUsers(String accessToken) async {
    setLoading(true);

    var response = await UserServices.getUsers(accessToken);

    if (response is Success) {
      setUserListModel(response.response as List<UserModel>);
    } else if (response is Failure) {
      print("ngu");
      EntityError userError = EntityError(
          code: response.code, message: response.errorResponse.toString());
    }
    setLoading(false);
  }

  Future<void> deleteUser(String accessToken, String userId) async {
    setLoading(true);

    var response = await UserServices.deleteUser(accessToken, userId);

    if (response is Success) {
      _userListModel.removeWhere((user) => user.id.toString() == userId);
      notifyListeners();
    } else if (response is Failure) {
      print("Failed to delete user");
      EntityError userError = EntityError(
          code: response.code, message: response.errorResponse.toString());
      setUserError(userError);
    }

    setLoading(false);
  }

  Future<void> changePro(String accessToken, String userId) async {
    setLoading(true);
    var response = await UserServices.changePro(accessToken, userId);
    if (response is Success) {
      UserModel updatedUser = response.response as UserModel;
      int index =
          _userListModel.indexWhere((user) => user.id.toString() == userId);
      if (index != -1) {
        _userListModel[index] = updatedUser;
      }
      
    } else if (response is Failure) {
      EntityError userError = EntityError(
          code: response.code, message: response.errorResponse.toString());
      setUserError(userError);
    }
    setLoading(false);
  }
}
