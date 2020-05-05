import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plantApp/DataModels/Globals.dart';
import 'package:plantApp/DataModels/Listing.dart';
import 'package:plantApp/ScopedModels/app_model.dart';
import 'package:plantApp/Screens/AddPostPage.dart';
import 'package:plantApp/Screens/LogInPage.dart';
import 'package:plantApp/Screens/elements/ImageTileBuying.dart';
import 'package:plantApp/Screens/elements/ImageTileSelling.dart';
import 'package:plantApp/Screens/elements/ImageTileSharing.dart';
import 'package:plantApp/helpers/scroll_behaviour.dart';
import 'package:scoped_model/scoped_model.dart';

import 'ProfilePage.dart';

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
  ScrollController _hideButtonController = ScrollController();
  bool _isFabVisible = true;

  @override
  initState() {
    _hideButtonController.addListener(() {
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isFabVisible == true) {
          setState(() {
            _isFabVisible = false;
          });
        }
      } else {
        if (_hideButtonController.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (_isFabVisible == false) {
            setState(() {
              _isFabVisible = true;
            });
          }
        }
      }
    });
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  generateShape(String id) {
    var last = id.substring(id.length - 1);
    var shapes = [0.83, 0.96, 1.21, 1.39, 1.66, 1.81];
    if (isNumeric(last)) {
      return shapes[0];
    } else {
      if (last.codeUnitAt(0) >= 65 && last.codeUnitAt(0) <= 74) {
        return shapes[1];
      } else if (last.codeUnitAt(0) >= 75 && last.codeUnitAt(0) <= 84) {
        return shapes[2];
      } else if (last.codeUnitAt(0) >= 97 && last.codeUnitAt(0) <= 106) {
        return shapes[3];
      } else if (last.codeUnitAt(0) >= 107 && last.codeUnitAt(0) <= 116) {
        return shapes[4];
      } else {
        return shapes[5];
      }
    }
  }

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
    return ScopedModelDescendant<AppModel>(builder: (context, child, appModel) {
      return Material(
        child: ScrollConfiguration(
          behavior: CustomScrollBehaviour(),
          child: SafeArea(
            child: LayoutBuilder(builder: (context, constraints) {
              safePadding = Globals.maxHeight - constraints.maxHeight;
              Globals.height = constraints.maxHeight;
              Globals.width = constraints.maxWidth;
              return Scaffold(
                floatingActionButton: Visibility(
                    visible: _isFabVisible,
                    child: MaterialButton(
                        elevation: 5,
                        minWidth: Globals.dwidth * 65,
                        height: Globals.dwidth * 65,
                        color: Colors.greenAccent,
                        child: FaIcon(
                          FontAwesomeIcons.plus,
                          color: Colors.white,
                          size: Globals.dheight * 30,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(3000))),
                        onPressed: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      AddPostPage()));
                        })),
                appBar: EmptyAppBar(),
                body: Container(
                  width: Globals.width,
                  height: Globals.height,
                  color: Globals.grayHomeBg,
                  child: NestedScrollView(
                      controller: _hideButtonController,
                      headerSliverBuilder:
                          (BuildContext context, bool innerBoxIsScrolled) {
                        return <Widget>[
                          SliverAppBar(
                            automaticallyImplyLeading: false,
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
                                      // color:Colors.pink,
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
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                3000))),
                                                child: Container(
                                                    width: Globals.width * 0.5,
                                                    height:
                                                        Globals.dheight * 30,
                                                    child: Stack(
                                                      children: <Widget>[
                                                        Positioned(
                                                          left: 10,
                                                          top: -10,
                                                          child: Container(
                                                            width:
                                                                Globals.width,
                                                            child: TextField(
                                                              focusNode:
                                                                  searchFnode,
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              textAlignVertical:
                                                                  TextAlignVertical
                                                                      .top,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "Lato",
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                          .grey[
                                                                      500]),
                                                              controller:
                                                                  searchController,
                                                              decoration: new InputDecoration
                                                                      .collapsed(
                                                                  hintStyle: TextStyle(
                                                                      fontFamily:
                                                                          "Lato",
                                                                      fontSize:
                                                                          12,
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
                                                              height: Globals
                                                                      .dheight *
                                                                  30,
                                                              width: Globals
                                                                      .dheight *
                                                                  30,
                                                              child: Center(
                                                                child: FaIcon(
                                                                    Icons
                                                                        .search,
                                                                    size: Globals
                                                                            .dheight *
                                                                        16,
                                                                    color: Colors
                                                                            .grey[
                                                                        300]),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ))),
                                          )),
                                      Positioned(
                                        top: Globals.dheight * 100,
                                        right: Globals.dwidth * 10,
                                        child: InkWell(
                                          highlightColor: Colors.yellow,
                                          splashColor: Colors.yellow,
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                new MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        ProfilePage()));
                                          },
                                          child: Container(
                                            width: Globals.dwidth * 30,
                                            height: Globals.dwidth * 30,
                                            child: Center(
                                              child: FaIcon(
                                                FontAwesomeIcons.user,
                                                color: Colors.grey[400],
                                                size: Globals.dwidth * 17,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                                )),
                          ),
                        ];
                      },
                      body: Material(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                        elevation: 1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(40),
                          ),

                          child: Container(
                            width: Globals.width,
                            color: Colors.white,
                            padding: EdgeInsets.only(
                                left: Globals.dwidth * 20,
                                right: Globals.dwidth * 20,
                                top: Globals.dwidth * 0),
                            child: StaggeredGridView.countBuilder(
                              scrollDirection: Axis.vertical,
                              crossAxisCount: 2,
                              itemCount:
                                  appModel.userAdapter.user.allListings.length,
                              itemBuilder: (BuildContext context, int index) {
                                if (appModel.userAdapter.user.allListings[index]
                                    is ListingSelling) {
                                  return ImageTileSelling(
                                      appModel
                                          .userAdapter.user.allListings[index],
                                      generateShape((appModel.userAdapter.user
                                              .allListings[index])
                                          .id),
                                      index);
                                } else if (appModel.userAdapter.user
                                    .allListings[index] is ListingBuying) {
                                  return ImageTileBuying(
                                      appModel
                                          .userAdapter.user.allListings[index],
                                      generateShape((appModel.userAdapter.user
                                              .allListings[index])
                                          .id),
                                      index);
                                } else
                                  return ImageTileSharing(
                                      appModel
                                          .userAdapter.user.allListings[index],
                                      generateShape((appModel.userAdapter.user
                                              .allListings[index])
                                          .id),
                                      index);
                              },
                              staggeredTileBuilder: (int index) {
                                return new StaggeredTile.count(
                                    1,
                                    generateShape((appModel.userAdapter.user
                                            .allListings[index])
                                        .id));
                              },
                              mainAxisSpacing: Globals.dwidth * 20,
                              crossAxisSpacing: Globals.dwidth * 20,
                            ),
                          ),

                          // Example01()

                          // StaggeredGridView.builder(
                          //     gridDelegate: null, itemBuilder: null)
                        ),
                      )),
                ),
              );
            }),
          ),
        ),
      );
    });
  }
}
