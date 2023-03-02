import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'BPScreen.dart';
import 'Sscreen.dart';

void main() async => runApp(const Rhenum());

class Rhenum extends StatefulWidget {
  const Rhenum({Key? key}) : super(key: key);

  @override
  State<Rhenum> createState() => _Rhenum();
}

class _Rhenum extends State<Rhenum> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        useMaterial3: true,
        textTheme: GoogleFonts.robotoTextTheme().copyWith(
          headline4: const TextStyle(color: Color(0xFFc4c7c5)),
          headline3: const TextStyle(color: Color(0xFFc4c7c5)),
          // bodyMedium: const TextStyle(color: Color(0xFFc4c7c5))
        ),
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
        body: [
          const BP(),
          const Sugar(),
        ][currentPageIndex],
        drawer: SizedBox(
          width: 280,
          child: Drawer(
            child: Column(
              children: <Widget>[],
            ),
          ),
        ),
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
      ),
    );
  }
}
