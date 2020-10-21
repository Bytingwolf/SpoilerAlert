import 'package:spoiler_alert/services/database_provider.dart';

class Food {
  int id;
  String name;
  String type;
  String expiryDate;

  Food({this.id, this.name, this.type, this.expiryDate});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseProvider.COLUMN_NAME: name,
      DatabaseProvider.COLUMN_TYPE: type,
      DatabaseProvider.COLUMN_DATE: expiryDate,
    };

    if (id != null) {
      map[DatabaseProvider.COLUMN_DATE] = id;
    }

    return map;
  }

  Food.fromMap(Map<String, dynamic> map) {
    id = map[DatabaseProvider.COLUMN_ID];
    name = map[DatabaseProvider.COLUMN_NAME];
    type = map[DatabaseProvider.COLUMN_TYPE];
    expiryDate = map[DatabaseProvider.COLUMN_DATE];
  }
}
