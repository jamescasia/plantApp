import 'package:flutter/material.dart';
import 'package:plantApp/DataModels/Globals.dart';
import 'package:plantApp/helpers/scroll_behaviour.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plantApp/Screens/elements/ImageTile.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var images = [
    "assets/images/ampalaya.png",
    "assets/images/hydro.png",
    "assets/images/mango.png",
    "assets/images/papaya.png",
    "assets/images/tomato.png",
    "assets/images/ampalaya.png",
    "assets/images/hydro.png",
    "assets/images/mango.png",
    "assets/images/papaya.png",
    "assets/images/tomato.png",
    "assets/images/ampalaya.png",
    "assets/images/hydro.png",
    "assets/images/mango.png",
    "assets/images/papaya.png",
    "assets/images/tomato.png",
    "assets/images/ampalaya.png",
    "assets/images/hydro.png",
    "assets/images/mango.png",
    "assets/images/papaya.png",
    "assets/images/tomato.png"
  ];
  double safePadding;
  TextEditingController searchController = TextEditingController();
  FocusNode searchFnode = FocusNode();
  @override
  Widget build(BuildContext context) {
    Globals.dheight = MediaQuery.of(context).size.height / 793;
    Globals.dwidth = MediaQuery.of(context).size.width / 393;
    Globals.maxHeight = MediaQuery.of(context).size.height;
    Globals.maxWidth = MediaQuery.of(context).size.width;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Globals.grayHomeBg,
        systemNavigationBarColor: Globals.grayHomeBg
        // #61C350
        ));
    return ScrollConfiguration(
      behavior: CustomScrollBehaviour(),
      child: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          safePadding = Globals.maxHeight - constraints.maxHeight;
          Globals.height = constraints.maxHeight;
          Globals.width = constraints.maxWidth;
          return Scaffold(
            body: Container(
              width: Globals.width,
              height: Globals.height,
              color: Globals.grayHomeBg,
              child: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverAppBar(
                        expandedHeight: Globals.height * (1 - (1 / 1.618)),
                        floating: false,
                        pinned: false,
                        backgroundColor: Colors.white.withAlpha(0),
                        flexibleSpace: FlexibleSpaceBar(
                            collapseMode: CollapseMode.parallax,
                            centerTitle: true,
                            title: Container(
                              color: Globals.grayHomeBg,
                              child: Container(
                                  child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      child: Image.asset(
                                        "assets/images/home-vector.png",
                                        width: Globals.width * 0.58,
                                      ),
                                    ),
                                  ),
                                  Positioned.fill(
                                      bottom: Globals.dheight * 22,
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Card(
                                            elevation: 2,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(3000))),
                                            child: Container(
                                                width: Globals.width * 0.5,
                                                height: Globals.dheight * 30,
                                                child: Stack(
                                                  children: <Widget>[
                                                    Positioned(
                                                      left: 10,
                                                      top: -10,
                                                      child: Container(
                                                        width: Globals.width,
                                                        child: TextField(
                                                          focusNode:
                                                              searchFnode,
                                                          maxLines: 1,
                                                          textAlign:
                                                              TextAlign.left,
                                                          textAlignVertical:
                                                              TextAlignVertical
                                                                  .top,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Lato",
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .grey[500]),
                                                          controller:
                                                              searchController,
                                                          decoration: new InputDecoration
                                                                  .collapsed(
                                                              hintStyle: TextStyle(
                                                                  fontFamily:
                                                                      "Lato",
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                          .grey[
                                                                      500]),
                                                              hintText:
                                                                  'What are you looking for?'),
                                                        ),
                                                      ),
                                                    ),
                                                    // Expanded(child: InkWell(
                                                    //   onTap: (){
                                                    //     FocusScope.of(context).nextFocus();
                                                    //   },

                                                    // )),
                                                    Positioned(
                                                      right: 0,
                                                      child: InkWell(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    3000)),
                                                        onTap: () {},
                                                        child: Container(
                                                          height:
                                                              Globals.dheight *
                                                                  30,
                                                          width:
                                                              Globals.dheight *
                                                                  30,
                                                          child: Center(
                                                            child: FaIcon(
                                                                Icons.search,
                                                                size: Globals
                                                                        .dheight *
                                                                    16,
                                                                color: Colors
                                                                    .grey[300]),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ))),
                                      ))
                                ],
                              )),
                            )),
                      ),
                    ];
                  },
                  body: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    ),

                    child: Container(
                      width: Globals.width,
                      color: Colors.white,
                      height: 2000,
                      padding: EdgeInsets.only(
                          left: Globals.dwidth * 20,
                          right: Globals.dwidth * 20,
                          top: Globals.dwidth * 0),
                      child: StaggeredGridView.countBuilder(
                        scrollDirection: Axis.vertical,
                        crossAxisCount: 2,
                        itemCount: images.length,
                        itemBuilder: (BuildContext context, int index) =>
                            ImageTile(images[index], index),
                        staggeredTileBuilder: (int index) =>
                            new StaggeredTile.count(
                                1, (index % 2 == 0) ? 1.66 : 1.33),
                        mainAxisSpacing: Globals.dwidth * 20,
                        crossAxisSpacing: Globals.dwidth * 20,
                      ),
                    ),

                    // Example01()

                    // StaggeredGridView.builder(
                    //     gridDelegate: null, itemBuilder: null)
                  )),
            ),
          );
        }),
      ),
    );
  }
}
