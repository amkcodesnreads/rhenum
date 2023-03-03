import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'bp_item.dart';

class BpCard extends StatelessWidget {
  List<BpItem> bpLogs = [];

  final BpItem bpLog;
  BpCard(this.bpLog, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card();
  }
}
