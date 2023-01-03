//clasde que representa el uid y el email del usuario
class AppUser {
  const AppUser({
    required this.uid,
    this.email,
    this.name,
    this.telephone,
  });
  final String uid;
  final String? email;
  final String? name;
  final String? telephone;
}
