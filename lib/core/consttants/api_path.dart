class ApiPath {
  static const _mainEndpoint = 'https://be-song.vercel.app';
  late String userId;
  static const String loginEndPoint = '$_mainEndpoint/v1/auth/login';
  static const String historySongEP = '$_mainEndpoint/v1/songs/listened';
  static const String trendingSong = '$_mainEndpoint/v1/songs/trending';
}
