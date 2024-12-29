import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/widgets/mylist.dart';
import '../../../core/bloc/soilmoisture/soil_moisture_bloc.dart';

class AllSoilMoistureScreen extends StatelessWidget {
  const AllSoilMoistureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SoilMoistureBloc, SoilMoistureState>(
      builder: (context, state) {
        if (state is SoilMoistureInitial) {
          return const MyList(type: 'Moisture Level', length: 3,);
        } else if (state is SoilMoistureLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SoilMoistureLoaded) {
          final recentData = state.data
              .toList()
            ..sort((a, b) => b.time.compareTo(a.time));
          final lastFiveData = recentData.take(3).toList();
          return MyList(data: lastFiveData, type: 'Moisture Level',);
        } else if (state is SoilMoistureError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(child: Text('Data tidak ditemukan'));
        }
      },
    );
  }
}
