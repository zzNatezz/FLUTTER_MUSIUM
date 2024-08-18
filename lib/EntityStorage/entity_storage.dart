class LoginEntity {
  final String? id;
  final String? username;
  final String? email;
  final String? avatar;
  final bool? isAdmin;
  final bool? error;
  const LoginEntity(
      {this.id,
      this.username,
      this.email,
      this.avatar,
      this.isAdmin = false,
      this.error = false});
}

class SongEntity {
  final String? id;
  final String? title;
  final String? author;
  final Map<String, dynamic>? image;
  final Map<String, dynamic>? song;
  final int? view;
  final bool? error;
  const SongEntity(
      {this.id,
      this.title,
      this.author,
      this.image,
      this.song,
      this.view,
      this.error = false});
}
