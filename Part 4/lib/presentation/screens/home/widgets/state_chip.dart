import 'package:flutter/material.dart';

class StateChip extends StatelessWidget {
  final bool isLocalState;

  const StateChip({Key key, this.isLocalState = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final materialColor = isLocalState ? Colors.green : Colors.blue;
    final shade = Theme.of(context).brightness == Brightness.light ? 300 : 800;

    return Chip(
      label: Text(isLocalState ? 'Local State' : 'Global State'),
      backgroundColor: materialColor[shade],
    );
  }
}
