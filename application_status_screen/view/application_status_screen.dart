import 'package:flutter/material.dart';

class ApplicationStatusScreen extends StatefulWidget {
  const ApplicationStatusScreen({Key? key}) : super(key: key);

  @override
  _ApplicationStatusScreenState createState() =>
      _ApplicationStatusScreenState();
}

class _ApplicationStatusScreenState extends State<ApplicationStatusScreen> {
  final List<String> _programs = [
    'Program A',
    'Program B',
    'Program C',
  ];

  String _selectedProgram = 'Program A';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Application Status'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select a Program',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            DropdownButton<String>(
              value: _selectedProgram,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedProgram = newValue!;
                });
              },
              items: _programs
                  .map((program) => DropdownMenuItem<String>(
                        value: program,
                        child: Text(program),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Application Status',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            _buildStatusCard('John Doe', 'Pending'),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(String applicantName, String status) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.person),
        title: Text(applicantName),
        subtitle: Text('Status: $status'),
        trailing: IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: () {
            // TODO: navigate to application details screen
          },
        ),
      ),
    );
  }
}
