import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef void Handler();

class AdaptiveButton extends StatelessWidget {
  final String text;
  final Handler handler;

  AdaptiveButton(this.text, this.handler);

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? FlatButton(
            child: Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
            textColor: Theme.of(context).primaryColor,
            onPressed: handler,
          )
        : CupertinoButton(
            child: Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
            // color: Theme.of(context).primaryColor,
            onPressed: handler,
          );
  }
}
