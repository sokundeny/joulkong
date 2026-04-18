import 'package:joulkong/data/repositories/user/user_repository.dart';
import 'package:joulkong/model/subscribtion.dart';
import 'package:joulkong/model/user.dart';

class UserRepositoryMock extends UserRepository {
  User _currentUser = User(
    id: 'u001',
    name: 'ronan the best ',
    email: 'ronan@example.com',
    activeSubscription: null, //  test pel ot 
  );

  @override
  Future<User> fetchCurrentUser() async {
    return Future.delayed(const Duration(milliseconds: 300), () => _currentUser);
  }

  @override
  Future<void> purchasePass(PassType type) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = User(
      id: _currentUser.id,
      name: _currentUser.name,
      email: _currentUser.email,
      activeSubscription: Subscription(
        type: type,
        price: _priceFor(type),
        expiresAt: _expiryFor(type),
      ),
    );
  }

  double _priceFor(PassType type) {
    switch (type) {
      case PassType.single:
        return 1.50;
      case PassType.daily:
        return 3.00;
      case PassType.weekly:
        return 10.00;
      case PassType.monthly:
        return 30.00;
    }
  }

  DateTime _expiryFor(PassType type) {
    switch (type) {
      case PassType.single:
        return DateTime.now().add(const Duration(hours: 2));
      case PassType.daily:
        return DateTime.now().add(const Duration(days: 1));
      case PassType.weekly:
        return DateTime.now().add(const Duration(days: 7));
      case PassType.monthly:
        return DateTime.now().add(const Duration(days: 30));
    }
  }
}