class LoginEntity {
  final String? id;
  final String? username;
  final String? email;
  final String? avatar;
  final bool? isAdmin;
  final bool? error;
  LoginEntity(
      {this.id,
      this.username,
      this.email,
      this.avatar,
      this.isAdmin,
      this.error = false});
}
