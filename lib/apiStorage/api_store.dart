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
  final String id;
  final String title;
  final String author;
  final Map<String, dynamic> image;
  final Map<String, dynamic> song;
  final int view;
  const SongEntity({
    required this.id,
    required this.title,
    required this.author,
    required this.image,
    required this.song,
    required this.view,
  });
}
