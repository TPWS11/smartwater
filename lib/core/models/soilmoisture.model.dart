import 'package:smartwater/core/models/item.model.dart';

class SoilMoistureModel extends ItemModel {
  final double moistureLevel;

  SoilMoistureModel({required super.id, required super.time, required this.moistureLevel});

  factory SoilMoistureModel.fromJson(Map<String, dynamic> json) {
    return SoilMoistureModel(
      id: json['id'],
      moistureLevel: json['moistureLevel'],
      time: DateTime.parse(json['time']),
    );
  }
}