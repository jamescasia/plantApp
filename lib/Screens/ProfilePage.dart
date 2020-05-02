import 'package:flutter/material.dart';
import 'package:plantApp/DataModels/Globals.dart';
import 'package:plantApp/Screens/HomePage.dart';
import 'package:plantApp/Screens/LogInPage.dart';
import 'package:plantApp/Screens/elements/MapFragment.dart';
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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Globals.grayHomeBg,
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
              appBar: EmptyAppBar(),
              body: Container(
                width: Globals.width,
                height: Globals.height,
                color: Globals.grayHomeBg,
                child: NestedScrollView(
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        SliverAppBar(
                          automaticallyImplyLeading: false,
                          expandedHeight: Globals.height * 0.47,
                          floating: false,
                          pinned: false,
                          backgroundColor: Colors.white.withAlpha(0),
                          flexibleSpace: FlexibleSpaceBar(
                              collapseMode: CollapseMode.parallax,
                              centerTitle: true,
                              title: Container(
                                padding: EdgeInsets.only(
                                    top: Globals.maxHeight - Globals.height),
                                color: Globals.grayHomeBg,
                                child: Stack(
                                  children: <Widget>[
                                    Positioned.fill(
                                      bottom: Globals.dheight * 0,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          SizedBox(
                                              height: Globals.dheight * 25),
                                          ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(3000)),
                                            child: Container(
                                              width: Globals.dwidth * 80,
                                              height: Globals.dwidth * 80,
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
                                          ),
                                          SizedBox(
                                              height: Globals.dheight * 10),
                                          Text(
                                            appModel
                                                .userAdapter.user.userInfo.name,
                                            // variable
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontFamily: "Lato",
                                                fontSize: Globals.dwidth * 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                          SizedBox(
                                              height: Globals.dheight * 10),
                                          Container(
                                            width: Globals.width * 0.5,
                                            child: Text(
                                              "${appModel.userAdapter.user.userInfo.bio}",
                                              // variable
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: "Lato",
                                                  fontSize: Globals.dwidth * 10,
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.black
                                                      .withAlpha(230)),
                                            ),
                                          ),
                                          SizedBox(
                                              height: Globals.dheight * 23),
                                          InkWell(
                                            onTap: () {
                                              showGeneralDialog(
                                                  barrierColor: Colors.black
                                                      .withOpacity(0.5),
                                                  transitionBuilder: (context,
                                                      a1, a2, widget) {
                                                    return Transform.scale(
                                                      scale: a1.value,
                                                      child: Opacity(
                                                          opacity: a1.value,
                                                          child: MapFragment(
                                                              double.parse(appModel
                                                                  .userAdapter
                                                                  .user
                                                                  .userInfo
                                                                  .addressLatitude),
                                                              double.parse(appModel
                                                                  .userAdapter
                                                                  .user
                                                                  .userInfo
                                                                  .addressLongitude))),
                                                    );
                                                  },
                                                  transitionDuration: Duration(
                                                      milliseconds: 200),
                                                  barrierDismissible: true,
                                                  barrierLabel: '',
                                                  context: context,
                                                  pageBuilder: (context,
                                                      animation1,
                                                      animation2) {});
                                            },
                                            child: Text(
                                              "${appModel.userAdapter.user.userInfo.address}",
                                              // variable
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  fontFamily: "Lato",
                                                  fontSize: Globals.dwidth * 11,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.green[400]),
                                            ),
                                          ),
                                          SizedBox(
                                              height: Globals.dheight * 13),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                NumberTick(appModel
                                                    .userAdapter
                                                    .user
                                                    .userInfo
                                                    .mainPhoneNumber),
                                                (appModel
                                                            .userAdapter
                                                            .user
                                                            .userInfo
                                                            .altPhoneNumber !=
                                                        "")
                                                    ? SizedBox(
                                                        width:
                                                            Globals.dwidth * 10)
                                                    : SizedBox(),
                                                (appModel
                                                            .userAdapter
                                                            .user
                                                            .userInfo
                                                            .altPhoneNumber !=
                                                        "")
                                                    ? NumberTick(appModel
                                                        .userAdapter
                                                        .user
                                                        .userInfo
                                                        .altPhoneNumber)
                                                    : SizedBox()
                                              ])
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: Globals.dheight * 100,
                                      right: Globals.dwidth * 10,
                                      child: InkWell(
                                        highlightColor: Colors.yellow,
                                        splashColor: Colors.yellow,
                                        onTap: () async {
                                          await appModel.logInScreenLogOut();

                                          Navigator.pushReplacement(
                                              context,
                                              new MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          LogInPage()));
                                        },
                                        child: Container(
                                          width: Globals.dwidth * 30,
                                          height: Globals.dwidth * 30,
                                          child: Center(
                                            child: FaIcon(
                                              FontAwesomeIcons.signOutAlt,
                                              color: Colors.grey[400],
                                              size: Globals.dwidth * 17,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
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

class NumberTick extends StatelessWidget {
  String number;
  NumberTick(this.number);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: Globals.dwidth * 22,
        // width: Globals.dwidth * 110,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey[600],
                blurRadius: 1.0,
                offset: Offset(0, 0.5),
              ),
            ],
            color: Globals.contactSellerPurple,
            borderRadius: BorderRadius.all(Radius.circular(3000))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: Globals.dwidth * 10),
            Text(
              "${number}",
              // variable
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontFamily: "Lato",
                  fontSize: Globals.dwidth * 10,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            SizedBox(width: Globals.dwidth * 4),
            FaIcon(FontAwesomeIcons.phone,
                color: Colors.white, size: Globals.dwidth * 12),
            SizedBox(width: Globals.dwidth * 10)
          ],
        ),
      ),
    );
  }
}