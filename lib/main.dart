import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartwater/pages/home/home.page.dart';

import 'core/bloc/waterflow/water_flow_bloc.dart';
import 'core/services/web.socket.service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Watering',
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => WaterFlowBloc(service: WebSocketService(websocketUrl: 'ws://192.168.1.5:2001')),
          ),
        ],
        child: const HomePage(),
      ),
    );
  }
}
