part of 'water_flow_bloc.dart';

@immutable
abstract class WaterFlowState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WaterFlowInitial extends WaterFlowState {}

class WaterFlowLoading extends WaterFlowState {}

class WaterFlowLoaded extends WaterFlowState {
  final List<WaterFlowModel> data;

  WaterFlowLoaded({required this.data});

  @override
  List<Object?> get props => [data];
}


class WaterFlowError extends WaterFlowState {
  final String message;

  WaterFlowError({required this.message});

  @override
  List<Object?> get props => [message];
}