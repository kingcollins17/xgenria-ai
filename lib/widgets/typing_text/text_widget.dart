// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unused_element

import 'package:flutter/material.dart';

class TypingText extends StatefulWidget {
  const TypingText(this.text,
      {super.key,
      this.style,
      this.controller,
      this.strutStyle,
      this.textAlign,
      this.textDirection,
      this.locale,
      this.softWrap,
      this.overflow,
      this.textScaleFactor,
      this.textScaler,
      this.maxLines,
      this.semanticsLabel,
      this.textWidthBasis,
      this.textHeightBehavior,
      this.selectionColor,
      this.autoPlay = false,
      this.secondsPerChar = 0.05});

  final bool autoPlay;
  final double secondsPerChar;
  // final onComplete;
  final String text;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;

  @Deprecated('')
  final double? textScaleFactor;
  final TextScaler? textScaler;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final Color? selectionColor;
  final AnimationController? controller;

  @override
  State<TypingText> createState() => _TypingTextState();
}

class _TypingTextState extends State<TypingText>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ??
        AnimationController(
          vsync: this,
          duration: Duration(seconds: 5),
        );
    final seq = parse(widget.text, secondsPerChar: widget.secondsPerChar);
    animation = seq.$1.animate(controller..duration = seq.$2);
    if (widget.autoPlay) _runAnimation();
  }

  @override
  void didUpdateWidget(covariant TypingText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      final seq = parse(widget.text, secondsPerChar: widget.secondsPerChar);
      animation = seq.$1.animate(controller..duration = seq.$2);
    }
    if (widget.autoPlay) _runAnimation();
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.controller == null) controller.dispose();
  }

  void _runAnimation() {
    controller.reset();
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: (context, child) => Text(
        animation.value,
        style: widget.style,
        strutStyle: widget.strutStyle,
        textAlign: widget.textAlign,
        textDirection: widget.textDirection,
        locale: widget.locale,
        softWrap: widget.softWrap,
        overflow: widget.overflow,
        textScaleFactor: widget.textScaleFactor,
        textScaler: widget.textScaler,
        maxLines: widget.maxLines,
        semanticsLabel: widget.semanticsLabel,
        textWidthBasis: widget.textWidthBasis,
        textHeightBehavior: widget.textHeightBehavior,
        selectionColor: widget.selectionColor,
      ),
      animation: animation,
    );
  }
}

(TweenSequence<String>, Duration) parse(String text,
    {double secondsPerChar = 0.1}) {
  final sequence = <TweenSequenceItem<String>>[
    TweenSequenceItem(tween: ConstantTween(''), weight: 1),
  ];
  var temp = '';
  for (var i = 0; i < text.length; i++) {
    temp += text[i];
    sequence.add(TweenSequenceItem(
        tween: ConstantTween(i == text.length - 1 ? temp : '$temp|'),
        weight: text[i] == ' ' ? 2 : 1));
  }
  return (
    TweenSequence(sequence),
    Duration(milliseconds: 1000 * (secondsPerChar * text.length).ceil())
  );
}
