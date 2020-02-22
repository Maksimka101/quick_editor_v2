import 'package:flutter/material.dart';
import 'package:quick_editor_v2/ui/widget/error.dart';

class ErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
	    body: ErrorMessage(),
    );
  }
}
