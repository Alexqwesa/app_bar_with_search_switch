// Copyright (c) 2022, Alexqwesa.
// All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

/// # AppBar with search switch
///
/// An AppBar with switch into search field.
///
/// A simple usage example:
///
///```dart
///  //...
///  @override
///  Widget build(BuildContext context) {
///    return Scaffold(
///      //
///      // *** The Widget AppBarWithSearchSwitch
///      //
///      appBar: AppBarWithSearchSwitch(
///        onChanged: (text) {
///          // update you provider here
///          // searchText.value = text;
///        }, // onSubmitted: (text) => searchText.value = text,
///        appBarBuilder: (context) {
///          return AppBar(
///            title: Text('Example '),
///            actions: [
///              AppBarSearchButton(),
///              // or
///              // IconButton(onPressed: AppBarWithSearchSwitch.of(context)?startSearch, icon: Icon(Icons.search)),
///            ],
///          );
///        },
///      ),
///      // search in body by any way you want, example:
///      body: AppBarOnEditListener(builder: (context) { /* your code here */  } ),
///    );
///  }
///```
// Todo: rewrite this help
library app_bar_with_search_switch;

export 'package:app_bar_with_search_switch/src/app_bar_on_edit_listener.dart';
export 'package:app_bar_with_search_switch/src/app_bar_on_submit_listener.dart';
export 'package:app_bar_with_search_switch/src/app_bar_search_button.dart';
export 'package:app_bar_with_search_switch/src/app_bar_with_search_finder.dart';
export 'package:app_bar_with_search_switch/src/app_bar_with_search_switch.dart';
