import 'item.model.dart';

class WaterFlowModel extends ItemModel{
  final double flowRate;

  WaterFlowModel({required super.id, required this.flowRate,  required super.time});

  factory WaterFlowModel.fromJson(Map<String, dynamic> json) {
    return WaterFlowModel(
      id: json['id'] ?? '',
      flowRate: json['flowRate'] ?? 0.0,
      time: json['timestamp'] != null ? DateTime.parse(json['timestamp']) : DateTime.now(),
    );
  }

}