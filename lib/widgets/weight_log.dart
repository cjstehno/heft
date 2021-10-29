import 'package:flutter/material.dart';

class WeightLog extends StatelessWidget {
  const WeightLog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final records = [
      300,
      298,
      245,
      230,
      228,
      229,
      220,
      123,
      122,
      145,
      100,
      98,
      90
    ];

    // FIXME: maybe add a heading to the table "History"?

    const textStyle = TextStyle(fontSize: 18);

    return Container(
      // FIXME: calculate the height like I did in penguin
      height: 580,
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: records.length,
        // shrinkWrap: true,
        // physics: AlwaysScrollableScrollPhysics(),
        itemBuilder: (ctx, idx) {
          return ListTile(
            leading: Container(
              width: 100,
              child: Column(
                children: const [
                  Text(
                    '10/01/2021',
                    style: textStyle,
                  ),
                  Text('09:15 am'),
                ],
              ),
              padding: const EdgeInsets.only(top: 10),
              alignment: Alignment.centerLeft,
            ),
            title: Center(
                child: Text(
              records[idx].toString(),
              style: textStyle,
            )),
            trailing: SizedBox(
              width: 45,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Icon(Icons.arrow_downward),
                  Text(
                    '2',
                    style: textStyle,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
