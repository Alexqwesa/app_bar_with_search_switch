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
    this.milliseconds = 400,
    this.withFade = true,
    this.percents = 0.75,
    this.switchInCurve = Curves.easeInSine,
    this.switchOutCurve = Curves.easeOutSine,
  }) : super(key: key);

  /// The child will be an actual AppBar.
  final Widget child;

  /// Duration of animation in milliseconds.
  final int milliseconds;

  /// Add Fade effect (default true).
  final bool withFade;

  /// How much to slide in range 0.0...1.0 (1.0==100%).
  final double percents;

  /// The animation curve to use when transitioning in a new child.
  ///
  /// Default is Curves.easeInSine.
  final Curve switchInCurve;

  /// The animation curve to use when transitioning a previous child out.
  ///
  /// Default is Curves.easeOutSine.
  final Curve switchOutCurve;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: milliseconds),
      switchInCurve: switchInCurve,
      switchOutCurve: switchOutCurve,
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
    this.milliseconds = 400,
    this.withFade = true,
    this.percents = 0.15,
    this.switchInCurve = Curves.easeInSine,
    this.switchOutCurve = Curves.easeOutSine,
  }) : super(key: key);

  /// The child will be an actual AppBar.
  final Widget child;

  /// Duration of animation in milliseconds.
  final int milliseconds;

  /// Add Fade effect (default true).
  final bool withFade;

  /// How much to slide in range 0.0...1.0 (1.0==100%).
  final double percents;

  /// The animation curve to use when transitioning in a new child.
  ///
  /// Default is Curves.easeInSine.
  final Curve switchInCurve;

  /// The animation curve to use when transitioning a previous child out.
  ///
  /// Default is Curves.easeOutSine.
  final Curve switchOutCurve;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Theme.of(context).appBarTheme.backgroundColor ??
              Theme.of(context).primaryColor,
          child: SafeArea(
            child: SizedBox.expand(
              child: Container(
                color: Theme.of(context).appBarTheme.backgroundColor ??
                    Theme.of(context).canvasColor,
                child: SizedBox.expand(),
              ),
            ),
          ),
        ),
        AnimatedSwitcher(
          duration: Duration(milliseconds: milliseconds),
          switchInCurve: switchInCurve,
          switchOutCurve: switchOutCurve,
          transitionBuilder: (Widget child, Animation<double> animation) {
            final second = (child.key as ValueKey<bool>?);
            final animationOffset = animation.drive(
              Tween<Offset>(
                begin:
                    Offset(percents * ((second?.value ?? true) ? 1 : -1), 0.0),
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
        ),
      ],
    );
  }
}
