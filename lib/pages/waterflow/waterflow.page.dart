import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/widgets/mylist.dart';
import '../../core/bloc/waterflow/water_flow_bloc.dart';

class WaterFlowPage extends StatelessWidget {
  const WaterFlowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFF0DC),
      appBar: AppBar(
        title: const Text(
          'Flow Rate',
          style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.w700),
        ),
        backgroundColor: const Color(0xffFFF0DC),
        surfaceTintColor: const Color(0xffFFF0DC),
      ),
      body: BlocBuilder<WaterFlowBloc, WaterFlowState>(
        builder: (context, state) {
          if (state is WaterFlowInitial) {
            return const MyList(type: 'Flow Rate', physics: AlwaysScrollableScrollPhysics(), length: 20,);
          } else if (state is WaterFlowLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WaterFlowLoaded) {
            final recentData = state.data
                .toList()
              ..sort((a, b) => b.time.compareTo(a.time));
            return MyList(data: recentData, type: 'Flow Rate', physics: const AlwaysScrollableScrollPhysics());
          } else if (state is WaterFlowError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('Data tidak ditemukan'));
          }
        },
      ),
    );
  }
}
