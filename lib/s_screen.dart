import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:intl/intl.dart" show DateFormat;

import 's_item.dart';
import 'dart:math';

class Sugar extends StatefulWidget {
  const Sugar({Key? key}) : super(key: key);

  @override
  State<Sugar> createState() => _SugarState();
}

class _SugarState extends State<Sugar> {
  List<SItem> sugarItems = [];

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;

    return
        // key: scaffoldKey,
        // appBar: AppBar(
        //   systemOverlayStyle: const SystemUiOverlayStyle(
        //     statusBarColor: Colors.transparent,
        //   ),
        //   title: const Text('Sugar'),
        //   titleSpacing: 24,
        //   leading: IconButton(
        //     onPressed: () {
        //       scaffoldKey.currentState?.openDrawer();
        //     },
        //     icon: const Icon(Icons.more_vert),
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
          children: sugarItems.reversed.map((sLog) => SCard(sLog)).toList(),
        ),
      ),
    );
    // floatingActionButton: currentHeight < 500
    //     ? FloatingActionButton(
    //         onPressed: () async {
    //           _showDialog();
    //         },
    //         shape: RoundedRectangleBorder(
    //             borderRadius: BorderRadius.circular(20.0)),
    //         child: const Icon(Icons.add),
    //       )
    //     : FloatingActionButton.large(
    //         onPressed: () async {
    //           _showDialog();
    //         },
    //         shape: RoundedRectangleBorder(
    //             borderRadius: BorderRadius.circular(20.0)),
    //         child: const Icon(Icons.add),
    //       ),
    // floatingActionButtonLocation: currentWidth < 500
    //     ? FloatingActionButtonLocation.centerFloat
    //     : FloatingActionButtonLocation.endFloat,
  }
}

class SCard extends StatelessWidget {
  List<SItem> sLogs = [];

  final SItem sLog;
  SCard(this.sLog, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.lerp(
        const Color.fromARGB(207, 138, 189, 142),
        const Color.fromARGB(205, 235, 141, 142),
        weigh(sLog),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
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
                    DateFormat("d/M/yy").format(sLog.date),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    style: Theme.of(context).textTheme.labelLarge,
                    DateFormat("hh:mm a").format(sLog.date),
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
                  sLog.sugar != null
                      ? Text(
                          "${sLog.sugar}",
                          style: Theme.of(context).textTheme.titleLarge,
                        )
                      : Container()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const SUG_MIN = 30;
const SUG_LG = 70;
const SUG_HG = 150;
const SUG_MAX = 380;
double weigh(SItem sLog) {
  double sugar = 0;
  if (sLog.sugar != null) {
    if (sLog.sugar! < SUG_LG) {
      sugar = (SUG_LG - sLog.sugar!) / (SUG_LG - SUG_MIN);
    } else if (sLog.sugar! > SUG_HG) {
      sugar = (sLog.sugar! - SUG_HG) / (SUG_MAX - SUG_HG);
    }
  }
  0;
  return [sugar].reduce(max);
}
