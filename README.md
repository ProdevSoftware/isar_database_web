# Isar Database For Flutter Web

This Flutter web app demonstrates how to perform CRUD (Create, Read, Update, Delete) operations using the Isar database. Isar is a high-performance local database designed for Flutter and Dart applications.

## Feature

- Add new records to the database
- Retrieve and display records
- Update existing records
- Delete records

## Getting Started

## 1. Dependencies
Add below dependency in pubspec.yaml

```
dependencies:
  isar: ^4.0.0-dev.14
  isar_flutter_libs: ^4.0.0-dev.14

dev_dependencies:
  flutter_test:
    sdk: flutter 
  build_runner: any
```
## 2. Code SetUp
- Initialization

```
      await Isar.initialize();
      isar = Isar.open(
        schemas: [EmployeeSchema],
        directory: Isar.sqliteInMemory,
        engine: IsarEngine.sqlite,
      );
```

- Add/Update Data

```
       isar!.write((isar) {
        isar.employees.put(data);
      });
```

- Delete Data

```
       isar!.write((isar) {
        isar.employees.delete(data.id);
      });
```

- Fetch Data

```
        isar!.employees.where().findAll();
```

## 3. Video

https://github.com/ProdevSoftware/isar_database_web/assets/97152083/a42d62fb-e0be-4c80-b8ad-bdbc5abe774b
