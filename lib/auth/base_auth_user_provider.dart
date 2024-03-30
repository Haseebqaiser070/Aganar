class AuthUserInfo {
  const AuthUserInfo({
    this.uid,
    this.email,
    this.displayName,
    this.photoUrl,
    this.phoneNumber,
    this.level,
  });

  final String? uid;
  final String? email;
  final String? displayName;
  final String? photoUrl;
  final String? phoneNumber;
  final int? level;
}

abstract class BaseAuthUser {
  bool get loggedIn;
  bool get emailVerified;

  AuthUserInfo get authUserInfo;

  Future? delete();
  Future? updateEmail(String email);
  Future? sendEmailVerification();
  Future refreshUser() async {}

  String? get uid => authUserInfo.uid;
  String? get email => authUserInfo.email;
  String? get displayName => authUserInfo.displayName;
  String? get photoUrl => authUserInfo.photoUrl;
  String? get phoneNumber => authUserInfo.phoneNumber;
  int? get level => authUserInfo.level;
}

BaseAuthUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
