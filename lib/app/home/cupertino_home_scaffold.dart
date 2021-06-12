import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_timetracker/app/home/tab_item.dart';

/// this screen will show how to render the bottom navigation.
/// In future if we need to change or update with new widget then change
/// will not come in HomePage.
class CupertinoHomeScaffold extends StatefulWidget {
  final TabItem currentTab;
  //callback to know what changed
  final ValueChanged<TabItem> onTabSelected;

  //We need multiple builders so we created a map in HomePage
  //and passed in constructor.
  final Map<TabItem, WidgetBuilder> widgetBuilders;

  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys;
  const CupertinoHomeScaffold(
      {Key key,
      @required this.currentTab,
      @required this.onTabSelected,
      @required this.widgetBuilders,
      @required this.navigatorKeys})
      : super(key: key);

  @override
  _CupertinoHomeScaffoldState createState() => _CupertinoHomeScaffoldState();
}

class _CupertinoHomeScaffoldState extends State<CupertinoHomeScaffold> {
  //CupertinoTabController _tabController;
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        // controller: _tabController,
        tabBar: CupertinoTabBar(
          items: [
            _buildItem(TabItem.jobs),
            _buildItem(TabItem.entries),
            _buildItem(TabItem.account),
          ],
          onTap: (index) => widget.onTabSelected(TabItem.values[index]),
        ),
        tabBuilder: (context, index) {
          final item = TabItem.values[index];
          return CupertinoTabView(
            builder: (context) => widget.widgetBuilders[item](context),
            navigatorKey: widget.navigatorKeys[index],
            
          );
        });
  }

  BottomNavigationBarItem _buildItem(TabItem item) {
    final itemData = TabItemData.allTabs[item];
    final color = widget.currentTab == item ? Colors.indigo : Colors.grey;

    return BottomNavigationBarItem(
        icon: Icon(itemData.icon, color: color), label: itemData.title);
  }
}
