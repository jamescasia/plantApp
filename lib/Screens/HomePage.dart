import 'package:flutter/material.dart';
import 'package:plantApp/DataModels/Globals.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double safePadding;
  TextEditingController searchController = TextEditingController();
  FocusNode searchFnode = FocusNode();
  @override
  Widget build(BuildContext context) {
    Globals.dheight = MediaQuery.of(context).size.height / 793;
    Globals.dwidth = MediaQuery.of(context).size.width / 393;
    Globals.height = MediaQuery.of(context).size.height;
    Globals.width = MediaQuery.of(context).size.width;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Globals.grayHomeBg,
        systemNavigationBarColor: Globals.grayHomeBg
        // #61C350
        ));
    return SafeArea(
      child: LayoutBuilder(builder: (context, constraints) {
        return Container(
          width: Globals.width,
          height: Globals.height,
          color: Globals.grayHomeBg,
          child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                safePadding = Globals.height - constraints.maxHeight;
                Globals.height = constraints.maxHeight;
                Globals.width = constraints.maxWidth;

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
                                  bottom: Globals.dheight * 33,
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
                                                      focusNode: searchFnode,
                                                      maxLines: 1,
                                                      textAlign: TextAlign.left,
                                                      textAlignVertical:
                                                          TextAlignVertical.top,
                                                      style: TextStyle(
                                                          fontFamily: "Lato",
                                                          fontSize: 12,
                                                          color:
                                                              Colors.grey[500]),
                                                      controller:
                                                          searchController,
                                                      decoration: new InputDecoration
                                                              .collapsed(
                                                          hintStyle: TextStyle(
                                                              fontFamily:
                                                                  "Lato",
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .grey[500]),
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
                                                          Globals.dheight * 30,
                                                      width:
                                                          Globals.dheight * 30,
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

                                    // child: Container(
                                    //   width: Globals.width * 0.5,
                                    //   height: Globals.dheight * 29,
                                    //   decoration: BoxDecoration(
                                    //       color: Colors.white,
                                    //       borderRadius: BorderRadius.all(
                                    //           Radius.circular(3000)),
                                    //       boxShadow: [
                                    //         BoxShadow(
                                    //           color: Colors.grey[300],
                                    //           blurRadius: 0.5,
                                    //           offset: Offset(0, 0.5),
                                    //         ),
                                    //       ]),
                                    //   child: Row(
                                    //       mainAxisAlignment:
                                    //           MainAxisAlignment.spaceAround,
                                    //           mainAxisSize: MainAxisSize.max,
                                    //       crossAxisAlignment:
                                    //           CrossAxisAlignment.center,
                                    //       children: [
                                    //         Container(
                                    //           height: Globals.dheight * 29,
                                    //           child: TextField(
                                    //             style: TextStyle(
                                    //                 fontFamily: "Lato",
                                    //                 fontSize: 12,
                                    //                 color: Colors.grey[500]),
                                    //             controller: searchController,
                                    //             decoration: new InputDecoration
                                    //                     .collapsed(
                                    //                 hintStyle: TextStyle(
                                    //                     fontFamily: "Lato",
                                    //                     fontSize: 12,
                                    //                     color:
                                    //                         Colors.grey[500]),
                                    //                 hintText:
                                    //                     'What are you looking for?'),
                                    //           ),
                                    //         ),
                                    //         Container(
                                    //           height: Globals.dheight * 29,
                                    //           child: Center(
                                    //             child: InkWell(
                                    //                 child: FaIcon(Icons.search,
                                    //                     size: Globals.dheight *
                                    //                         16,
                                    //                     color:
                                    //                         Colors.grey[300])),
                                    //           ),
                                    //         )
                                    //       ]),
                                    // ),
                                  ))
                            ],
                          )),
                        )),
                  ),
                ];
              },
              body: SingleChildScrollView(
                  child: Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(36),
                    ),
                    child: Container(
                      height: 1000,
                      color: Colors.red,
                    ),
                  )
                ],
              ))),
        );
      }),
    );
  }
}
