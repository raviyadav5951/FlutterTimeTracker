import 'package:flutter/material.dart';
import 'package:new_timetracker/app/home/account/account_page.dart';
import 'package:new_timetracker/app/home/cupertino_home_scaffold.dart';
import 'package:new_timetracker/app/home/jobs/jobs_page.dart';
import 'package:new_timetracker/app/home/tab_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.jobs;

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.jobs: (_) => JobsPage(),
      TabItem.entries: (_) => Container(),
      TabItem.account: (_) => AccountPage()
    };
  }

  void _selectTab(TabItem tabItem) {
    setState(() => _currentTab = tabItem);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoHomeScaffold(
      currentTab: _currentTab,
      onTabSelected: _selectTab,
      widgetBuilders: widgetBuilders,
    );
  }
}
