import 'dart:async';

import 'package:flutter_bloc_state_management/employee.dart';

class EmployeeBloc {
  List<Employee> _employeeList = [
    Employee(1, "Employee One", 10000.0),
    Employee(2, "Employee Two", 20000.1),
    Employee(3, "Employee Three", 30000.2),
    Employee(4, "Employee Four", 40000.4),
    Employee(5, "Employee Five", 50000.4),
    Employee(6, "Employee Six", 60000.5),
    Employee(7, "Employee Seven", 70000.6),
    Employee(8, "Employee Eight", 80000.7),
    Employee(9, "Employee Nine", 90000.8),
    Employee(10, "Employee ten", 100000.9),
  ];

  final _employeeListStremController = StreamController<List<Employee>>();

  final _employeeSalaryIncrementStreamController = StreamController<Employee>();
  final _employeeSalaryDecrementStreamController = StreamController<Employee>();

  //getters

  Stream<List<Employee>> get employeeListStream =>
      _employeeListStremController.stream;

  StreamSink<List<Employee>> get employeeListSink =>
      _employeeListStremController.sink;

  StreamSink<Employee> get employeeSalaryIncrememt =>
      _employeeSalaryIncrementStreamController.sink;

  StreamSink<Employee> get employeeSalaryDecrement =>
      _employeeSalaryDecrementStreamController.sink;

  EmployeeBloc() {
    _employeeListStremController.add(_employeeList);

    _employeeSalaryIncrementStreamController.stream.listen(_incrementSalary);
    _employeeSalaryDecrementStreamController.stream.listen(_decrementSalary);
  }

  _incrementSalary(Employee employee) {
    double salary = employee.salary;

    double incrementedSalary = salary * 20 / 100;

    _employeeList[employee.id - 1].salary = salary + incrementedSalary;

    employeeListSink.add(_employeeList);
  }

  _decrementSalary(Employee employee) {
    double salary = employee.salary;

    double decrementedSalary = salary * 10 / 100;

    _employeeList[employee.id - 1].salary = salary - decrementedSalary;

    employeeListSink.add(_employeeList);
  }

  void dispose() {
    _employeeSalaryDecrementStreamController.close();
    _employeeSalaryIncrementStreamController.close();
    _employeeListStremController.close();
  }
}
