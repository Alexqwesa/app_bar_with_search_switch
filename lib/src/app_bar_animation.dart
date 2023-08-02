import 'package:flutter/material.dart';

/// The Slide down animation for [AppBarWithSearchSwitch].[animation]
///
/// Usage:
/// ```dart
///         appBar: AppBarWithSearchSwitch(
///           animation: AppBarAnimationSlideDown.call
///           // or customize:
///           animation: (child) => AppBarAnimationSlideDown(child: child, milliseconds: 400),
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

  factory AppBarAnimationSlideDown.call(child) =>
      AppBarAnimationSlideDown(child: child);

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

/// The slide left animation for [AppBarWithSearchSwitch].[animation]
///
/// Usage:
/// ```dart
///         appBar: AppBarWithSearchSwitch(
///           animation: AppBarAnimationSlideLeft.call
///           // or customize:
///           //animation: (child) => AppBarAnimationSlideLeft(child: child, milliseconds: 400, withFade: false, percents: 1.0,),
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
    this.background = backgroundBoxDecoration,
  }) : super(key: key);

  factory AppBarAnimationSlideLeft.call(child) =>
      AppBarAnimationSlideLeft(child: child);

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

  /// The [BoxDecoration] that will be shown behind AppBar during transition.
  ///
  /// Default: [backgroundBoxDecoration]  - LinearGradient
  /// Use `null` for static color.
  final BoxDecoration Function(BuildContext context)? background;

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
                decoration: background?.call(context),
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
            final playForward = (child.key as ValueKey<bool>?)?.value ?? true;
            final animationOffset = animation.drive(
              Tween<Offset>(
                begin: Offset(percents * (playForward ? 1 : -1), 0.0),
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

/// Default [BoxDecoration] with [LinearGradient] shown during transition.
BoxDecoration backgroundBoxDecoration(BuildContext context) {
  return BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Theme.of(context).appBarTheme.backgroundColor ??
            Theme.of(context).canvasColor,
        Theme.of(context).appBarTheme.foregroundColor ??
            Theme.of(context).primaryColor,
        Theme.of(context).appBarTheme.backgroundColor ??
            Theme.of(context).canvasColor,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );
}
