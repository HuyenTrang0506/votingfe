import 'package:flutter/material.dart';
import 'package:flutter_application/components/app_error.dart';
import 'package:flutter_application/components/app_loading.dart';
import 'package:flutter_application/components/election_list_row.dart';
import 'package:flutter_application/models/election.dart';
import 'package:flutter_application/view_model/auth_view_model.dart';
import 'package:flutter_application/view_model/election_view_model.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      String? accessToken = Provider.of<AuthViewModel>(context, listen: false)
          .userModel
          .accessToken;
      if (accessToken != null) {
        Provider.of<ElectionViewModel>(context, listen: false)
            .getElections(accessToken);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ElectionViewModel electionsViewModel = context.watch<ElectionViewModel>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('History'),
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
          ElectionModel electionModel =
              electionsViewModel.electionListModel[index];
          if (DateTime.now().isAfter(electionModel.endTime!)) {
            return ElectionListRow(
              election: electionModel,
              currentUser: context.read<AuthViewModel>().userModel,
              onTap: () {},
              onDelete: () {},
            );
          } else {
            return Container();
          }
        },
        separatorBuilder: (context, index) => Divider(),
        itemCount: electionsViewModel.electionListModel.length,
      ),
    );
  }
}
