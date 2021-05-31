import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef void Handler();

class AdaptiveButton extends StatelessWidget {
  final String text;
  final Handler handler;

  const AdaptiveButton(this.text, this.handler);

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? FlatButton(
            textColor: Theme.of(context).primaryColor,
            onPressed: handler,
            child:
                Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
          )
        : CupertinoButton(
            onPressed: handler,
            child:
                Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
          );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('text', text));
    properties.add(ObjectFlagProperty<Handler>.has('handler', handler));
  }
}
