part of 'water_flow_bloc.dart';

@immutable
abstract class WaterFlowEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchAllWaterFlowData extends WaterFlowEvent {
  final List<WaterFlowModel> data;

  FetchAllWaterFlowData({required this.data});

  @override
  List<Object?> get props => [data];
}

class GetLastWaterFlow extends WaterFlowEvent {
  final WaterFlowModel data;

  GetLastWaterFlow({required this.data});

  @override
  List<Object?> get props => [data];
}

class WebSocketError extends WaterFlowEvent {
  final String error;

  WebSocketError({required this.error});

  @override
  List<Object?> get props => [error];
}
