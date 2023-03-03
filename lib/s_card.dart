import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 's_item.dart';

class SCard extends StatelessWidget {
  final SItem bpLog;
  SCard(this.bpLog, {Key? key}) : super(key: key);
  List<SItem> bpLogs = [];

  @override
  Widget build(BuildContext context) {
    return Card();
  }
}
