import 'package:flutter/material.dart';
import 'package:quick_editor_v2/model/abstract/table_item.dart' as ct;

class CounterTableWidget extends StatefulWidget {
  final ct.Table table;
  final void Function() onTap;
  final void Function() onDeleteAnimationEnded;
  final bool runDeleteAnimation;
  final Duration deletingDuration;

  const CounterTableWidget(
      {Key key,
      @required this.table,
      this.onTap,
      this.runDeleteAnimation = false,
      this.onDeleteAnimationEnded,
      this.deletingDuration = const Duration(milliseconds: 300)})
      : super(key: key);

  @override
  _CounterTableWidgetState createState() => _CounterTableWidgetState();
}

class _CounterTableWidgetState extends State<CounterTableWidget>
    with SingleTickerProviderStateMixin {
  bool _inited = false;
  Future<void> _startDeleting() async {
    await Future<int>.delayed(Duration.zero)
        .then((value) => setState(() => _inited = true));
    await Future<int>.delayed(widget.deletingDuration);
    widget.onDeleteAnimationEnded();
  }

  @override
  Widget build(BuildContext context) {
    if (!_inited && widget.runDeleteAnimation) {
      _startDeleting();
    }
    return AnimatedSize(
      vsync: this,
      duration: widget.deletingDuration,
      child: Opacity(
        opacity: widget.runDeleteAnimation ? 0 : 1,
        child: SizedBox(
          height: _inited ? 0 : null,
          child: ListTile(
            onTap: widget.onTap,
            title: Text(widget.table.name),
          ),
        ),
      ),
    );
  }
}
