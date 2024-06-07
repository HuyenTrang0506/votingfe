import 'package:flutter/material.dart';
import 'package:flutter_application/models/election.dart';

class ElectionListRow extends StatelessWidget {
  final ElectionModel election;
  final Function onTap;

  ElectionListRow({required this.election, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap as void Function()?,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(election.title ?? '', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text('Start: ${election.startTime}'),
              Text('End: ${election.endTime}'),
            ],
          ),
          _buildState(election),
        ],
      ),
    );
  }

  Widget _buildState(ElectionModel election) {
    final now = DateTime.now();
    String state;
    Color color;

    if (election.startTime != null && election.endTime != null) {
      if (now.isBefore(election.startTime!)) {
        state = 'Have taken';
        color = Colors.blue;
      } else if (now.isAfter(election.endTime!)) {
        state = 'Overdue';
        color = Colors.red;
      } else {
        state = 'On going';
        color = Colors.green;
      }
    } else {
      state = 'Unknown';
      color = Colors.grey;
    }

    return Text(state, style: TextStyle(color: color));
  }
}