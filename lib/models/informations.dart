import 'package:hive/hive.dart';
part 'informations.g.dart';

@HiveType(typeId: 1)
class Informations extends HiveObject {
  @HiveField(1)
  String name;

  @HiveField(2)
  String description;

  @HiveField(3)
  String rate;

  Informations(
      {required this.name, required this.description, required this.rate});

  @override
  String toString() {
    return '$name: $rate';
  }
}
