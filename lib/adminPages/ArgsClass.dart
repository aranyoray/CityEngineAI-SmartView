import 'package:flutter/animation.dart';
import 'package:smart_view/model/cctv.dart';
import 'package:smart_view/model/users.dart';

class CCTVArgs {
  CCTV cctv;
  VoidCallback voidFunc;

  CCTVArgs(this.cctv, this.voidFunc);
}

class UserArgs {
  Users user;
  VoidCallback voidFunc;

  UserArgs(this.user, this.voidFunc);
}
