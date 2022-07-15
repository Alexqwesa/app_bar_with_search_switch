/// # AppBar with search switch
///
/// An AppBar with switch into search field.
///
/// A simple usage example:
///
/// ```dart
/// class MyHomePage extends StatelessWidget {
///   const MyHomePage({Key? key}) : super(key: key);
///   final searchText = ValueNotifier<String>('');
///
///   @override
///   Widget build(BuildContext context) {
///      return Scaffold(
///       appBar: AppBarWithSearchSwitch(
///         onChanged: (text) {
///           // any provider/valueNotifier updated here, or via setState:
///           // setState(() => searchText = text);          // for statefull widget
///           // ref.provider(search.notifier).state = text; // for riverpod
///           searchText.value = text;                       // for ValueNotifier
///         },
///         appBarBuilder: (context) => AppBar(
///           title: Text('Example AppBarWithSearch'),
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
///       body: AnimatedBuilder( // or ValueListenableBuilder() for one notifier.
///           animation: Listenable.merge([searchText, ...someOtherNotifiers]),
///           builder: (BuildContext context, _) {
///             return ...; // you code here
///           },
///       ),
///     }
///   }
/// }
/// ```
library app_bar_with_search_switch;

export 'package:app_bar_with_search_switch/src/app_bar_with_search_switch.dart';
