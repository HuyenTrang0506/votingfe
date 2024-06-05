import 'package:flutter/material.dart';
import 'package:flutter_application/models/userError.dart';
import 'package:flutter_application/models/user.dart';
import 'package:flutter_application/services/api_status.dart';
import 'package:flutter_application/services/user_services.dart';

import '../models/user.dart';

class UsersViewModel extends ChangeNotifier {
  
  bool _loading = false;
  UserError? _userError;

  bool get loading => _loading;
  List<UserModel> _userListModel = [];
  List<UserModel> get userListModel => _userListModel;
  UserError? get userError => _userError;
  setLoading(bool loading)async{
    _loading = loading;
    //dont need call notifyListeners() everytime because when we set value of loading to false, it will update all the value of this object
    notifyListeners();
  }
  setUserListModel(List<UserModel> userListModel){
    _userListModel = userListModel;
   
  }
  setUserError(UserError userError){
    _userError = userError;
  
  }
   Future<void> getUsers() async {
    setLoading(true);
    var response = await UserServices.getUsers();
    if (response is Success) {
     setUserListModel(response.response as List<UserModel>);
    } else if (response is Failure) {
      UserError userError = UserError(code: response.code, message: response.errorResponse.toString());
    }
  }
  
  @override
  void dispose() {
    super.dispose();
  }
}