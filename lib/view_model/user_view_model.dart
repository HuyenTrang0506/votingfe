import 'package:flutter/material.dart';
import 'package:flutter_application/utils/entityError.dart';
import 'package:flutter_application/models/user.dart';
import 'package:flutter_application/services/api_status.dart';
import 'package:flutter_application/services/user_services.dart';

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

}
