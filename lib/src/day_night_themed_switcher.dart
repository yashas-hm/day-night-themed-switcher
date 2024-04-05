import 'package:day_night_themed_switcher/src/painters.dart';
import 'package:flutter/material.dart' hide BoxShadow, BoxDecoration;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DayNightSwitch extends StatefulWidget {
  const DayNightSwitch({
    super.key,
    this.initiallyDark = false,
    this.duration = const Duration(milliseconds: 600),
    this.size = 30,
    required this.onChange,
  });

  final double size;

  final bool initiallyDark;

  final Duration duration;

  final Function(bool) onChange;

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
  void didChangeDependencies() {
    setState(() {});
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant DayNightSwitch oldWidget) {
    setState(() {});
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    dark = widget.initiallyDark;

    height = widget.size;
    width = widget.size * (7 / 3);

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

    if (dark) {
      animationController.value = animationController.upperBound;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onPanUpdate: (_) {
          if (!animationController.isAnimating) {
            setState(() {
              if (animationController.value == animationController.upperBound) {
                animationController.reverse();
              } else {
                animationController.forward();
              }
              dark = !dark;
              widget.onChange(dark);
            });
          }
        },
        onTap: () => setState(() {
          if (animationController.value == animationController.upperBound) {
            animationController.reverse();
          } else {
            animationController.forward();
          }
          dark = !dark;
          widget.onChange(dark);
        }),
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
                      color: Colors.black.withOpacity(0.6),
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
