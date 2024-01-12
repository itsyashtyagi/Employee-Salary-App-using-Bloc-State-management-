import 'package:flutter/material.dart';
import 'package:flutter_bloc_state_management/employee.dart';
import 'package:flutter_bloc_state_management/employee_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final EmployeeBloc _employeeBloc = EmployeeBloc();

  @override
  void dispose() {
    _employeeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee App using Bloc'),
      ),
      body: Container(
        child: StreamBuilder(
          stream: _employeeBloc.employeeListStream,
          builder: (context, AsyncSnapshot<List<Employee>> snapshot) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          snapshot.data![index].id.toString(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data![index].name.toString(),
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              "₹ ${snapshot.data![index].salary}",
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: IconButton(
                          onPressed: () {
                            _employeeBloc.employeeSalaryIncrememt
                                .add(snapshot.data![index]);
                          },
                          icon: const Icon(
                            Icons.thumb_up,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      Container(
                        child: IconButton(
                          onPressed: () {
                            _employeeBloc.employeeSalaryDecrement
                                .add(snapshot.data![index]);
                          },
                          icon: const Icon(
                            Icons.thumb_down,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
