import 'package:flutter/widgets.dart';
import 'bloc_provider.dart';

class BlocProviderTree extends StatelessWidget {
  final List<BlocProvider> blocProviders;

  final Widget child;

  const BlocProviderTree({
    Key key,
    @required this.blocProviders,
    @required this.child,
  })  : assert(blocProviders != null),
        assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget tree = child;
    for (final blocProvider in blocProviders.reversed) {
      tree = blocProvider.copyWith(tree);
    }
    return tree;
  }
}
