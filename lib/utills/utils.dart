import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

ShowSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}
