import 'package:expenses_planning_app/widgets/chart.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'widgets/transaction_list_element.dart';
import 'widgets/new_transaction.dart';
import 'models/transaction.dart';

void main() {
  /*WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);*/
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal expences',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _addNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: NewTransaction(_addTransaction),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  final List<Transaction> _listOfTransactions = [
    Transaction(
      "001",
      "title1",
      200,
      DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      "002",
      "title2",
      32,
      DateTime.now().subtract(Duration(days: 2)),
    ),
  ];

  void _addTransaction(String title, double amount, DateTime date) {
    final newTransaction = new Transaction(
      DateTime.now().toString(),
      title,
      amount,
      date,
    );

    setState(() {
      _listOfTransactions.add(newTransaction);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _listOfTransactions.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  List<Transaction> get _recentTransactions {
    return _listOfTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text("Planning app"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            _addNewTransaction(context);
          },
        )
      ],
    );

    final appBarHeight = appBar.preferredSize.height;

    return Scaffold(
      appBar: appBar,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _addNewTransaction(context);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBarHeight -
                      MediaQuery.of(context).padding.top) *
                  0.3,
              child: Chart(_recentTransactions),
            ),
            Card(
              child: Container(
                width: double.infinity,
              ),
            ),
            Container(
                height: (MediaQuery.of(context).size.height -
                        appBarHeight -
                        MediaQuery.of(context).padding.top) *
                    0.7,
                child:
                    TransactionList(_listOfTransactions, _deleteTransaction)),
          ],
        ),
      ),
    );
  }
}
