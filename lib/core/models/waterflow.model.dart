import 'package:cloud_firestore/cloud_firestore.dart';

import 'item.model.dart';

class WaterFlowModel extends ItemModel{
  final double flowRate;

  WaterFlowModel({required super.id, required this.flowRate,  required super.time});

  factory WaterFlowModel.fromJson(Map<String, dynamic> json) {
    return WaterFlowModel(
      id: json['id'] ?? '',
      flowRate: (json['flowRate'] as num).toDouble(),
      time: json['time'] != null
          ? Timestamp(json['time']['_seconds'], json['time']['_nanoseconds'])
          : Timestamp.now(),
    );
  }

}