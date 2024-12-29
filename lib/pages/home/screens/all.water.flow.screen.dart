import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/widgets/mylist.dart';
import '../../../core/bloc/waterflow/water_flow_bloc.dart';

class AllWaterFlowScreen extends StatelessWidget {
  const AllWaterFlowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WaterFlowBloc, WaterFlowState>(
      builder: (context, state) {
        if (state is WaterFlowInitial) {
          return const MyList(type: 'Flow Rate',);
        } else if (state is WaterFlowLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is WaterFlowLoaded) {
          final recentData = state.data
              .toList()
            ..sort((a, b) => b.time.compareTo(a.time));
          final lastFiveData = recentData.take(4).toList();
          return MyList(data: lastFiveData, type: 'Flow Rate',);
        } else if (state is WaterFlowError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(child: Text('Data tidak ditemukan'));
        }
      },
    );
  }
}
