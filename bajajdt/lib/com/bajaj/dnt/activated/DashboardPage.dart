import 'package:bajajdt/com/bajaj/dnt/activated/subpages/DownloadPage.dart';
import 'package:bajajdt/com/bajaj/dnt/activated/subpages/FavPage.dart';
import 'package:bajajdt/com/bajaj/dnt/activated/subpages/HomePage.dart';
import 'package:bajajdt/com/bajaj/dnt/activated/subpages/RecPage.dart';
import 'package:bajajdt/com/bajaj/dnt/activation/LoginPage.dart';
import 'package:bajajdt/com/bajaj/dnt/utils/AppConstants.dart';
import 'package:bajajdt/com/bajaj/dnt/utils/CustomColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoardRoute extends CupertinoPageRoute {
  DashBoardRoute()
      : super(builder: (BuildContext context) => new DashBoardPage());

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return new FadeTransition(
      opacity: animation,
      child: new DashBoardPage(),
    );
  }
}

class DashBoardPage extends StatefulWidget {
  @override
  DashBoardPageState createState() => DashBoardPageState();
}

class DashBoardPageState extends State<DashBoardPage>
    with SingleTickerProviderStateMixin {
  var _tabController;

  var _tabList = [
    Tab(text: "BROWSE"),
    Tab(text: "FAVOURITE"),
    Tab(text: "RECENT"),
    Tab(text: "DOWNLOAD")
  ];

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: _tabList.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _getDrawer(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bgs.9.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: _getBody(),
      ),
    );
  }

  Drawer _getDrawer() {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image(
                image: AssetImage("assets/images/bajaj_logo.png"),
              ),
            ),
            decoration: BoxDecoration(
              color: CustomColors.colorPrimary,
            ),
          ),
          ListTile(
            title: Text('HOME'),
            leading: Image(
              width: 25,
              height: 25,
              image: AssetImage("assets/images/ic_home_black.png"),
            ),
            onTap: () {
              print("Home clicked");
              setState(() {
                _tabController.index = 0;
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('FAVOURITE'),
            leading: Image(
              width: 25,
              height: 25,
              image: AssetImage("assets/images/ic_star_blk.png"),
            ),
            onTap: () {
              print("Fav clicked");
              setState(() {
                _tabController.index = 1;
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('RECENT'),
            leading: Image(
              width: 25,
              height: 25,
              image: AssetImage("assets/images/ic_recent.png"),
            ),
            onTap: () {
              print("Recent clicked");
              setState(() {
                _tabController.index = 2;
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('DOWNLOAD'),
            leading: Image(
              width: 25,
              height: 25,
              image: AssetImage("assets/images/ic_file_download.png"),
            ),
            onTap: () {
              print("Download clicked");
              setState(() {
                _tabController.index = 3;
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('REPORT BUG'),
            leading: Image(
              width: 25,
              height: 25,
              image: AssetImage("assets/images/ic_bug_report.png"),
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text('PRIVACY POLICY'),
            leading: Image(
              width: 25,
              height: 25,
              image: AssetImage("assets/images/ic_privacy_policy.png"),
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text('ABOUT'),
            leading: Image(
              width: 25,
              height: 25,
              image: AssetImage("assets/images/about_us.png"),
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text('LOGOUT'),
            leading: Image(
              width: 25,
              height: 25,
              image: AssetImage("assets/images/ic_logout.png"),
            ),
            onTap: () {
              _logOutClicked();
            },
          ),
        ],
      ),
    );
  }

  Widget _getBody() {
    return DefaultTabController(
      length: _tabList.length,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: CustomColors.colorPrimary,
              expandedHeight: 150.0,
              floating: false,
              pinned: true,
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                )
              ],
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  "Bajaj D&T",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontFamily: 'OpenSans',
                  ),
                ),
                background: Image(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/bike4.jpg"),
                ),
              ),
            ),
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                TabBar(
                  isScrollable: true,
                  labelColor: CustomColors.colorAccent,
                  unselectedLabelColor: Colors.white,
                  controller: _tabController,
                  labelStyle: TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'OpenSans',
                  ),
                  tabs: _tabList,
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            HomeScreen(),
            FavPage(),
            RecPage(),
            DownloadPage(),
          ],
        ),
      ),
    );
  }

  Future<void> _logOutClicked() async {
    var prefs = await SharedPreferences.getInstance();
    String langId = prefs.getString(PreferenceHolders.LANGUAGE_ID);
    String langPref = prefs.getString(PreferenceHolders.LANGUAGE_PREF);

    await prefs.clear();
    await prefs.setString(PreferenceHolders.LANGUAGE_ID, langId);
    await prefs.setString(PreferenceHolders.LANGUAGE_PREF, langPref);

    Navigator.pushReplacement(context, new LoginRoute());
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      color: CustomColors.colorPrimary,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
