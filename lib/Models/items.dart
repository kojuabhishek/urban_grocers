import 'package:isar/isar.dart';

part 'items.g.dart';

@Collection()
class Items_2 {
  Items_2({this.id, required this.name, required this.description});

  Id? id = Isar.autoIncrement;
  late String name;
  late String description;
}
