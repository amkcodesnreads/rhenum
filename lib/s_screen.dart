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
  final formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime date = DateTime.now();
  TextEditingController sugarController = TextEditingController();

  double _getDrawerWidth() {
    double width = MediaQuery.of(context).size.width * 3 / 4;
    if (width > 280) {
      return 280;
    } else {
      return width;
    }
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime.now().subtract(const Duration(days: 7)),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != date) {
      setState(() => date = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        title: const Text('Sugar'),
        titleSpacing: 24,
        leading: IconButton(
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
          icon: const Icon(Icons.more_vert),
        ),
      ),
      drawer: SizedBox(
        width: _getDrawerWidth(),
        child: Drawer(
          child: Column(
            children: <Widget>[],
          ),
        ),
      ),
      body: Center(
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
      ),
      floatingActionButton: currentHeight < 500
          ? FloatingActionButton(
              onPressed: () async {
                _showDialog();
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: const Icon(Icons.add),
            )
          : FloatingActionButton.large(
              onPressed: () async {
                _showDialog();
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: const Icon(Icons.add),
            ),
      floatingActionButtonLocation: currentWidth < 500
          ? FloatingActionButtonLocation.centerFloat
          : FloatingActionButtonLocation.endFloat,
    );
  }

  void _showDialog() {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Dialog(
            backgroundColor: Color(0xFF2d2e32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  // height: currentHeight * 0.35,
                  width: currentWidth > 280 ? 400 : currentWidth * 0.9,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    DateFormat("d/M/y").format(date),
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  iconSize: 30.0,
                                  tooltip: "Edit date",
                                  onPressed: () => _selectDate(context),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: TextFormField(
                              validator: (value) => value == null || value == ""
                                  ? "Enter a value"
                                  : null,
                              controller: sugarController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                hintText: 'Sugar (in Hz)',
                              ),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Cancel')),
                                  TextButton(
                                      onPressed: () {
                                        if (formKey.currentState != null &&
                                            formKey.currentState!.validate()) {
                                          Navigator.of(context).pop(SItem(
                                            int.parse(sugarController.text),
                                            date: date,
                                          ));
                                          setState(() => sugarItems.add(SItem(
                                                int.parse(sugarController.text),
                                              )));
                                        }
                                      },
                                      child: Text('OK'))
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ));
      },
    );
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
