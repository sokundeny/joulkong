import 'package:joulkong/model/subscribtion.dart';
import 'package:joulkong/model/user.dart';

abstract class UserRepository {
  Future<User> fetchCurrentUser();
  Future<void> purchasePass(PassType type);
}