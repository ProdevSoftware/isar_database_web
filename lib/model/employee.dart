import 'package:isar/isar.dart';

part 'employee.g.dart';

@collection
class Employee {
  @Id()
  final int id;
  String name;
  String position;

  Employee({
    required this.id,
    required this.name,
    required this.position,
  });
}
