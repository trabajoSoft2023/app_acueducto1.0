import 'package:flutter/material.dart';

import '../constatnts/app_sizes.dart';

/// Botón principal basado en [ElevatedButton].
/// Útil para llamadas a la acción en la aplicación.
/// @param text - texto para mostrar en el botón.
/// @param isLoading: si es verdadero, se mostrará un indicador de carga en lugar de
/// el texto.
/// @param onPressed: devolución de llamada que se llamará cuando se presione el botón.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {super.key, required this.text, this.isLoading = false, this.onPressed});
  final String text;
  final bool isLoading;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizes.p48,
      child: ElevatedButton(
        onPressed: onPressed,
        child: isLoading
            ? const CircularProgressIndicator()
            : Text(
                text,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.white),
              ),
      ),
    );
  }
}
