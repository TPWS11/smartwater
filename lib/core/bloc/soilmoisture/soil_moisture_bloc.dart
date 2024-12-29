import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:smartwater/core/models/soilmoisture.model.dart';
import 'package:smartwater/core/services/web.socket.service.dart';

part 'soil_moisture_event.dart';
part 'soil_moisture_state.dart';

class SoilMoistureBloc extends Bloc<SoilMoistureEvent, SoilMoistureState> {
  final WebSocketService service;
  late final StreamSubscription _subscription;

  SoilMoistureBloc({required this.service}) : super(SoilMoistureInitial()) {
    _subscription = service.stream.listen(
        (parsedData) {
          if(parsedData['type'] == 'soil') {
            final List<SoilMoistureModel> soilData = (parsedData['data'] as List)
                .map((item) => SoilMoistureModel.fromJson(item))
                .toList();

            add(FetchSoilMoistureData(data: soilData));
          }else {
            print('Unsupported type or category: ${parsedData['type']} ${parsedData['category']}');
          }
        },
      onError: (error) => add(WebSocketError(error: error.toString())),
      cancelOnError: true,
    );

    on<FetchSoilMoistureData>((event, emit) {
      emit(SoilMoistureLoaded(data: event.data));
    });

    on<WebSocketError>((event, emit) {
      emit(SoilMoistureError(message: event.error));
    });
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    service.dispose();
    return super.close();
  }
}

