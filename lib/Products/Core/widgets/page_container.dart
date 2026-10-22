import 'package:flutter/material.dart';

/// Har page ka common wrapper: responsive padding + max width + scroll.
class PageContainer extends StatelessWidget {
  final Widget child;
  const PageContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, c) {
      final pad = c.maxWidth < 600 ? 16.0 : (c.maxWidth < 1000 ? 24.0 : 32.0);
      return SingleChildScrollView(
        padding: EdgeInsets.all(pad),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1240),
            child: child,
          ),
        ),
      );
    });
  }
}