import 'package:flutter/material.dart';
import 'package:flutter_application/utils/entityError.dart';
import 'package:flutter_application/models/election.dart';
import 'package:flutter_application/services/api_status.dart';
import 'package:flutter_application/services/election_services.dart';

class ElectionViewModel extends ChangeNotifier {
  bool _loading = false;
  EntityError? _electionError;

  bool get loading => _loading;
  List<ElectionModel> _electionListModel = [];
  ElectionModel _selectedElection = ElectionModel();
  ElectionModel _addingElection = ElectionModel();

  //getter
  List<ElectionModel> get electionListModel => _electionListModel;
  EntityError? get electionError => _electionError;
  ElectionModel get selectedElection => _selectedElection;
  ElectionModel get addingElection => _addingElection;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setElectionListModel(List<ElectionModel> electionListModel) {
    _electionListModel = electionListModel;
  }

  setElectionError(EntityError electionError) {
    _electionError = electionError;
  }

  setSelectedElection(ElectionModel electionModel) {
    _selectedElection = electionModel;
  }

  addElection() async {
    if (!isValid()) {
      return;
    }
    _electionListModel.add(addingElection);
    _addingElection = ElectionModel();
    notifyListeners();
    return true;
  }

  isValid() {
    if (addingElection.title == null || addingElection.title!.isEmpty) {
      return false;
    }
    return true;
  }

  Future<void> getElections(String accessToken) async {
    setLoading(true);

    var response = await ElectionServices.getElections(accessToken);

    if (response is Success) {
      setElectionListModel(response.response as List<ElectionModel>);
    } else if (response is Failure) {
      EntityError electionError = EntityError(
          code: response.code, message: response.errorResponse.toString());
      setElectionError(electionError);
    }
    setLoading(false);
  }
}