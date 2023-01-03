import 'package:app_acueducto/src/constatnts/app_sizes.dart';
import 'package:app_acueducto/src/widgets_commons.dart/breakpointis.dart';
import 'package:app_acueducto/src/widgets_commons.dart/res%C3%B3nsive_center.dart';

import 'package:flutter/material.dart';

/// Widget desplazable que muestra una tarjeta receptiva con un widget secundario dado.
/// Útil para mostrar formularios y otros widgets que deben ser desplazables.
class ResponsiveScrollableCard extends StatelessWidget {
  const ResponsiveScrollableCard({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ResponsiveCenter(
        maxContentWidth: Breakpoint.tablet,
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p16),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(Sizes.p16),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
