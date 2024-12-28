import 'package:flutter/material.dart';
import 'package:smartwater/core/models/waterflow.model.dart';

class LastWaterFlowScreen extends StatelessWidget {
  final WaterFlowModel? model;
  const LastWaterFlowScreen(this.model, {super.key});

  @override
  Widget build(BuildContext context) {
    if(model == null) {
      return const SizedBox.shrink();
    }
    return Text('Flow Rate: ${model?.flowRate}');
  }
}
