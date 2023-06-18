import 'package:chithi/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

enum CustomTheme {
  dark,
  light,
}

final systemThemeProvider = StateProvider<Brightness>((ref) {
  return Brightness.light;
});

final currentThemeProvider = StateProvider<CustomTheme>(
  (ref) {
    Box box = Hive.box(localDB);

    String? savedTheme = box.get("theme");

    // no theme saved previously
    if (savedTheme == null) {
      Brightness systemBrightness = ref.watch(systemThemeProvider);

      return systemBrightness == Brightness.dark
          ? CustomTheme.dark
          : CustomTheme.light;
    } else {
      if (savedTheme == CustomTheme.dark.toString()) {
        return CustomTheme.dark;
      } else {
        return CustomTheme.light;
      }
    }
  },
);

class ChangeThemeButton extends ConsumerWidget {
  ChangeThemeButton({
    super.key,
    double? iconSize,
    VisualDensity? visualDensity,
    EdgeInsetsGeometry? padding,
    AlignmentGeometry? alignment,
    double? splashRadius,
    Color? color,
    Color? focusColor,
    Color? hoverColor,
    Color? highlightColor,
    Color? splashColor,
    Color? disabledColor,
    MouseCursor? mouseCursor,
    FocusNode? focusNode,
    bool autofocus = false,
    String? tooltip,
    bool? enableFeedback,
    BoxConstraints? constraints,
    ButtonStyle? style,
    bool? isSelected,
    Widget? selectedIcon,
    required Widget icon,
  })  : _iconSize = iconSize,
        _visualDensity = visualDensity,
        _padding = padding,
        _alignment = alignment,
        _splashRadius = splashRadius,
        _color = color,
        _focusColor = focusColor,
        _hoverColor = hoverColor,
        _highlightColor = highlightColor,
        _splashColor = splashColor,
        _disabledColor = disabledColor,
        _mouseCursor = mouseCursor,
        _focusNode = focusNode,
        _autofocus = autofocus,
        _tooltip = tooltip,
        _enableFeedback = enableFeedback,
        _constraints = constraints,
        _style = style,
        _isSelected = isSelected,
        _selectedIcon = selectedIcon,
        _icon = icon;

  final double? _iconSize;
  final VisualDensity? _visualDensity;
  final EdgeInsetsGeometry? _padding;
  final AlignmentGeometry? _alignment;
  final double? _splashRadius;
  final Color? _color;
  final Color? _focusColor;
  final Color? _hoverColor;
  final Color? _highlightColor;
  final Color? _splashColor;
  final Color? _disabledColor;
  final MouseCursor? _mouseCursor;
  final FocusNode? _focusNode;
  final bool _autofocus;
  final String? _tooltip;
  final bool? _enableFeedback;
  final BoxConstraints? _constraints;
  final ButtonStyle? _style;
  final bool? _isSelected;
  final Widget? _selectedIcon;
  final Widget _icon;

  final Box box = Hive.box(localDB);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      iconSize: _iconSize,
      visualDensity: _visualDensity,
      padding: _padding,
      alignment: _alignment,
      splashRadius: _splashRadius,
      color: _color,
      focusColor: _focusColor,
      hoverColor: _hoverColor,
      highlightColor: _highlightColor,
      splashColor: _splashColor,
      disabledColor: _disabledColor,
      mouseCursor: _mouseCursor,
      focusNode: _focusNode,
      autofocus: _autofocus,
      tooltip: _tooltip,
      enableFeedback: _enableFeedback,
      constraints: _constraints,
      style: _style,
      isSelected: _isSelected,
      selectedIcon: _selectedIcon,

      onPressed: () {
        StateController<CustomTheme> currentTheme =
            ref.read(currentThemeProvider.notifier);

        if (currentTheme.state == CustomTheme.dark) {
          box.put("theme", CustomTheme.light.toString());
          currentTheme.state = CustomTheme.light;
        } else {
          box.put("theme", CustomTheme.dark.toString());
          currentTheme.state = CustomTheme.dark;
        }
      },
      // main text or icon you want
      icon: _icon,
    );
  }
}