import 'package:flutter/material.dart';
import 'package:plantApp/DataModels/Globals.dart';
import 'package:plantApp/helpers/scroll_behaviour.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plantApp/Screens/elements/ImageTile.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:plantApp/ScopedModels/app_model.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
        statusBarColor: Globals.profileYellow,
        systemNavigationBarColor: Globals.grayHomeBg
        // #61C350
        ));
    return ScopedModelDescendant<AppModel>(builder: (context, child, appModel) {
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
                color: Globals.profileYellow,
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
                              title: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40),
                                    topRight: Radius.circular(40)),
                                child: Container(
                                  color: Globals.profileYellow,
                                  child: Container(
                                      // color:Colors.pink,
                                      width: Globals.width,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(3000)),
                                            child: CachedNetworkImage(
                                              imageUrl: appModel.userAdapter
                                                  .user.userInfo.ppLink,
                                              progressIndicatorBuilder:
                                                  (context, url,
                                                          downloadProgress) =>
                                                      CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ),
                                          ),
                                          Text(
                                            appModel
                                                .userAdapter.user.userInfo.name,
                                            // variable
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontFamily: "Lato",
                                                fontSize: Globals.dwidth * 16,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black),
                                          ),
                                          Text(
                                            "@${appModel.userAdapter.user.userInfo.email}",
                                            // variable
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontFamily: "Lato",
                                                fontSize: Globals.dwidth * 16,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black),
                                          ),
                                        ],
                                      )),
                                ),
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
    });
  }
}
