//import 'dart:html';

import 'package:app_acueducto/src/localization/string_harcoded.dart';

import 'string_validators.dart';

/// Tipo de formulario para autenticación de correo electrónico y contraseña
enum EmailPasswordSignInFormType { signIn, register }

/// Clase mixta que se usará para la validación de correo electrónico y contraseña del lado del cliente
mixin EmailAndPasswordValidators {
  final StringValidator emailSubmitValidator = EmailSubmitRegexValidator();
  final StringValidator passwordRegisterSubmitValidator =
      MinLengthStringValidator(8);
  final StringValidator passwordSignInSubmitValidator =
      NonEmptyStringValidator();
}

/// Clase de estado para el formulario de correo electrónico y contraseña.
class EmailPasswordSignInState with EmailAndPasswordValidators {
  EmailPasswordSignInState({
    this.formType = EmailPasswordSignInFormType.signIn,
    this.isLoading = false,
  });
  final EmailPasswordSignInFormType formType;
  final bool isLoading;
  EmailPasswordSignInState copyWith({
    EmailPasswordSignInFormType? formType,
    bool? isLoading,
  }) {
    return EmailPasswordSignInState(
      formType: formType ?? this.formType,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  String toString() {
    return 'EmailPasswordSignInState(formType: $formType, isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EmailPasswordSignInState &&
        other.formType == formType &&
        other.isLoading == isLoading;
  }

  @override
  int get hashCode {
    return formType.hashCode ^ isLoading.hashCode;
  }
}

extension EmailPasswordSignInStateX on EmailPasswordSignInState {
  String get passwordLabelText {
    if (formType == EmailPasswordSignInFormType.register) {
      return 'Password (8+ characters)'.hardcoded;
    } else {
      return 'Password'.hardcoded;
    }
  }

  // Getters
  String get primaryButtonText {
    if (formType == EmailPasswordSignInFormType.register) {
      return 'Create an account'.hardcoded;
    } else {
      return 'Sign in'.hardcoded;
    }
  }

  String get secondaryButtonText {
    if (formType == EmailPasswordSignInFormType.register) {
      return 'Have an account? Sign in'.hardcoded;
    } else {
      return 'Necesito una cuenta? Regístrese'.hardcoded;
    }
  }

  EmailPasswordSignInFormType get secondaryActionFormType {
    if (formType == EmailPasswordSignInFormType.register) {
      return EmailPasswordSignInFormType.signIn;
    } else {
      return EmailPasswordSignInFormType.register;
    }
  }

  String get errorAlertTitle {
    if (formType == EmailPasswordSignInFormType.register) {
      return 'Registration failed'.hardcoded;
    } else {
      return 'Sign in failed'.hardcoded;
    }
  }

  String get title {
    if (formType == EmailPasswordSignInFormType.register) {
      return 'Register'.hardcoded;
    } else {
      return 'Sign in'.hardcoded;
    }
  }

  bool canSubmitEmail(String email) {
    return emailSubmitValidator.isValid(email);
  }

  bool canSubmitPassword(String password) {
    if (formType == EmailPasswordSignInFormType.register) {
      return passwordRegisterSubmitValidator.isValid(password);
    }
    return passwordSignInSubmitValidator.isValid(password);
  }

  String? emailErrorText(String email) {
    final bool showErrorText = !canSubmitEmail(email);
    final String errorText = email.isEmpty
        ? 'Email can\'t be empty'.hardcoded
        : 'Invalid email'.hardcoded;
    return showErrorText ? errorText : null;
  }

  String? passwordErrorText(String password) {
    final bool showErrorText = !canSubmitPassword(password);
    final String errorText = password.isEmpty
        ? 'Password can\'t be empty'.hardcoded
        : 'Password is too short'.hardcoded;
    return showErrorText ? errorText : null;
  }
}
