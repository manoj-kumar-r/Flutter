import 'package:bajajdt/com/bajaj/dnt/activated/subpages/AdditionalPage.dart';
import 'package:bajajdt/com/bajaj/dnt/activated/subpages/NewUpdationPage.dart';
import 'package:bajajdt/com/bajaj/dnt/custom/CustomUIElements.dart';
import 'package:bajajdt/com/bajaj/dnt/utils/CustomColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DownloadPage extends StatefulWidget {
  @override
  _DownloadPageState createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage>
    with SingleTickerProviderStateMixin {
  var _tabController;

  var _tabList = [Tab(text: "NEW UPDATION"), Tab(text: "ADDITIONAL DATA (AV)")];

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
    return DefaultTabController(
      length: _tabList.length,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: new PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            color: CustomColors.colorPrimary,
            child: TabBar(
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
        body: TabBarView(
          controller: _tabController,
          children: [
            NewUpdatePage(),
            AdditionalPage(),
          ],
        ),
      ),
    );
  }
}
