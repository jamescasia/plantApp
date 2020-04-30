import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plantApp/DataModels/Globals.dart';
import 'package:plantApp/Screens/HomePage.dart';

class PlantApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Lato'),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  double safePadding;
  @override
  Widget build(BuildContext context) {
    Globals.dheight = MediaQuery.of(context).size.height / 793;
    Globals.dwidth = MediaQuery.of(context).size.width / 393;
    Globals.height = MediaQuery.of(context).size.height;
    Globals.width = MediaQuery.of(context).size.width;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Globals.grayHomeBg,
      systemNavigationBarColor: const Color(0xFF1BA977),
      // #61C350
    ));
    return SafeArea(
      child: LayoutBuilder(builder: (context, constraints) {
        safePadding = Globals.height - constraints.maxHeight;
        Globals.height = constraints.maxHeight;
        Globals.width = constraints.maxWidth;

        return Material(
            child: Container(
          color: Colors.red,
        ));
      }),
    );
  }
}
