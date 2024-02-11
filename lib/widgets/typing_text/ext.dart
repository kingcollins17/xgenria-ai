// ignore_for_file: unnecessary_this

import 'package:flutter/widgets.dart';

import 'text_widget.dart';

extension Typing on Text {
  TypingText animateTyping(
          {AnimationController? controller,
          double secondsPerChar = 0.05,
          bool autoPlay = false}) =>
      TypingText(
        this.data!,
        autoPlay: autoPlay,
        secondsPerChar: secondsPerChar,
        key: this.key,
        style: this.style,
        strutStyle: this.strutStyle,
        textAlign: this.textAlign,
        textDirection: this.textDirection,
        locale: this.locale,
        softWrap: this.softWrap,
        overflow: this.overflow,
        textScaleFactor: this.textScaleFactor,
        textScaler: this.textScaler,
        maxLines: this.maxLines,
        semanticsLabel: this.semanticsLabel,
        textWidthBasis: this.textWidthBasis,
        textHeightBehavior: this.textHeightBehavior,
        selectionColor: this.selectionColor,
      );
}
