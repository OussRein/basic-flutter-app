import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _listOfTransactions;

  final Function _deleteTx;

  TransactionList(this._listOfTransactions, this._deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(10, 5, 20, 5),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).primaryColorDark,
                      width: 3,
                    ),
                  ),
                  child: Text(
                    '\$${_listOfTransactions[index].amount}',
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: 23 * MediaQuery.of(context).textScaleFactor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _listOfTransactions[index].title,
                        style: TextStyle(
                          fontSize: 20 * MediaQuery.of(context).textScaleFactor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(_listOfTransactions[index].date.day.toString() + "/" + _listOfTransactions[index].date.month.toString() + "/" + _listOfTransactions[index].date.year.toString()),
                    ],
                  ),
                ),
                TextButton(
                  child: Icon(Icons.delete, color: Colors.red,),
                  onPressed: () {_deleteTx(_listOfTransactions[index].id);},
                )
              ],
            ),
          );
        },
        itemCount: _listOfTransactions.length,
      ),
    );
  }
}
