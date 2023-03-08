import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'bp_screen.dart';
import 's_screen.dart';
import "package:intl/intl.dart" show DateFormat;

import 'bp_item.dart';
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

  Future<void> _selectDate(BuildContext context) async {
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
      theme: ThemeData(
          colorSchemeSeed: Colors.blue,
          brightness: Brightness.light,
          useMaterial3: true,
          textTheme: GoogleFonts.openSansTextTheme().copyWith()),
      darkTheme: ThemeData(
          colorSchemeSeed: Colors.blue,
          brightness: Brightness.dark,
          useMaterial3: true,
          textTheme: GoogleFonts.openSansTextTheme()),
      // theme: ThemeData(
      //   useMaterial3: true,
      //   brightness: Brightness.dark,
      //   // colorSchemeSeed: const Color(0xFF2d2e32),
      //   // textTheme: GoogleFonts.openSansTextTheme().copyWith(
      //   //     displaySmall: const TextStyle(color: Color(0xFFc4c7c5), fontWeight: FontWeight.w400),
      //   //     labelLarge: const TextStyle(color: Color(0xFFc4c7c5))
      //   // ),
      //
      //
      //
      //   // labelLarge : const TextStyle(
      //   //   color: Color(0xFFc4c7c5),
      //   // ),
      //   scaffoldBackgroundColor: const Color(0xFF1f1f1f),
      //   appBarTheme: AppBarTheme(
      //     backgroundColor: const Color(0xFF1f1f1f),
      //     titleTextStyle: GoogleFonts.openSans(
      //       color: const Color(0xFFc4c7c5),
      //       fontWeight: FontWeight.w400,
      //       fontSize: 23,
      //     ),
      //   ),
      //   navigationBarTheme: NavigationBarThemeData(
      //     // foregroundColor: const Color(0xFFc5c7c4),
      //     backgroundColor: const Color(0xFF2d2e32),
      //     indicatorColor: const Color(0xFF004a77),
      //     // iconTheme: IconThemeData(color: Colour(0xFFc5c7c4)),
      //     labelTextStyle: MaterialStateProperty.all(
      //       GoogleFonts.openSans(
      //         fontSize: 13,
      //         color: const Color(0xFFc4c7c5),
      //         fontWeight: FontWeight.w500,
      //       ),
      //     ),
      //   ),
      //   floatingActionButtonTheme: const FloatingActionButtonThemeData(
      //     backgroundColor: Color(0xFFa8c8fb),
      //     foregroundColor: Color(0xFF043445),
      //   ),
      //   scrollbarTheme: ScrollbarThemeData(
      //     thumbColor: MaterialStateProperty.all(const Color(0xFF2d2f33)),
      //     // isAlwaysShown: true,
      //   ),
      // ),
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
              // color: Color(0xFFc5c7c4),
            ),
          ),
        ),
        drawer: SizedBox(
          width: MediaQuery.of(context).size.width * 3 / 4 > 280
              ? 280
              : MediaQuery.of(context).size.width * 3 / 4,
          child: Drawer(
            child: Column(
              children: <Widget>[
                SizedBox(
                  // Use drawer width to determine drawer header size
                  height: MediaQuery.of(context).size.width * 3 / 4 > 280
                      ? 280 * 1.1
                      : MediaQuery.of(context).size.width * 3 / 4 * 1.1,
                  child: DrawerHeader(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Profile picture of user
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.width * 3 / 4 >
                                    280
                                ? 280 / 2
                                : MediaQuery.of(context).size.width * 3 / 4 / 2,
                            width: MediaQuery.of(context).size.width * 3 / 4 >
                                    280
                                ? 280 / 2
                                : MediaQuery.of(context).size.width * 3 / 4 / 2,
                            child: const FlutterLogo(
                              // size: 300,
                              // textColor: Colors.green,
                              style: FlutterLogoStyle.stacked,
                            ),
                          ),
                        ),
                        // Name of user
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "Aadarsh",
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ),
                        // Email ID of user
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "aadarshmadankollan@gmail.com",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                // For logging out
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text("Log out"),
                  onTap: () async {},
                ),
                // For showing the log file
                ListTile(
                  leading: const Icon(Icons.insert_drive_file_outlined),
                  title: const Text("Access file"),
                  onTap: () async {},
                ),
                // For opening the support page
                ListTile(
                    leading: const Icon(Icons.contact_support_outlined),
                    title: const Text("Get support"),
                    onTap: () async {}),
              ],
            ),
          ),
        ),
        floatingActionButton: currentHeight < 500
            ? FloatingActionButton(
                onPressed: () async {
                  currentPageIndex == 0
                      ? showDialog(context: context, builder: (BuildContext context) => bpDialog())
                      : showDialog(context: context, builder: (BuildContext context) => sDialog());
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: const Icon(Icons.add),
              )
            : FloatingActionButton.large(
                onPressed: () async {
                  currentPageIndex == 0
                      ? showDialog(context: context, builder: (BuildContext context) => bpDialog())
                      : showDialog(context: context, builder: (BuildContext context) => sDialog());
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: const Icon(Icons.add),
              ),
        floatingActionButtonLocation: currentWidth < 500
            ? FloatingActionButtonLocation.centerFloat
            : FloatingActionButtonLocation.endFloat,
      ),
    );
  }

  Widget sDialog() {
        // return object of type Dialog
        return AlertDialog(
            // backgroundColor: const Color(0xFF323337),
            title: Text("New Sugar Record",
                style: Theme.of(context).textTheme.labelLarge),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    sugarController.clear();
                  },
                  child: Text(
                    'Cancel',
                    // style: GoogleFonts.openSans(
                    // textStyle: const TextStyle(color: Color(0xFFa8c8fb))
                  )),
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
                    sugarController.clear();
                  },
                  child: Text(
                    'OK',
                    // style: GoogleFonts.openSans(
                    // textStyle: const TextStyle(color: Color(0xFFa8c8fb))
                    // ),
                  ))
            ],
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 24.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(DateFormat("d/M/y").format(date),
                                    // style: GoogleFonts.openSans(
                                    //     // textStyle: const TextStyle(color: Color(0xFFc4c7c5), fontSize: 48, fontWeight: FontWeight.w400)
                                    // )
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall),
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit),
                                iconSize: 30.0,
                                tooltip: "Edit date",
                                // color: const Color(0xFFc4c7c5),
                                onPressed: () async =>
                                    await _selectDate(context),
                              ),
                            ],
                          ),
                        ),
                        TextFormField(
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
                            filled: true,
                            // fillColor: Color(0xFF454746),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                // color: Color(0xFFc4c7c5),
                                width: 0.0,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),

                            hintText: 'Sugar (in Hz)',
                            // hintStyle: TextStyle(color: Color(0xFFc4c7c5))
                          ),
                        ),
                        // Padding(
                        //     padding: const EdgeInsets.all(16),
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.end,
                        //       children: [
                        //         TextButton(
                        //             onPressed: () {
                        //               Navigator.of(context).pop();
                        //             },
                        //             child: Text('Cancel')),
                        //         TextButton(
                        //             onPressed: () {
                        //               if (formKey.currentState != null &&
                        //                   formKey.currentState!.validate()) {
                        //                 Navigator.of(context).pop(SItem(
                        //                   int.parse(sugarController.text),
                        //                   date: date,
                        //                 ));
                        //                 setState(() => sugarItems.add(SItem(
                        //                       int.parse(sugarController.text),
                        //                     )));
                        //               }
                        //             },
                        //             child: Text('OK'))
                        //       ],
                        //     ))
                      ],
                    ),
                  ),
                ],
              ),
            ));
  }

  Widget bpDialog() {
        return AlertDialog(
            // backgroundColor: const Color(0xFF323337),
            title: Text("New BP Record",
                // style: TextStyle(color: Color(0xFFc4c7c5), fontSize: 13)
                style: Theme.of(context).textTheme.labelLarge),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    systolicController.clear();
                    diastolicController.clear();
                  },
                  child: Text(
                    'Cancel',
                    // style: GoogleFonts.openSans(
                    // textStyle: const TextStyle(color: Color(0xFFa8c8fb))
                    // )
                  )),
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
                          int.parse(systolicController.text),
                          int.parse(diastolicController.text),
                          date)));
                    }
                    systolicController.clear();
                    diastolicController.clear();
                  },
                  child: Text(
                    'OK',
                    // style: GoogleFonts.openSans(
                    // textStyle: const TextStyle(color: Color(0xFFa8c8fb))
                    // ),
                  )),
            ],
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 24.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(DateFormat("d/M/y").format(date),
                                    // style: GoogleFonts.openSans(
                                    //     // textStyle: const TextStyle(color: Color(0xFFc4c7c5), fontSize: 48, fontWeight: FontWeight.w400)
                                    // )
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall),
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit),
                                iconSize: 30.0,
                                tooltip: "Edit date",
                                // color: const Color(0xFFc4c7c5),
                                onPressed: () => _selectDate(context),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
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
                              filled: true,
                              // fillColor: Color(0xFF454746),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 3, color: Colors.white),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              hintText: 'Systolic (in mmHg)',
                              // hintStyle: TextStyle(color: Color(0xFFc4c7c5))
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
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
                              filled: true,
                              // fillColor: Color(0xFF454746),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFc4c7c5),
                                  width: 2.0,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              hintText: 'Diastolic (in mmHg)',
                              // hintStyle: TextStyle(color: Color(0xFFc4c7c5))
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
  }
}
