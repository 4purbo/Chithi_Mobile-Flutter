import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required int activeIndex,
    required int length,
    required void Function(int) onClicked,
  })  : _currentIndex = activeIndex,
        _length = length,
        _onClicked = onClicked;

  final int _currentIndex;
  final int _length;
  final void Function(int) _onClicked;

  @override
  Widget build(BuildContext context) {
    List<Widget> dots = [];
    dots = List.generate(
      _length,
      (index) {
        if (index == _currentIndex) {
          // active
          return Container(
            height: 10,
            width: 10,
            decoration: const BoxDecoration(
              color: Colors.blueGrey,
              shape: BoxShape.circle,
            ),
          );
        }
        // inactive
        return GestureDetector(
          onTap: () => _onClicked(index),
          child: Container(
            height: 10,
            width: 10,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.blueGrey),
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );

    return Wrap(
      spacing: 15,
      children: dots,
    );
  }
}
