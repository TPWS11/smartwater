import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/bloc/waterflow/water_flow_bloc.dart';
import '../../core/models/waterflow.model.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WaterFlowBloc, WaterFlowState>(
        builder: (context, state) {
          if (state is WaterFlowInitial) {
            return const Center(child: Text('Initializing...'));
          } else if (state is WaterFlowLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WaterFlowLastLoaded) {
            return _buildLastWaterFlow(state.data);
          } else if (state is WaterFlowError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }
}

Widget _buildWaterFlowList(List<WaterFlowModel> data) {
  return ListView.builder(
    itemCount: data.length,
    itemBuilder: (context, index) {
      final item = data[index];
      return ListTile(
        leading: const Icon(Icons.water_drop),
        title: Text('Flow Rate: ${item.flowRate} L/s'),
        subtitle: Text('Time: ${item.time}'),
      );
    },
  );
}

Widget _buildLastWaterFlow(WaterFlowModel data) {
  return Center(
    child: Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Last Water Flow Data',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Flow Rate: ${data.flowRate} L/s'),
            Text('Time: ${data.time}'),
          ],
        ),
      ),
    ),
  );
}
