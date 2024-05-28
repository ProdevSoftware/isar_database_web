// lib/screens/edit_employee_screen.dart
import 'package:flutter/material.dart';
import 'package:isar_database_web/database/isar_database.dart';
import 'package:isar_database_web/model/employee.dart';

class EditEmployeeScreen extends StatefulWidget {
  final Employee? employee;

  const EditEmployeeScreen({super.key, this.employee});

  @override
  EditEmployeeScreenState createState() => EditEmployeeScreenState();
}

class EditEmployeeScreenState extends State<EditEmployeeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _positionController = TextEditingController();

  @override
  void initState() {
    if (widget.employee != null) {
      _nameController.text = widget.employee!.name;
      _positionController.text = widget.employee!.position;
      setState(() {});
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.employee == null ? 'Add Employee' : 'Edit Employee'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _positionController,
                decoration: const InputDecoration(labelText: 'Position'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a position';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: Text(widget.employee == null ? 'Add' : 'Update'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (widget.employee == null) {
                      if (_nameController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please Enter Name"),
                            duration: Duration(milliseconds: 1000),
                          ),
                        );
                      } else if (_positionController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please Enter Position"),
                            duration: Duration(milliseconds: 1000),
                          ),
                        );
                      } else {
                        IsarDatabase.addEmployee(_nameController.text, _positionController.text);
                      }
                    } else {
                      IsarDatabase.updateEmployee(
                          widget.employee!.id, _nameController.text, _positionController.text);
                    }
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _positionController.dispose();
    super.dispose();
  }
}
