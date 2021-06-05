import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_timetracker/app/home/tab_item.dart';

/// this screen will show how to render the bottom navigation.
/// In future if we need to change or update with new widget then change
/// will not come in HomePage.
class CupertinoHomeScaffold extends StatelessWidget {
  final TabItem currentTab;
  //callback to know what changed
  final ValueChanged<TabItem> onTabSelected;

  //We need multiple builders so we created a map in HomePage
  //and passed in constructor.
  final Map<TabItem, WidgetBuilder> widgetBuilders;

  const CupertinoHomeScaffold(
      {Key key,
      @required this.currentTab,
      @required this.onTabSelected,
      @required this.widgetBuilders})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: [
            _buildItem(TabItem.jobs),
            _buildItem(TabItem.entries),
            _buildItem(TabItem.account),
          ],
          onTap: (index) => onTabSelected(TabItem.values[index]),
        ),
        tabBuilder: (context, index) {
          final item = TabItem.values[index];
          return CupertinoTabView(
              builder: (context) => widgetBuilders[item](context));
        });
  }

  BottomNavigationBarItem _buildItem(TabItem item) {
    final itemData = TabItemData.allTabs[item];
    final color = currentTab == item ? Colors.indigo : Colors.grey;

    return BottomNavigationBarItem(
        icon: Icon(itemData.icon, color: color), label: itemData.title);
  }
}
