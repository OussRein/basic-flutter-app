import 'package:expenses_planning_app/models/transaction.dart';
import 'package:expenses_planning_app/widgets/chart_bar.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionsVals {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: 6 - index));
      var sum = 0.0;
      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          sum += recentTransactions[i].amount;
        }
      }
      return {
        "day": weekDay.day.toString() + "/" + weekDay.month.toString(),
        "amount": sum
      };
    });
  }

  double get max {
    return groupedTransactionsVals.fold(0.0, (sum, element) {
      return sum + element["amount"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionsVals.map((chart) {
          return ChartBar(
            chart["day"],
            chart["amount"],
            max == 0 ? 0.0 : (chart["amount"] as double) / max,
          );
        }).toList()),
      ),
    );
  }
}
