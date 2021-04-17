import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  DateTime _dateValue;

  void _submitData() {
    if (_titleController.text.isEmpty ||
        _amountController.text.isEmpty ||
        double.parse(_amountController.text) <= 0 ||
        _dateValue == null) {
      return;
    }

    widget.addTx(
      _titleController.text,
      double.parse(_amountController.text),
      _dateValue,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime.now(),
    ).then((date) {
      if (date == null) {
        return;
      }
      setState(() {
        _dateValue = date;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Card(
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Text'),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      child: Text(_dateValue == null
                          ? "Choose Date"
                          : "Date : ${_dateValue.day}/${_dateValue.month}/${_dateValue.year}")),
                  TextButton(
                    onPressed: _presentDatePicker,
                    child: Text("Choose date"),
                  ),
                ],
              ),
              TextButton(
                onPressed: _submitData,
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColorDark,)),
                child: Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
