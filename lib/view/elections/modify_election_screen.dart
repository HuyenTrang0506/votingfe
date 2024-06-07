import 'package:flutter/material.dart';
import 'package:flutter_application/components/date_time_picker.dart';
import 'package:flutter_application/utils/alert_dialogs.dart';
import 'package:flutter_application/view_model/auth_view_model.dart';
import 'package:flutter_application/view_model/election_view_model.dart';
import 'package:provider/provider.dart';
import '../../models/election.dart';

class ModifyPollScreen extends StatefulWidget {
  @override
  _ModifyPollScreenState createState() => _ModifyPollScreenState();
}

class _ModifyPollScreenState extends State<ModifyPollScreen> {
  final _formKey = GlobalKey<FormState>();
  ElectionModel election = ElectionModel(listCandidates: []);
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime _startDate = DateTime.now();
  TimeOfDay _startTime = TimeOfDay.now();
  DateTime _endDate = DateTime.now();
  TimeOfDay _endTime = TimeOfDay.now();

  String? get accessToken =>
      context.read<AuthViewModel>().userModel.accessToken;

  @override
  void initState() {
    super.initState();
    election = context.read<ElectionViewModel>().selectedElection;
    titleController.text = election.title!;
    descriptionController.text = election.description!;
    _startDate = election.startTime!;
    _endDate = election.endTime!;
    _startTime = TimeOfDay.fromDateTime(election.startTime!);
    _endTime = TimeOfDay.fromDateTime(election.endTime!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Modify Election")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(labelText: "Title"),
                onSaved: (value) => election.title = value,
                validator: (value) =>
                    value!.isEmpty ? "Please enter a title" : null,
              ),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: "Description"),
                onSaved: (value) => election.description = value,
              ),
              _buildStartDate(),
              _buildEndDate(),
              ...election.listCandidates!.map((candidate) {
                int index = election.listCandidates!.indexOf(candidate);
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: candidate.name,
                          decoration:
                              InputDecoration(labelText: "Candidate Name"),
                          onChanged: (value) =>
                              election.listCandidates![index].name = value,
                        ),
                        TextFormField(
                          initialValue: candidate.description,
                          decoration: InputDecoration(labelText: "Description"),
                          onChanged: (value) =>
                              election.listCandidates![index].description =
                                  value,
                        ),
                        TextFormField(
                          initialValue: candidate.imageUrl,
                          decoration: InputDecoration(labelText: "Image URL"),
                          onChanged: (value) =>
                              election.listCandidates![index].imageUrl = value,
                        ),
                        TextFormField(
                          initialValue: candidate.contactInformation,
                          decoration: InputDecoration(
                              labelText: "Contact Information"),
                          onChanged: (value) =>
                              election.listCandidates![index]
                                  .contactInformation = value,
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              election.listCandidates!.removeAt(index);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
              ElevatedButton(
                onPressed: _addCandidate,
                child: Text("Add Candidate"),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFF416FDF)),
                ),
                onPressed: () => _submitForm(context),
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStartDate() {
    return DateTimePicker(
      labelText: 'Start',
      selectedDate: _startDate,
      selectedTime: _startTime,
      onSelectedDate: (date) => setState(() => _startDate = date),
      onSelectedTime: (time) => setState(() => _startTime = time),
    );
  }

  Widget _buildEndDate() {
    return DateTimePicker(
      labelText: 'End',
      selectedDate: _endDate,
      selectedTime: _endTime,
      onSelectedDate: (date) => setState(() => _endDate = date),
      onSelectedTime: (time) => setState(() => _endTime = time),
    );
  }

  void _addCandidate() {
    setState(() {
      election.listCandidates!.add(ListCandidate());
    });
  }

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      election.title = titleController.text;
      election.description = descriptionController.text;
      election.startTime = DateTime(
        _startDate.year,
        _startDate.month,
        _startDate.day,
        _startTime.hour,
        _startTime.minute,
      );
      election.endTime = DateTime(
        _endDate.year,
        _endDate.month,
        _endDate.day,
        _endTime.hour,
        _endTime.minute,
      );
      bool isSuccess =
          await Provider.of<ElectionViewModel>(context, listen: false)
              .saveElection(accessToken!, election);
      if (isSuccess) {
        showAlertDialog(
                context: context,
                title: 'Success',
                content: 'Modify Election Successfully',
                defaultActionText: 'OK')
            .then((_) {
          Navigator.pop(context);
        });
      }
    }
  }
}