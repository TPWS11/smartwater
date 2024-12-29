import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/widgets/waterflow.card.dart';
import '../../../core/bloc/waterflow/water_flow_bloc.dart';

class LastWaterFlowScreen extends StatelessWidget {
  const LastWaterFlowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WaterFlowBloc, WaterFlowState>(
      builder: (context, state) {
        if (state is WaterFlowInitial) {
          return const Text('Initializing...');
        } else if (state is WaterFlowLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is WaterFlowLoaded) {
          return FlowRateBlink(
            data: state.data.last,
          );
        } else if (state is WaterFlowError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(child: Text('Data tidak ditemukan'));
        }
      },
    );
  }
}
