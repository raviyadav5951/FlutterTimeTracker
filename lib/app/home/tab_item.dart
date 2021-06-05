import 'package:flutter/material.dart';

enum TabItem { jobs, entries, account }

class TabItemData {
  final String title;
  final IconData icon;

  const TabItemData({@required this.title, @required this.icon});

  static const Map<TabItem, TabItemData> allTabs = {
    TabItem.jobs: TabItemData(icon: Icons.work, title: 'Jobs'),
    TabItem.entries: TabItemData(icon: Icons.view_headline, title: 'Entries'),
    TabItem.account: TabItemData(icon: Icons.people, title: 'Account')
  };
}
