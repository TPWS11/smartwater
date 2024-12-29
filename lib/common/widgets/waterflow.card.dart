import 'package:flutter/material.dart';
import 'package:smartwater/core/models/waterflow.model.dart';

class FlowRateBlinkCircle extends StatefulWidget {
  final WaterFlowModel data;

  const FlowRateBlinkCircle({super.key, required this.data});

  @override
  State<FlowRateBlinkCircle> createState() => _FlowRateBlinkCircleState();
}

class _FlowRateBlinkCircleState extends State<FlowRateBlinkCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _iconColorAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true); // Repeat back and forth

    _iconColorAnimation = ColorTween(
      begin: const Color(0xFF074799), // Dark blue
      end: const Color(0xFF81BFDA), // Light blue
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WaterFlowModel model = widget.data;
    return SizedBox(
      child: model.flowRate != 0.0
          ? AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Row(
            children: [
              Icon(
                Icons.water_drop,
                size: 42.0,
                color: _iconColorAnimation.value, // Icon color animation
              ),

              const SizedBox(width: 15.0,),

              Text(model.flowRate.toString(),
                style: TextStyle(
                  color: _iconColorAnimation.value,
                  fontWeight: FontWeight.w700,
                  fontSize: 28.0,
                ),
              ),

              const Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: Text(' L/s',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        },
      )
          : Row(
        children: [
          const Icon(
            Icons.water_drop,
            size: 42.0,
            color: Colors.black87, // Icon color animation
          ),

          const SizedBox(width: 15.0,),

          Text(model.flowRate.toString(),
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w700,
              fontSize: 28.0,
            ),
          ),

          const Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: Text(' L/s',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
