import 'package:flutter/material.dart';
import 'package:flutter_application/components/app_error.dart';
import 'package:flutter_application/components/app_loading.dart';
import 'package:flutter_application/components/election_list_row.dart';
import 'package:flutter_application/components/user_list_row.dart';
import 'package:flutter_application/models/election.dart';
import 'package:flutter_application/models/user.dart';
import 'package:flutter_application/view/users/user_details_screen.dart';
import 'package:flutter_application/view_model/auth_view_model.dart';
import 'package:flutter_application/view_model/election_view_model.dart';
import 'package:flutter_application/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class ElectionScreen extends StatefulWidget {
  @override
  _ElectionScreenState createState() => _ElectionScreenState();
}

class _ElectionScreenState extends State<ElectionScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      String? accessToken = Provider.of<AuthViewModel>(context, listen: false)
          .userModel
          .accessToken;
      if (accessToken != null) {
        Provider.of<ElectionViewModel>(context, listen: false)
            .getElections(accessToken); // Adjusted to use Provider for consistency
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ElectionViewModel electionsViewModel = context.watch<ElectionViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('List Elections'),
        actions: [
          IconButton(
            onPressed: () async {
              electionsViewModel.setSelectedElection(new ElectionModel());
              Navigator.pushNamed(context, '/createElection');
            },
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: () async {
              String? accessToken =
                  context.read<AuthViewModel>().userModel.accessToken;
              if (accessToken != null) {
                electionsViewModel.getElections(accessToken);
              }
            },
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _ui(electionsViewModel),
          ],
        ),
      ),
    );
  }

  _ui(ElectionViewModel electionsViewModel) {
    if (electionsViewModel.loading) {
      return AppLoading();
    }
    if (electionsViewModel.electionError != null) {
      return AppError(
        errortxt: electionsViewModel.electionError?.message,
      );
    }
    return Expanded(
      child: ListView.separated(
        itemBuilder: (context, index) {
          ElectionModel electionModel = electionsViewModel.electionListModel[index];

          return ElectionListRow(
            election: electionModel,
            onTap: () async {
              electionsViewModel.setSelectedElection(electionModel);
              // openUserDetails(context);
              Navigator.pushNamed(context, '/modifyElection');
            },currentUser: context.read<AuthViewModel>().userModel,
            onDelete: () async {
              String? accessToken =
                  context.read<AuthViewModel>().userModel.accessToken;
              if (accessToken != null) {
                
                electionsViewModel.deleteElection(
                    accessToken, electionModel.id.toString());
              }
            },
          );
        },
        separatorBuilder: (context, index) => Divider(),
        itemCount: electionsViewModel.electionListModel.length,
      ),
    );
  }

  
}
