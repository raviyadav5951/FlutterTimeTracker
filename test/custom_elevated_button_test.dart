import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:new_timetracker/common_widgets/custom_elevated_button.dart';

void main() {
  // Define a test. The TestWidgets function also provides a WidgetTester
  // to work with. The WidgetTester allows you to build and interact
  // with widgets in the test environment.
  testWidgets('onPressedCallback', (WidgetTester tester) async {
    //to test the tap callback
    var pressed = false;

    await tester.pumpWidget(MaterialApp(
        home: CustomElevatedButton(
      child: Text('tap me'),
      onPressed: () => pressed = true, //ontap we set the true
    )));
    final button = find.byType(ElevatedButton);

    expect(button, findsOneWidget);
    expect(find.byType(FlatButton), findsNothing);
    expect(find.text('tap me'), findsOneWidget);

    //to test the tap callback
    await tester.tap(button);
    expect(pressed,true);
  });
}
