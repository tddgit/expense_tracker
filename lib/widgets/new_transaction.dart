import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'adaptive_button.dart';

typedef void CallbackForTransaction(
    String txTitle, double txAmount, DateTime chosenDate);

class NewTransaction extends StatefulWidget {
  final CallbackForTransaction addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  late DateTime _selectedDate = DateTime.now();

  void _submitData() {
    try {
      final enteredTitle = titleController.text;
      final enteredAmount = double.parse(amountController.text);
      if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
        return;
      }
      widget.addTx(enteredTitle, enteredAmount, _selectedDate);

      Navigator.of(context).pop();
    } catch (err) {
      amountController.clear();
    }
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            children: [
              if (Platform.isIOS)
                CupertinoTextField(
                  placeholder: 'Title',
                  controller: titleController,
                  keyboardType: TextInputType.text,
                  // onChanged: (value) => titleInput = value,
                ),
              if (Platform.isIOS)
                CupertinoTextField(
                  placeholder: 'Amount',
                  controller: amountController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  onSubmitted: (_) => _submitData(),
                ),
              if (Platform.isAndroid)
                TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  controller: titleController,
                  keyboardType: TextInputType.text,
                  // onChanged: (value) => titleInput = value,
                ),
              if (Platform.isAndroid)
                TextField(
                  decoration: InputDecoration(labelText: 'Amount'),
                  controller: amountController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  onSubmitted: (_) => _submitData(),
                ),
              Container(
                height: 70,
                child: Row(children: <Widget>[
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No Date Chosen'
                          : 'Picked date : ${DateFormat.yMd().format(_selectedDate)}',
                    ),
                  ),
                ]),
              ),
              RaisedButton(
                child: Text('Add Transaction'),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button!.color,
                onPressed: _submitData,
              ),
              AdaptiveButton('Choose Date', _presentDatePicker),
            ],
          ),
        ),
      ),
    );
  }
}
