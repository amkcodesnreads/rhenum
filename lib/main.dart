import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'bp_screen.dart';
import 's_screen.dart';
import "package:intl/intl.dart" show DateFormat;

import 'bp_item.dart';
import 'dart:math';
import 's_item.dart';

void main() async => runApp(const MaterialApp(home: Rhenum()));

class Rhenum extends StatefulWidget {
  const Rhenum({Key? key}) : super(key: key);

  @override
  State<Rhenum> createState() => _Rhenum();
}

class _Rhenum extends State<Rhenum> {
  List<BpItem> bpItems = [];
  List<SItem> sugarItems = [];
  final formKey = GlobalKey<FormState>();
  int currentPageIndex = 0;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime date = DateTime.now();
  TextEditingController sugarController = TextEditingController();
  TextEditingController diastolicController = TextEditingController();
  TextEditingController systolicController = TextEditingController();

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
    late double currentWidth = MediaQuery.of(context).size.width;
    late double currentHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        useMaterial3: true,
        textTheme: GoogleFonts.openSansTextTheme().copyWith(
            displayMedium: const TextStyle(
                color: Color(0xFFc4c7c5), fontWeight: FontWeight.w400)),
        // labelLarge : const TextStyle(
        //   color: Color(0xFFc4c7c5),
        // ),
        scaffoldBackgroundColor: const Color(0xFF1f1f1f),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFF1f1f1f),
          titleTextStyle: GoogleFonts.openSans(
            color: const Color(0xFFc4c7c5),
            fontWeight: FontWeight.w400,
            fontSize: 23,
          ),
        ),
        navigationBarTheme: NavigationBarThemeData(
          // foregroundColor: const Color(0xFFc5c7c4),
          backgroundColor: const Color(0xFF2d2e32),
          indicatorColor: const Color(0xFF004a77),
          // iconTheme: IconThemeData(color: Colour(0xFFc5c7c4)),
          labelTextStyle: MaterialStateProperty.all(
            GoogleFonts.openSans(
              fontSize: 13,
              color: Color(0xFFc4c7c5),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFa8c8fb),
          foregroundColor: Color(0xFF043445),
        ),
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: MaterialStateProperty.all(const Color(0xFF2d2f33)),
          // isAlwaysShown: true,
        ),
      ),
      home: Scaffold(
        key: scaffoldKey,
        body: [
          const BP(),
          const Sugar(),
        ][currentPageIndex],
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) =>
              setState(() => currentPageIndex = index),
          selectedIndex: currentPageIndex,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.monitor_heart, color: Color(0xFFc5c7c4)),
              label: 'Blood Pressure',
            ),
            NavigationDestination(
              icon: Icon(Icons.water_drop, color: Color(0xFFc5c7c4)),
              label: 'Sugar',
            ),
          ],
        ),
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          ),
          title: Text(currentPageIndex == 0 ? "Blood Pressure" : "Sugar"),
          titleSpacing: 24,
          leading: IconButton(
            onPressed: () {
              scaffoldKey.currentState?.openDrawer();
            },
            icon: const Icon(
              Icons.more_vert,
              color: Color(0xFFc5c7c4),
            ),
          ),
        ),
        drawer: SizedBox(
          width: MediaQuery.of(context).size.width * 3 / 4 > 280
              ? 280
              : MediaQuery.of(context).size.width * 3 / 4,
          child: Drawer(
            child: Column(
              children: <Widget>[],
            ),
          ),
        ),
        floatingActionButton: currentHeight < 500
            ? FloatingActionButton(
                onPressed: () async {
                  currentPageIndex == 0 ? _showBPDialog() : _showSDialog();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0)),
                child: const Icon(Icons.add),
              )
            : FloatingActionButton.large(
                onPressed: () async {
                  currentPageIndex == 0 ? _showBPDialog() : _showSDialog();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0)),
                child: const Icon(Icons.add),
              ),
        floatingActionButtonLocation: currentWidth < 500
            ? FloatingActionButtonLocation.centerFloat
            : FloatingActionButtonLocation.endFloat,
      ),
    );
  }

  void _showSDialog() {
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

  _showBPDialog() {
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
                  // height: currentHeight * 0.4,
                  width: currentWidth > 280 ? 420 : currentWidth * 0.96,
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
                              controller: systolicController,
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
                                hintText: 'Systolic (in mmHg)',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: TextFormField(
                              validator: (value) => value == null || value == ""
                                  ? "Enter a value"
                                  : null,
                              controller: diastolicController,
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
                                hintText: 'Diastolic (in mmHg)',
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
                                          Navigator.of(context).pop(BpItem(
                                            int.parse(systolicController.text),
                                            int.parse(diastolicController.text),
                                            date,
                                          ));
                                          setState(() => bpItems.add(BpItem(
                                              int.parse(
                                                  systolicController.text),
                                              int.parse(
                                                  diastolicController.text),
                                              date)));
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
