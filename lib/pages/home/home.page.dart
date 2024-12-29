import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smartwater/common/widgets/greeting.dart';
import 'package:smartwater/common/widgets/waterflow.card.dart';
import 'package:smartwater/core/bloc/soilmoisture/soil_moisture_bloc.dart';
import 'package:smartwater/core/models/soilmoisture.model.dart';

import '../../core/bloc/waterflow/water_flow_bloc.dart';
import '../../core/models/waterflow.model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Timer _timer;
  String greetingMessage = "";
  String dateInfo = "";

  @override
  void initState() {
    super.initState();
    updateGreeting();
    updateDate();
    startTimer();
  }

  void updateGreeting() {
    final now = DateTime.now();
    setState(() {
      if (now.hour >= 5 && now.hour < 12) {
        greetingMessage = "Good Morning!";
      } else if (now.hour >= 12 && now.hour < 15) {
        greetingMessage = "Good Afternoon!";
      } else {
        greetingMessage = "Good Evening!";
      }
    });
  }

  void updateDate() {
    final now = DateTime.now();
    setState(() {
      dateInfo = DateFormat(
        'EEEE, dd MMMM yyyy',
      ).format(now); // Format dalam Bahasa Indonesia
    });
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      updateGreeting();
      updateDate();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFF0DC),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(24.0, 50.0, 24.0, 24.0),
              child: Text(
                'Smart Watering',
                style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.w700),
              ),
            ),
        
            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: BlocBuilder<WaterFlowBloc, WaterFlowState>(
                builder: (context, state) {
                  if (state is WaterFlowInitial) {
                    return const Text('Initializing...');
                  } else if (state is WaterFlowLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is WaterFlowLoaded) {
                    return FlowRateBlinkCircle(
                      data: state.data.last,
                    );
                  } else if (state is WaterFlowError) {
                    return Center(child: Text('Error: ${state.message}'));
                  } else {
                    return const Center(child: Text('Data tidak ditemukan'));
                  }
                },
              ),
            ),
        
            Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0),
              child: GreetingMessage(
                greetingMessage: greetingMessage,
                dateInfo: dateInfo,
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 16.0, bottom: 8.0),
              decoration: const BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.only(topRight: Radius.circular(8.0), bottomRight: Radius.circular(8.0),),
              ),
              padding: const EdgeInsets.fromLTRB(24.0, 5.0, 15.0, 5.0),
              child: const Text('Flow Rate',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 21.0,
                  color: Colors.white,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: BlocBuilder<WaterFlowBloc, WaterFlowState>(
                builder: (context, state) {
                  if (state is WaterFlowInitial) {
                    return const Text('Initializing...');
                  } else if (state is WaterFlowLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is WaterFlowLoaded) {
                    final recentData = state.data
                        .toList()
                      ..sort((a, b) => b.time.compareTo(a.time));
                    final lastFiveData = recentData.take(4).toList();
                    return _buildWaterFlowList(
                      lastFiveData,
                      context,
                    );
                  } else if (state is WaterFlowError) {
                    return Center(child: Text('Error: ${state.message}'));
                  } else {
                    return const Center(child: Text('Data tidak ditemukan'));
                  }
                },
              ),
            ),

            Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                decoration: const BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0), bottomLeft: Radius.circular(8.0),),
                ),
                padding: const EdgeInsets.fromLTRB(15.0, 5.0, 24.0, 5.0),
                child: const Text('Moisture Level',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 21.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        
            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: BlocBuilder<SoilMoistureBloc, SoilMoistureState>(
                builder: (context, state) {
                  if (state is SoilMoistureInitial) {
                    return const Text('Initializing...');
                  } else if (state is SoilMoistureLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SoilMoistureLoaded) {
                    final recentData = state.data
                        .toList()
                      ..sort((a, b) => b.time.compareTo(a.time));
                    final lastFiveData = recentData.take(3).toList();
                    return _buildSoilMoistureList(
                      lastFiveData,
                      context,
                    );
                  } else if (state is SoilMoistureError) {
                    return Center(child: Text('Error: ${state.message}'));
                  } else {
                    return const Center(child: Text('Data tidak ditemukan'));
                  }
                },
              ),
            ),
        
          ],
        ),
      ),
    );
  }
}

Widget _buildWaterFlowList(List<WaterFlowModel> data, BuildContext context) {
  return MediaQuery.removePadding(
    context: context,
    removeTop: true,
    child: ListView.builder(
      itemCount: data.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final item = data[index];
        String formattedTime =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(item.time.toDate());
        return ListTile(
          leading: const Icon(Icons.water_drop),
          title: Text('Flow Rate: ${item.flowRate} L/s'),
          subtitle: Text('Time: $formattedTime'),
        );
      },
    ),
  );
}

Widget _buildSoilMoistureList(List<SoilMoistureModel> data, BuildContext context) {
  return MediaQuery.removePadding(
    context: context,
    removeTop: true,
    child: ListView.builder(
      itemCount: data.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final item = data[index];
        String formattedTime =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(item.time.toDate());
        return ListTile(
          leading: const Icon(Icons.terrain), // Ikon untuk kelembaban tanah
          title: Text('Moisture Level: ${item.moistureLevel.toStringAsFixed(2)}%'),
          subtitle: Text('Time: $formattedTime'),
        );
      },
    ),
  );
}

