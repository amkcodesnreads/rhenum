import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:intl/intl.dart" show DateFormat;

import 'bp_item.dart';
import 'dart:math';

class BP extends StatefulWidget {
  const BP({Key? key}) : super(key: key);

  @override
  State<BP> createState() => _BPState();
}

class _BPState extends State<BP> {
  List<BpItem> bpItems = [];

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;

    return
        // appBar: AppBar(
        //   systemOverlayStyle: const SystemUiOverlayStyle(
        //     statusBarColor: Colors.transparent,
        //   ),
        //   title: const Text('Blood Pressure'),
        //   titleSpacing: 24,
        //   leading: IconButton(
        //     onPressed: () {
        //       scaffoldKey.currentState?.openDrawer();
        //     },
        //     icon: const Icon(
        //       Icons.more_vert,
        //       color: Color(0xFFc5c7c4),
        //     ),
        //   ),
        // ),
        // drawer: SizedBox(
        //   width: _getDrawerWidth(),
        //   child: Drawer(
        //     child: Column(
        //       children: <Widget>[],
        //     ),
        //   ),
        // ),
        Center(
      child: Scrollbar(
        thickness: 8,
        radius: const Radius.circular(50),
        child: GridView.count(
          // reverse: true,
          padding: const EdgeInsets.all(16),
          crossAxisCount: (currentWidth ~/ 200),
          children: bpItems.reversed.map((bpLog) => BpCard(bpLog)).toList(),
        ),
      ),
    );
    // floatingActionButton: currentHeight < 500
    //     ? FloatingActionButton(
    //         onPressed: () async {
    //           _showDialog();
    //         },
    //         shape: RoundedRectangleBorder(
    //             borderRadius: BorderRadius.circular(25.0)),
    //         child: const Icon(Icons.add),
    //       )
    //     : FloatingActionButton.large(
    //         onPressed: () async {
    //           _showDialog();
    //         },
    //         shape: RoundedRectangleBorder(
    //             borderRadius: BorderRadius.circular(25.0)),
    //         child: const Icon(Icons.add),
    //       ),
    // floatingActionButtonLocation: currentWidth < 500
    //     ? FloatingActionButtonLocation.centerFloat
    //     : FloatingActionButtonLocation.endFloat,
  }
}

class BpCard extends StatelessWidget {
  List<BpItem> bpLogs = [];

  final BpItem bpLog;
  BpCard(this.bpLog, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.lerp(
        const Color.fromARGB(207, 138, 189, 142),
        const Color.fromARGB(205, 235, 141, 142),
        weigh(bpLog),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      style: Theme.of(context).textTheme.displayMedium,
                      DateFormat("d/M/yy").format(bpLog.date),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      style: Theme.of(context).textTheme.labelLarge,
                      DateFormat("hh:mm a").format(bpLog.date),
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    bpLog.systolic != null && bpLog.diastolic != null
                        ? Text(
                            "${bpLog.systolic}/${bpLog.diastolic}",
                            style: Theme.of(context).textTheme.displaySmall,
                          )
                        : Container()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const DIA_MIN = 40;
const DIA_LG = 60;
const DIA_HG = 80;
const DIA_MAX = 120;
const SYS_MIN = 70;
const SYS_LG = 90;
const SYS_HG = 120;
const SYS_MAX = 180;
double weigh(BpItem bpLog) {
  double diastolic = 0;
  if (bpLog.diastolic != null) {
    if (bpLog.diastolic! < DIA_LG) {
      diastolic = (DIA_LG - bpLog.diastolic!) / (DIA_LG - DIA_MIN);
    } else if (bpLog.diastolic! > DIA_HG) {
      diastolic = (bpLog.diastolic! - DIA_HG) / (SYS_MAX - DIA_HG);
    }
  }
  double systolic = 0;
  if (bpLog.systolic != null) {
    if (bpLog.systolic! < SYS_LG) {
      systolic = (SYS_LG - bpLog.systolic!) / (SYS_LG - SYS_MIN);
    } else if (bpLog.systolic! > SYS_HG) {
      systolic = (bpLog.systolic! - SYS_HG) / (SYS_MAX - SYS_HG);
    }
  }
  0;
  return [diastolic, systolic].reduce(max);
}
