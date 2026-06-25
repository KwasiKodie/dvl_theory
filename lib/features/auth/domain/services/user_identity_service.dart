import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/storage/hive_boxes.dart';

class UserIdentityService {
  UserIdentityService._();

  static final instance = UserIdentityService._();

  static const _userIdKey = 'user_id';

  final _uuid = const Uuid();

  String get userId {
    final box = Hive.box(HiveBoxes.userIdentity);

    final existing = box.get(_userIdKey);

    if (existing != null && existing.toString().isNotEmpty) {
      return existing.toString();
    }

    final generated = _uuid.v4();

    box.put(_userIdKey, generated);

    return generated;
  }
}
