import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'bp_item.dart';

class BP extends StatefulWidget {
  const BP({Key? key}) : super(key: key);

  @override
  State<BP> createState() => _BPState();
}

class _BPState extends State<BP> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime date = DateTime.now();
  TextEditingController diastolicController = TextEditingController();
  TextEditingController systolicController = TextEditingController();

  double _getDrawerWidth() {
    double width = MediaQuery.of(context).size.width * 3 / 4;
    if (width > 280) {
      return 280;
    } else {
      return width;
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
        title: const Text('Blood Pressure'),
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
        width: _getDrawerWidth(),
        child: Drawer(
          child: Column(
            children: <Widget>[],
          ),
        ),
      ),
      body: Center(child: Text('BP')),
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
            child: Container(
              height: currentHeight * 0.4,
              width: currentWidth > 280 ? 400 : currentWidth * 0.9,
              child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: ,
                    children: [
                      const Text(
                        "New Blood Pressure Record",
                      ),
                      const Text("Date"),
                      const TextField(),
                      const TextField(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text("OK"),
                          )
                        ],
                      ),
                    ],
                  )),
            ));
      },
    );
  }
}
