import 'package:app_acueducto/src/widgets_commons.dart/breakpointis.dart';

import 'package:flutter/material.dart';

///Widget reutilizable para mostrar a un niño con una restricción máxima de ancho de contenido.
/// Si el ancho disponible es mayor que el ancho máximo, el niño será
/// centrado.
/// Si el ancho disponible es más pequeño que el ancho máximo, el niño usa todos los
/// ancho disponible.
class ResponsiveCenter extends StatelessWidget {
  const ResponsiveCenter({
    super.key,
    this.maxContentWidth = Breakpoint.desktop,
    this.padding = EdgeInsets.zero,
    required this.child,
  });
  final double maxContentWidth;
  final EdgeInsetsGeometry padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // Usa el Centro ya que tiene un ancho *sin restricciones* (restricciones sueltas)
    return Center(
      // junto con SizedBox para especificar el ancho máximo (restricciones estrictas)
      // Ver este hilo para más información:
      // https://twitter.com/biz84/status/1445400059894542337
      child: SizedBox(
        width: maxContentWidth,
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}

/// Sliver-equivalent of [ResponsiveCenter].
class ResponsiveSliverCenter extends StatelessWidget {
  const ResponsiveSliverCenter({
    super.key,
    this.maxContentWidth = Breakpoint.desktop,
    this.padding = EdgeInsets.zero,
    required this.child,
  });
  final double maxContentWidth;
  final EdgeInsetsGeometry padding;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ResponsiveCenter(
        maxContentWidth: maxContentWidth,
        padding: padding,
        child: child,
      ),
    );
  }
}
