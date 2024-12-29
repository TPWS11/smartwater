part of 'soil_moisture_bloc.dart';

@immutable
abstract class SoilMoistureEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class FetchSoilMoistureData extends SoilMoistureEvent {
  final List<SoilMoistureModel> data;

  FetchSoilMoistureData({required this.data});

  @override
  List<Object?> get props => [data];
}

class WebSocketError extends SoilMoistureEvent {
  final String error;

  WebSocketError({required this.error});

  @override
  List<Object?> get props => [error];
}
