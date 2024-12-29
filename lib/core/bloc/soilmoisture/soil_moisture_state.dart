part of 'soil_moisture_bloc.dart';

@immutable
abstract class SoilMoistureState extends Equatable{
  @override
  List<Object?> get props => [];
}

class SoilMoistureInitial extends SoilMoistureState {}

class SoilMoistureLoading extends SoilMoistureState {}

class SoilMoistureLoaded extends SoilMoistureState {
  final List<SoilMoistureModel> data;

  SoilMoistureLoaded({required this.data});

  @override
  List<Object?> get props => [data];
}

class SoilMoistureError extends SoilMoistureState {
  final String message;

  SoilMoistureError({required this.message});

  @override
  List<Object?> get props => [message];
}
