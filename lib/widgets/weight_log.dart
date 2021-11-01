import 'package:flutter/material.dart';
import 'package:heft/providers/weight_records.dart';
import 'package:heft/screens/weight_record_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WeightLog extends StatelessWidget {
  const WeightLog({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    context.watch<WeightRecords>();
    final records = context.read<WeightRecords>().records;

    return Container(
      // FIXME: calculate the height like I did in penguin
      height: 580,
      child: ListView.builder(
        itemCount: records.length,
        // shrinkWrap: true,
        // physics: AlwaysScrollableScrollPhysics(),
        itemBuilder: (ctx, idx) {
          final dateFormat = DateFormat('M/d/yyyy');
          final timeFormat = DateFormat('H:mm a');
          const textStyle = TextStyle(fontSize: 18);

          return ListTile(
            key: ValueKey(records[idx].id),
            leading: Container(
              width: 100,
              child: Column(
                children: [
                  Text(
                    dateFormat.format(records[idx].timestamp),
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    timeFormat.format(records[idx].timestamp),
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
              padding: const EdgeInsets.only(top: 10),
              alignment: Alignment.centerLeft,
            ),
            title: Center(
              child: Text(records[idx].weight.toString(), style: textStyle),
            ),
            trailing: SizedBox(
              width: 45,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Icon(
                    Icons.arrow_downward,
                    color: Colors.green,
                  ),
                  Text(
                    '2',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            onTap: (){
              Navigator.of(context).pushNamed(WeightRecordScreen.routeName, arguments: records[idx]);
            },
          );
        },
      ),
    );
  }
}
