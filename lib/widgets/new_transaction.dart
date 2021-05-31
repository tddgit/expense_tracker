import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/widgets/adaptive_button.dart';
import 'package:intl/intl.dart';

typedef CallbackForTransaction = void Function(
    String txTitle, double txAmount, DateTime? chosenDate);

class NewTransaction extends StatefulWidget {
  final CallbackForTransaction addTx;

  const NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      ObjectFlagProperty<CallbackForTransaction>.has('addTx', addTx),
    );
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  late DateTime? _selectedDate = DateTime.now();

  void _submitData() {
    try {
      final String enteredTitle = titleController.text;
      final double enteredAmount = double.parse(amountController.text);
      if (enteredTitle.isEmpty || enteredAmount <= 0) {
        return;
      }
      widget.addTx(enteredTitle, enteredAmount, _selectedDate);

      Navigator.of(context).pop();
      // ignore: avoid_catches_without_on_clauses
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
    ).then((DateTime? pickedDate) {
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
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            children: <Widget>[
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
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  onSubmitted: (_) => _submitData(),
                ),
              if (Platform.isAndroid)
                TextField(
                  decoration: const InputDecoration(labelText: 'Title'),
                  controller: titleController,
                  keyboardType: TextInputType.text,
                  // onChanged: (value) => titleInput = value,
                ),
              if (Platform.isAndroid)
                TextField(
                  decoration: const InputDecoration(labelText: 'Amount'),
                  controller: amountController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  onSubmitted: (_) => _submitData(),
                ),
              SizedBox(
                height: 70,
                child: Row(children: <Widget>[
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No Date Chosen'
                          : 'Picked date' +
                              ': ${DateFormat.yMd().format(_selectedDate!)}',
                    ),
                  ),
                ]),
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button!.color,
                onPressed: _submitData,
                child: const Text('Add Transaction'),
              ),
              AdaptiveButton('Choose Date', _presentDatePicker),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TextEditingController>(
        'titleController', titleController));
    properties.add(
      DiagnosticsProperty<TextEditingController>(
          'amountController', amountController),
    );
  }
}
