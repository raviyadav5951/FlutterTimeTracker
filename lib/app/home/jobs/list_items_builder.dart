import 'package:flutter/material.dart';
import 'package:new_timetracker/app/home/jobs/empty_content.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

/// This class is custom implementation to handle the ui states when list is loading, empty ,error.
/// Also we have used ListVoew.builder to load only those items which are visible at  a time like recyclerview in android.

class ListItemsBuilder<T> extends StatelessWidget {
  final AsyncSnapshot<List<T>> snapshot;
  final ItemWidgetBuilder<T> itemBuilder;

  const ListItemsBuilder(
      {Key key, @required this.snapshot, @required this.itemBuilder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasData) {
      final List<T> items = snapshot.data;
      if (items.isNotEmpty) {
        return _buildList(items);
      } else {
        return EmptyContent();
      }
    } else if (snapshot.hasError) {
      return EmptyContent(
        title: 'Something went wrong',
        message: 'Can\'t load items right now',
      );
    }
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildList(List<T> items) {
    //using separator to add divider between
    // return ListView.builder(
    //   itemCount: items.length,
    //   itemBuilder: (context, index) => itemBuilder(context, items[index]),
    // );

    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        height: 1.0,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) => itemBuilder(context, items[index]),
    );
  }
}
