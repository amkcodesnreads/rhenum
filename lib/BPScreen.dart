import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BP extends StatefulWidget {
  const BP({Key? key}) : super(key: key);

  @override
  State<BP> createState() => _BPState();
}

class _BPState extends State<BP> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

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
              onPressed: () async {},
              shape: const CircleBorder(),
              child: const Icon(Icons.add),
            )
          : FloatingActionButton.large(
              onPressed: () async {},
              shape: const CircleBorder(),
              child: const Icon(Icons.add),
            ),
      floatingActionButtonLocation: currentWidth < 450
          ? FloatingActionButtonLocation.centerFloat
          : FloatingActionButtonLocation.endFloat,
    );
  }
}
