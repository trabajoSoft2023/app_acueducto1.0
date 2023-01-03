import 'package:app_acueducto/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import 'package:app_acueducto/src/features/authentication/presentation/sign_in/string_validators.dart';
import 'package:app_acueducto/src/localization/string_harcoded.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../constatnts/app_sizes.dart';
import '../../../../widgets_commons.dart/custom_text_button.dart';
import '../../../../widgets_commons.dart/primary_button.dart';
import '../../../../widgets_commons.dart/responsive_scrollable.dart';

/// Pantalla de inicio de sesión de correo electrónico y contraseña.

class EmailPasswordSignInScreen extends StatelessWidget {
  const EmailPasswordSignInScreen({super.key, required this.formType});
  final EmailPasswordSignInFormType formType;

// * Claves para probar usando find.byKey()
  static const emailKey = Key('email');
  static const passwordKey = Key('password');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign In'.hardcoded)),
      body: EmailPasswordSignInContents(
        formType: formType,
        onSignedIn: () => Navigator.of(context).pop(),
      ),
    );
  }
}

//Un widget para la autenticación de correo electrónico y contraseña, compatible con lo siguiente:
/// - iniciar sesión
/// - registrarse (crear una cuenta)
class EmailPasswordSignInContents extends StatefulWidget {
  const EmailPasswordSignInContents({
    super.key,
    this.onSignedIn,
    required this.formType,
  });
  final VoidCallback? onSignedIn;

  /// El tipo de formulario predeterminado a usar.
  final EmailPasswordSignInFormType formType;
  @override
  State<EmailPasswordSignInContents> createState() =>
      _EmailPasswordSignInContentsState();
}

class _EmailPasswordSignInContentsState
    extends State<EmailPasswordSignInContents> {
  final _formKey = GlobalKey<FormState>();
  final _node = FocusScopeNode();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String get email => _emailController.text;
  String get password => _passwordController.text;
  // variable local utilizada para aplicar AutovalidateMode.onUserInteraction y mostrar
  // sugerencias de error solo cuando se ha enviado el formulario
  var _submitted = false;

// variable local que representa el tipo de formulario y el estado de carga
  late var _state =
      EmailPasswordSignInState(formType: widget.formType, isLoading: false);
  @override
  void dispose() {
    // * Los TextEditingControllers deben desecharse siempre
    _node.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit(EmailPasswordSignInState state) async {
    setState(() => _submitted = true);

// solo envíe el formulario si pasa la validación

    if (_formKey.currentState!.validate()) {
      // TODO: Authentication logic
      widget.onSignedIn?.call();
    }
  }

  void _emailEditingComplete(EmailPasswordSignInState state) {
    if (state.canSubmitEmail(email)) {
      _node.nextFocus();
    }
  }

  void _passwordEditingComplete(EmailPasswordSignInState state) {
    if (!state.canSubmitEmail(email)) {
      _node.previousFocus();
      return;
    }
    _submit(state);
  }

  void _updateFormType(EmailPasswordSignInFormType formType) {
// * Alternar entre formulario de registro e inicio de sesión
    setState(() => _state = _state.copyWith(formType: formType));
    // * Limpiar el campo de contraseña al hacerlo
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveScrollableCard(
      child: FocusScope(
        node: _node,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              gapH8,
              // Email field
              TextFormField(
                key: EmailPasswordSignInScreen.emailKey,
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email'.hardcoded,
                  hintText: 'test@test.com'.hardcoded,
                  enabled: !_state.isLoading,
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                    !_submitted ? null : _state.emailErrorText(email ?? ''),
                autocorrect: false,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                keyboardAppearance: Brightness.light,
                onEditingComplete: () => _emailEditingComplete(_state),
                inputFormatters: <TextInputFormatter>[
                  ValidatorInputFormatter(
                      editingValidator: EmailEditingRegexValidator()),
                ],
              ),
              gapH8,
              // Password field
              TextFormField(
                key: EmailPasswordSignInScreen.passwordKey,
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: _state.passwordLabelText,
                  enabled: !_state.isLoading,
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (password) => !_submitted
                    ? null
                    : _state.passwordErrorText(password ?? ''),
                obscureText: true,
                autocorrect: false,
                textInputAction: TextInputAction.done,
                keyboardAppearance: Brightness.light,
                onEditingComplete: () => _passwordEditingComplete(_state),
              ),
              gapH8,
              PrimaryButton(
                text: _state.primaryButtonText,
                isLoading: _state.isLoading,
                onPressed: _state.isLoading ? null : () => _submit(_state),
              ),
              gapH8,
              CustomTextButton(
                text: _state.secondaryButtonText,
                onPressed: _state.isLoading
                    ? null
                    : () => _updateFormType(_state.secondaryActionFormType),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
