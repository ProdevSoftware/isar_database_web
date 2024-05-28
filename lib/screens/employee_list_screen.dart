import 'package:flutter/material.dart';
import 'package:isar_database_web/database/isar_database.dart';
import 'package:isar_database_web/model/employee.dart';
import 'package:isar_database_web/screens/edit_employee_screen.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  List<Employee> employeeList = [];

  @override
  void initState() {
    getEmployees();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee List'),
      ),
      body: ListView.builder(
        itemCount: employeeList.length,
        itemBuilder: (ctx, index) {
          final employee = employeeList[index];
          return ListTile(
            shape: index == 0
                ? null
                : const Border(
                    top: BorderSide(color: Colors.grey),
                  ),
            tileColor: Colors.black12,
            title: Text(employee.name),
            subtitle: Text(employee.position),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Tooltip(
                  message: 'Edit',
                  child: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.of(context)
                          .push(
                        MaterialPageRoute(
                          builder: (ctx) => EditEmployeeScreen(employee: employee),
                        ),
                      )
                          .then((value) {
                        getEmployees();
                      });
                    },
                  ),
                ),
                Tooltip(
                  message: 'Delete',
                  child: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      deleteEmployees(employee);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (ctx) => const EditEmployeeScreen(),
            ),
          )
              .then((value) {
            getEmployees();
          });
        },
        tooltip: 'Add Employee',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> getEmployees() async {
    employeeList = await IsarDatabase.getEmployees();
    setState(() {});
  }

  Future<void> deleteEmployees(Employee employee) async {
    await IsarDatabase.deleteEmployee(employee);
    await getEmployees();
    setState(() {});
  }
}
