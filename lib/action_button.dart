import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onPressed;

  const ActionButton({
    Key key,
    @required this.iconData,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: null,
      child: Icon(iconData),
      onPressed: onPressed,
    );
  }
}
