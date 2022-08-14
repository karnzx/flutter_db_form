import 'package:hive/hive.dart';

import 'models/informations.dart';

class Boxes {
  static Box<Informations> getInformations() =>
      Hive.box<Informations>('informations');
}
