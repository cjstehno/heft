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

    // FIXME: when coming back from record screen I keep getting view overflow

    return Container(
      // FIXME: calculate the height like I did in penguin
      height: 575,
      child: ListView.builder(
        itemCount: records.length,
        // shrinkWrap: true,
        // physics: AlwaysScrollableScrollPhysics(),
        itemBuilder: (ctx, idx) {
          final dateFormat = DateFormat('M/d/yyyy');
          final timeFormat = DateFormat('H:mm a');
          const textStyle = TextStyle(fontSize: 18);

          return Dismissible(
            key: ValueKey(records[idx].id),
            direction: DismissDirection.endToStart,
            background: DismissibleBackground(),
            child: ListTile(
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
              onTap: () {
                Navigator.of(context).pushNamed(WeightRecordScreen.routeName,
                    arguments: records[idx]);
              },
            ),
            confirmDismiss: (direction) {
              return showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Are you sure?'),
                  content: const Text(
                    'Do you want to permanently delete the record?',
                  ),
                  actions: [
                    TextButton(
                      child: const Text('No'),
                      onPressed: () => Navigator.of(ctx).pop(false),
                    ),
                    TextButton(
                      child: const Text('Yes'),
                      onPressed: () => Navigator.of(ctx).pop(true),
                    ),
                  ],
                ),
              );
            },
            onDismissed: (direction) {
              final removedRecord = records[idx];
              context.read<WeightRecords>().remove(removedRecord.id);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Record for ${DateFormat('M/d/yyyy HH:mm a').format(removedRecord.timestamp)} was deleted.',
                  ),
                  duration: const Duration(seconds: 3),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DismissibleBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
              child: Container(
            alignment: Alignment.centerRight,
            child: const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(Icons.delete, color: Colors.red),
            ),
          )),
        ],
      ),
    );
  }
}
