//repositorio de autenticacion falso
import 'package:app_acueducto/src/features/authentication/domain/app_user.dart';
import 'package:app_acueducto/src/utils/in_memory_store.dart';
import 'package:riverpod/riverpod.dart';

//creamos una clase repositorio de autenticacion falso y dentro de la clase creamos creamos algunos metodos iniciar sesion crear cuenta
//salir de la sesion
class FakeAuthRepository {
  final _authState = InMemoryStoret<AppUser?>(null);
  //creamos un stream tipo appuser
  Stream<AppUser?> authStateChanges() => _authState.stream;
  AppUser? get currentUser => _authState.value;
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    if (currentUser == null) {
      _createNewUser(email);
    }
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    if (currentUser == null) {
      _createNewUser(email);
    }
  }

  Future<void> signOut() async {
    _authState.value = null;
  }

  void _createNewUser(String email) {
    // nota: el uid podría ser cualquier cadena única. Aquí simplemente invertimos el correo electrónico.
    _authState.value = AppUser(
      uid: email.split('').reversed.join(),
      email: email,
    );
  }

  void dispose() => _authState.close();
}

//para poder acceder ate repositorio de autenticacion falso necesitamos implementar un provider para esto instalamos en las dependencias el paquete riverpod y procederemos
//a crear nuestro proveedor al que llamaremos authRepositoryProvider
final authRepositoryProvider = Provider<FakeAuthRepository>((ref) {
  //retornamos  una  instancia del repositorio de autenticacion falso
  return FakeAuthRepository();
});
//tambien necesitamos un stream provider para que nos de acceso al metodo austhStateChanges
//el cual lo llamremos authStateChangesProvider y sera de tipo appuser
final authStateChangeProvider = StreamProvider.autoDispose<AppUser?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
});
