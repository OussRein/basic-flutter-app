import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String day;
  final double amount;
  final double total;

  ChartBar(this.day, this.amount, this.total);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: <Widget>[
          Container(
            height: constraints.maxHeight * 0.1,
            child: Text("\$${amount.toStringAsFixed(0)}"),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.1,
          ),
          Container(
            height: constraints.maxHeight * 0.6,
            width: 10,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).primaryColorDark,
                      width: 1,
                    ),
                    color: Theme.of(context).primaryColorDark,
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: 1 - total,
                  child: Container(
                    alignment: FractionalOffset.bottomCenter,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.1,
          ),
          Container(
            height: constraints.maxHeight * 0.1,
            child: Text(day),
          ),
        ],
      );
    });
  }
}
