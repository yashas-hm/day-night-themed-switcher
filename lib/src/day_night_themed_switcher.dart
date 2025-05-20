import 'package:day_night_themed_switcher/src/painters.dart';
import 'package:flutter/material.dart' hide BoxShadow, BoxDecoration;
import 'package:flutter_inset_shadow/flutter_inset_shadow.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// [DayNightSwitch] is a widget that allows you to elevate your app's charm
/// with a sleek day/night switcher widget in pure Dart – because toggling be
/// tween light and dark modes should be as effortless as a flicker of magic!
class DayNightSwitch extends StatefulWidget {
  /// This is a constructor to initialize the [DayNightSwitch]
  const DayNightSwitch({
    super.key,
    this.initiallyDark = false,
    this.duration = const Duration(milliseconds: 600),
    this.size = 30,
    required this.onChange,
  });

  /// [DayNightSwitch.size] override the default icon size of
  /// [DayNightSwitch] icons
  final double size;

  /// [DayNightSwitch.initiallyDark] bool is used to set initial state of
  /// [DayNightSwitch]
  final bool initiallyDark;

  /// [DayNightSwitch.size] override the animation duration of [DayNightSwitch]
  final Duration duration;

  /// Callback function [DayNightSwitch.onChange] is used to fetch the current
  /// state of [DayNightSwitch] ultimately indicating theme
  final ValueChanged<bool> onChange;

  @override
  State createState() => _DayNightSwitchState();
}

class _DayNightSwitchState extends State<DayNightSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slideAnim;
  late double height;
  late double width;

  bool dark = true;

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    setWidget();
    animate(updateWidget: true);
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant DayNightSwitch oldWidget) {
    if (oldWidget.initiallyDark == widget.initiallyDark) return;
    setWidget();
    animate(updateWidget: true);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    slideAnim = Tween<Offset>(
      begin: const Offset(-0.16, 0),
      end: const Offset(1.46, 0),
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.elasticOut,
        reverseCurve: Curves.elasticIn,
      ),
    );

    setWidget();

    super.initState();
  }

  void setWidget() {
    dark = widget.initiallyDark;

    height = widget.size;
    width = widget.size * (7 / 3);

    if (dark) {
      animationController.value = animationController.upperBound;
    }
  }

  void animate({bool updateWidget = false}) {
    if (animationController.value == animationController.upperBound) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
    if (!updateWidget) {
      setState(() {
        dark = !dark;
        widget.onChange(dark);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onPanUpdate: (_) {
          if (!animationController.isAnimating) {
            animate();
          }
        },
        onTap: animate,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(height / 2),
          ),
          clipBehavior: Clip.hardEdge,
          child: Stack(
            children: [
              AnimatedSwitcher(
                duration: widget.duration,
                switchInCurve: Curves.easeIn,
                switchOutCurve: Curves.easeOut,
                child: dark
                    ? SvgPicture.string(
                        key: const ValueKey<String>('night'),
                        night,
                        height: height,
                        width: width,
                        fit: BoxFit.cover,
                      )
                    : SvgPicture.string(
                        key: const ValueKey<String>('day'),
                        day,
                        height: height,
                        width: width,
                        fit: BoxFit.cover,
                      ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: SlideTransition(
                  position: slideAnim,
                  child: Container(
                    alignment: Alignment.center,
                    height: height,
                    width: height,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: AnimatedSwitcher(
                      duration: widget.duration,
                      switchInCurve: Curves.easeIn,
                      switchOutCurve: Curves.easeOut,
                      child: dark
                          ? SvgPicture.string(
                              key: const ValueKey<String>('night'),
                              moon,
                              height: height,
                              width: height,
                              fit: BoxFit.fill,
                            )
                          : SvgPicture.string(
                              key: const ValueKey<String>('day'),
                              sun,
                              height: height,
                              width: height,
                              fit: BoxFit.fill,
                            ),
                    ),
                  ),
                ),
              ),
              Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(height / 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.6),
                      blurRadius: height / 5,
                      spreadRadius: height / 10,
                      inset: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
