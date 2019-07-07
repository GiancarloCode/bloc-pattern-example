import 'package:flutter/widgets.dart';
import 'bloc_listener.dart';

class BlocListenerTree extends StatelessWidget {
  final List<BlocListener> blocListeners;

  final Widget child;

  const BlocListenerTree({
    Key key,
    @required this.blocListeners,
    @required this.child,
  })  : assert(blocListeners != null),
        assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget tree = child;
    for (final blocListener in blocListeners.reversed) {
      tree = blocListener.copyWith(tree);
    }
    return tree;
  }
}
