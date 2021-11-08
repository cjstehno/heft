import 'package:flutter/material.dart';
import 'package:heft/providers/weight_records.dart';
import 'package:heft/screens/weight_record_screen.dart';
import 'package:heft/widgets/record_trend.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WeightLog extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    context.watch<WeightRecords>();
    final records = context.read<WeightRecords>().records;

    return Container(
      margin: const EdgeInsets.only(top: 2),
      child: records.isNotEmpty
          ? ListView.builder(
              itemCount: records.length,
              itemBuilder: (ctx, idx) {
                return Dismissible(
                  key: ValueKey(records[idx].id),
                  direction: DismissDirection.endToStart,
                  background: DismissibleBackground(),
                  child: ListTile(
                    leading: Container(
                      width: 100,
                      child: Text(
                        DateFormat('M/d/yyyy').format(records[idx].timestamp),
                        style: const TextStyle(fontSize: 16),
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    title: Center(
                      child: Text(
                        records[idx].weight.toString(),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    trailing: RecordTrend(
                      records[idx],
                      idx + 1 < records.length ? records[idx + 1] : null,
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        WeightRecordScreen.routeName,
                        arguments: records[idx],
                      );
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
                    context.read<WeightRecords>().remove(removedRecord.id!);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Record for ${DateFormat('M/d/yyyy').format(removedRecord.timestamp)} was deleted.',
                        ),
                        duration: const Duration(seconds: 3),
                      ),
                    );
                  },
                );
              },
            )
          : const Center(
              child: Text(
                'No records.',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
              ),
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
