import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/waterflow.model.dart';
import '../../services/web.socket.service.dart';

part 'water_flow_event.dart';
part 'water_flow_state.dart';

class WaterFlowBloc extends Bloc<WaterFlowEvent, WaterFlowState> {
  final WebSocketService service;
  late final StreamSubscription _subscription;

  WaterFlowBloc({required this.service}) : super(WaterFlowInitial()) {
    _subscription = service.stream.listen(
          (parsedData) {
        if (parsedData['type'] == 'waterflow' && parsedData['category'] == 'all') {
          final List<WaterFlowModel> waterFlowData = (parsedData['data'] as List)
              .map((item) => WaterFlowModel.fromJson(item))
              .toList();

          add(FetchAllWaterFlowData(data: waterFlowData));
        } else if (parsedData['type'] == 'waterflow' && parsedData['category'] == 'last') {
          final lastWaterFlowData = WaterFlowModel.fromJson(parsedData['data']);
          add(GetLastWaterFlow(data: lastWaterFlowData));
        } else {
          print('Unsupported type or category: ${parsedData['type']} ${parsedData['category']}');
        }
      },
      onError: (error) => add(WebSocketError(error: error.toString())),
      cancelOnError: true,
    );

    on<FetchAllWaterFlowData>((event, emit) {
      emit(WaterFlowLoaded(data: event.data));
    });

    on<GetLastWaterFlow>((event, emit) {
      emit(WaterFlowLastLoaded(data: event.data));
    });

    on<WebSocketError>((event, emit) {
      emit(WaterFlowError(message: event.error));
    });
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    service.dispose();
    return super.close();
  }
}
