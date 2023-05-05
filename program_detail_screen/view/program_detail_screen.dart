import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gui_db/program_detail_screen/bloc/program_detail_event.dart';
import 'package:gui_db/program_model.dart';

import '../bloc/program_detail_bloc.dart';
import '../bloc/program_detail_state.dart';

class ProgramDetailScreen extends StatelessWidget {
  const ProgramDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Program Detail'),
      ),
      body: BlocConsumer<ProgramDetailBloc, ProgramDetailState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          print('current state from program details : ${state} ');
          if (state is ProgramDetailInitial) {
            context.read<ProgramDetailBloc>().add(ProgramDetailRequested());
          }
          if (state is ProgramDetailLoading) {
            return const Center(
              child: RefreshProgressIndicator(),
            );
          }
          if (state is ProgramDetailSuccess) {
            return SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
                child: Column(
                    children: state.programs
                        .map((e) => ProgramWidget(
                            name: e.name,
                            start_date: e.startDate,
                            end_date: e.endDate))
                        .toList()
                    // children: [
                    //   ProgramWidget(),
                    //   ProgramWidget(),
                    // ],
                    ));
          }
          return const Center(
            child: RefreshProgressIndicator(),
          );
        },
      ),
    );
  }
}

class ProgramWidget extends StatelessWidget {
  final String name;
  final String start_date;
  final String end_date;
  const ProgramWidget({
    Key? key,
    required this.name,
    required this.start_date,
    required this.end_date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16.0),
        Text(
          'Program Description',
          style: TextStyle(fontSize: 18.0),
        ),
        SizedBox(height: 24.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Start Date',
              style: TextStyle(fontSize: 18.0),
            ),
            Text(
              'End Date',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              start_date,
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              end_date,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
        SizedBox(height: 24.0),
        ElevatedButton(
          onPressed: () {},
          child: Text('Apply Now'),
        ),
      ],
    );
  }
}
