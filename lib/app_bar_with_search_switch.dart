/// # AppBar with search switch
///
/// An AppBar with switch into search field.
///
/// A simple usage example:
///
/// ```dart
/// class MyHomePage extends StatelessWidget {
///   const MyHomePage({Key? key}) : super(key: key);
///
///   @override
///   Widget build(BuildContext context) {
///      return Scaffold(
///       appBar: AppBarWithSearchSwitch(
///         onChanged: (text) {
///           setState(() => searchText = text);
///         },
///         appBarBuilder: (context) => AppBar(
///           title: Text(widget.title),
///           actions: [
///             IconButton(
///               icon: Icon(AppBarWithSearchSwitch.of(context)?.text != ''
///                   ? Icons.search_off
///                   : Icons.search),
///               tooltip:
///                   'Last input text: ${AppBarWithSearchSwitch.of(context)?.text}',
///               color: AppBarWithSearchSwitch.of(context)?.text != ''
///                   ? Colors.tealAccent
///                   : null,
///               onPressed: () {
///                 AppBarWithSearchSwitch.of(context)?.triggerSearch(context);
///               },
///             ),
///           ],
///         ),
///       ),
///       body: Container(),
///     }
///   }
/// }
/// ```
library app_bar_with_search_switch;

export 'package:app_bar_with_search_switch/src/app_bar_with_search_switch.dart';
