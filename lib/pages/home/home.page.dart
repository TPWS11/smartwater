import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smartwater/common/widgets/greeting.dart';
import 'package:smartwater/common/widgets/mytitle.dart';
import 'package:smartwater/core/bloc/soilmoisture/soil_moisture_bloc.dart';
import 'package:smartwater/pages/home/screens/all.soil.moisture.screen.dart';
import 'package:smartwater/pages/home/screens/all.water.flow.screen.dart';
import 'package:smartwater/pages/home/screens/last.water.flow.screen.dart';
import 'package:smartwater/pages/soilmoisture/soilmoisture.page.dart';
import 'package:smartwater/pages/waterflow/waterflow.page.dart';

import '../../core/bloc/waterflow/water_flow_bloc.dart';
import '../../core/services/web.socket.service.dart';


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
        
            const Padding(
              padding: EdgeInsets.only(left: 24.0),
              child: LastWaterFlowScreen(),
            ),
        
            Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0),
              child: GreetingMessage(
                greetingMessage: greetingMessage,
                dateInfo: dateInfo,
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(0, 16.0, 24.0, 8.0),
              child: MyTitle(title: 'Flow Rate', tap: () {
                setState(() {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BlocProvider<WaterFlowBloc>(
                        create: (_) => WaterFlowBloc(service: WebSocketService(websocketUrl: 'ws://192.168.1.5:2001')),
                        child: const WaterFlowPage(),
                      ),
                    ),
                  );
                });
              }),
            ),

            const Padding(
              padding: EdgeInsets.only(left: 12.0),
              child: AllWaterFlowScreen(),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 8.0, 0, 8.0),
              child: MyTitle(title: 'Moisture Level', tap: () {
                setState(() {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BlocProvider<SoilMoistureBloc>(
                        create: (_) => SoilMoistureBloc(service: WebSocketService(websocketUrl: 'ws://192.168.1.5:2001')),
                        child: const SoilMoisturePage(),
                      ),
                    ),
                  );
                });
              }),
            ),

            const Padding(
              padding: EdgeInsets.only(left: 24.0),
              child: AllSoilMoistureScreen(),
            ),
        
          ],
        ),
      ),
    );
  }
}

