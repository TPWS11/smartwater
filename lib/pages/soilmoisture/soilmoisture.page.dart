import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartwater/core/bloc/soilmoisture/soil_moisture_bloc.dart';

import '../../common/widgets/mylist.dart';

class SoilMoisturePage extends StatelessWidget {
  const SoilMoisturePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFF0DC),
      appBar: AppBar(
        title: const Text(
          'Moisture Level',
          style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.w700),
        ),
        backgroundColor: const Color(0xffFFF0DC),
        surfaceTintColor: const Color(0xffFFF0DC),
      ),
      body: BlocBuilder<SoilMoistureBloc, SoilMoistureState>(
        builder: (context, state) {
          if (state is SoilMoistureInitial) {
            return const MyList(type: 'Moisture Level', length: 20, physics: AlwaysScrollableScrollPhysics(),);
          } else if (state is SoilMoistureLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SoilMoistureLoaded) {
            final recentData = state.data
                .toList()
              ..sort((a, b) => b.time.compareTo(a.time));
            return MyList(data: recentData, type: 'Moisture Level', physics: const AlwaysScrollableScrollPhysics(),);
          } else if (state is SoilMoistureError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('Data tidak ditemukan'));
          }
        },
      ),
    );
  }
}
