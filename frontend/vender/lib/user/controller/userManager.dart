import 'package:vender/user/controller/userDetails.dart';

class UserManager {
  static final UserManager _instance = UserManager._internal();

  factory UserManager() {
    return _instance;
  }

  UserDetails? _userDetails;

  UserDetails? get userDetails => _userDetails;

  void setUserDetails(UserDetails details) {
    _userDetails = details;
  }

  UserManager._internal();
}
