import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 89.99,
      date: DateTime.now(),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ExpenseTracker App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter App'),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Card(
                color: Colors.blue,
                child: Container(
                  width: double.infinity,
                  child: Text('CHART!'),
                ),
              ),
              Card(
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(labelText: 'Title'),
                      ),
                      TextField(
                        decoration: InputDecoration(labelText: 'Amount'),
                      ),
                      FlatButton(
                        child: Text('Add Transaction',
                            style: TextStyle(color: Colors.purple)),
                        onPressed: () => {},
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: transactions.map(
                  (tx) {
                    return Container(
                      width: double.infinity,
                      child: Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 15,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.purple,
                                  width: 2,
                                ),
                              ),
                              padding: EdgeInsets.all(10),
                              child: Text(
                                '\$${tx.amount.toString()}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.purple,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 15,
                              ),
                              decoration: BoxDecoration(
                                  // border: Border.all(
                                  //   color: Colors.purple,
                                  //   width: 2,
                                  // ),
                                  ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text(
                                      '${tx.title}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      DateFormat.MMMMEEEEd().format(tx.date),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
