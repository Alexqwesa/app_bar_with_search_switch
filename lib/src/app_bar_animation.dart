import 'package:flutter/material.dart';

/// The second animation for [AppBarWithSearchSwitch].animation
///
/// Usage:
/// ```dart
///         appBar: AppBarWithSearchSwitch(
///           animation: (child) => AppBarAnimationSlideDown(child: child, milliseconds: 600),
///           appBarBuilder: (context) {
///             return AppBar(
///               title: Text(title),
///               actions: const [
///                 AppBarSearchButton(),
///               ],
///             );
///           },
///         ),
/// ```
class AppBarAnimationSlideDown extends StatelessWidget {
  const AppBarAnimationSlideDown({
    Key? key,
    required this.child,
    this.milliseconds = 500,
    this.withFade = true,
    this.percents = 0.75,
  }) : super(key: key);

  /// The child will be an actual AppBar
  final Widget child;
  final int milliseconds;
  final bool withFade;
  final double percents;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: milliseconds),
      transitionBuilder: (Widget child, Animation<double> animation) {
        final animationOffset = animation.drive(
          Tween<Offset>(
            begin: Offset(0.0, percents),
            end: const Offset(0.0, 0.0),
          ),
        );
        return SlideTransition(
            position: animationOffset,
            child: withFade
                ? FadeTransition(
                    opacity: animation,
                    child: child,
                  )
                : child);
      },
      child: child,
    );
  }
}

/// The second animation for [AppBarWithSearchSwitch].animation
///
/// Usage:
/// ```dart
///         appBar: AppBarWithSearchSwitch(
///           animation: (child) => AppBarAnimationSlideLeft(child: child, milliseconds: 600),
///          //animation: (child) => AppBarAnimationSlideLeft(child: child, milliseconds: 600, withFade: false, percents: 1.0,),
///           appBarBuilder: (context) {
///             return AppBar(
///               title: Text(title),
///               actions: const [
///                 AppBarSearchButton(),
///               ],
///             );
///           },
///         ),
/// ```
class AppBarAnimationSlideLeft extends StatelessWidget {
  const AppBarAnimationSlideLeft({
    Key? key,
    required this.child,
    this.milliseconds = 500,
    this.withFade = true,
    this.percents = 0.15,
  }) : super(key: key);

  /// The child will be an actual AppBar
  final Widget child;
  final int milliseconds;
  final bool withFade;
  final double percents;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: milliseconds),
      transitionBuilder: (Widget child, Animation<double> animation) {
        final second = (child.key as ValueKey<bool>?);
        final animationOffset = animation.drive(
          Tween<Offset>(
            begin: Offset(percents * ((second?.value ?? true) ? 1 : -1), 0.0),
            end: const Offset(0.0, 0.0),
          ),
        );
        return SlideTransition(
            position: animationOffset,
            child: withFade
                ? FadeTransition(
                    opacity: animation,
                    child: child,
                  )
                : child);
      },
      child: child,
    );
  }
}
