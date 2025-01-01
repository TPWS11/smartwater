import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyList extends StatelessWidget {
  final List<dynamic>? data;
  final String type;
  final int? length;
  final ScrollPhysics? physics;
  const MyList({super.key, this.data, required this.type, this.length = 4, this.physics});

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.builder(
        itemCount: data?.isNotEmpty ?? false ? data!.length : length,
        shrinkWrap: true,
        physics: physics ?? const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          if (data?.isNotEmpty ?? false) {
            final item = data![index];
            String formattedTime =
            DateFormat('yyyy-MM-dd HH:mm:ss').format(item.time.toDate());
            return MyListTile(
              type: type,
              number: type == 'Flow Rate' ? '${item.flowRate} L/min' : '${item.moistureLevel.toStringAsFixed(2)}%',
              time: formattedTime,
            );
          }
          return MyListTile(type: type, number: 'Initializing...', time: '--',);
        },
      ),
    );
  }
}

class MyListTile extends StatelessWidget {
  final String? number;
  final String? time;
  final String type;
  const MyListTile({super.key, this.number, this.time, required this.type});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: type == 'Flow Rate' ? const Icon(Icons.water_drop) : const Icon(Icons.terrain),
      title: Text('$type : $number'),
      subtitle: Text('Time: $time'),
    );
  }
}
