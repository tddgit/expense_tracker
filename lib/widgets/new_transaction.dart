import 'package:flutter/material.dart';

typedef void CallbackForTransaction(String txTitle, double txAmount);

class NewTransaction extends StatefulWidget {
  final CallbackForTransaction addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    try {
      final enteredTitle = titleController.text;
      final enteredAmount = double.parse(amountController.text);
      if (enteredTitle.isEmpty || enteredAmount <= 0) {
        return;
      }
      widget.addTx(enteredTitle, enteredAmount);

      Navigator.of(context).pop();
    } catch (err) {
      amountController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              keyboardType: TextInputType.text,
              // onChanged: (value) => titleInput = value,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => submitData(),
            ),
            FlatButton(
              child: Text('Add Transaction',
                  style: TextStyle(color: Colors.purple)),
              onPressed: submitData,
            )
          ],
        ),
      ),
    );
  }
}
