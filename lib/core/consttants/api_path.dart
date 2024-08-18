class ApiPath {
  static const _mainEndpoint = 'https://be-song.vercel.app';
  late String userId;
  static const String loginEndPoint = '$_mainEndpoint/v1/auth/login';
  static const String HistorySongEP = '$_mainEndpoint/v1/songs/listened';
}
