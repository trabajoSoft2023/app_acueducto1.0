import 'package:riverpod/riverpod.dart';

import '../../data/fake_auth_repository.dart';

class AccountScreenController extends StateNotifier<AsyncValue<void>> {
  AccountScreenController({required this.authRepository})
      : super(const AsyncValue<void>.data(null));
  final FakeAuthRepository authRepository;

  Future<bool> signOut() async {
    try {
      state = const AsyncValue<void>.loading();
      await authRepository.signOut();
      state = const AsyncValue<void>.data(null);
      return true;
    } catch (e, st) {
      state = AsyncValue<void>.error(e, st);
      return false;
    }
  }
}

final accountScreenControllerProvider = StateNotifierProvider.autoDispose<
    AccountScreenController, AsyncValue<void>>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AccountScreenController(
    authRepository: authRepository,
  );
});
