import 'package:isar/isar.dart';
import 'package:isar_database_web/model/employee.dart';

class IsarDatabase {
  static Isar? isar;
  static List<Employee> employeeList = [];

  static Future connect() async {
    try {
      await Isar.initialize();
      isar = Isar.open(
        schemas: [EmployeeSchema],
        // directory: (await getApplicationDocumentsDirectory()).path,
        directory: Isar.sqliteInMemory,
        engine: IsarEngine.sqlite,
      );
    } on Exception catch (e) {
      print('kIsWeb :: $e');
    }
  }

  static Future addEmployee(String name, String position) async {
    if (isar != null) {
       isar!.write((isar) {
        final newEmployee = Employee(
          id: isar.employees.autoIncrement(),
          name: name,
          position: position,
        );
        isar.employees.put(newEmployee);
      });
    } else {
      connect();
    }
  }

  static Future updateEmployee(int id, String name, String position) async {
    if (isar != null) {
      isar!.write((isar) {
        final editEmployee = Employee(
          id: id,
          name: name,
          position: position,
        );
        isar.employees.put(editEmployee);
      });
    } else {
      connect();
    }
  }

  static Future deleteEmployee(Employee employee) async {
    if (isar != null) {
      isar!.write((isar) {
        isar.employees.delete(employee.id);
      });
    } else {
      connect();
    }
  }

  static Future<List<Employee>> getEmployees() async {
    if (isar != null) {
      print('getEmployees :: ${isar!.employees.where().findAll()}');
      employeeList = await isar!.employees.where().findAll();
      // isar!.readAsync((isar) async {
      //   employeeList = isar.employees.where().findAll();
      // });
    } else {
      connect();
    }
    return employeeList;
  }
}
