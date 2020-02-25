import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

/// use this scaffold with fab and list view to hide fab on scroll
class FabScaffold extends StatefulWidget {
  final ScrollController scrollController;
  final Widget body;
  final AppBar appBar;
  final Widget fabChild;
  final List<SpeedDialChild> speedDialChild;
  final void Function() onFabTab;

  const FabScaffold({
    this.scrollController,
    this.body,
    this.appBar,
    this.fabChild,
    this.speedDialChild = const [],
    this.onFabTab,
  });

  @override
  _FabScaffoldState createState() => _FabScaffoldState();
}

class _FabScaffoldState extends State<FabScaffold> {
  var _fabVisible = true;

  void _listenForScroll() => widget.scrollController.addListener(() {
        print('_FabScaffoldState.initState');
        _fabVisible = widget.scrollController.position.userScrollDirection ==
            ScrollDirection.forward;
        setState(() {});
      });

  @override
  Widget build(BuildContext context) {
    print('_FabScaffoldState.build');
    print(widget.scrollController.hashCode);
    _listenForScroll();
    return Scaffold(
      appBar: widget.appBar,
      body: widget.body,
      // Если использовать SpeedDial без обертеки в виде FAB, то он будет
      // не корректно реагировать на bottom sheets
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.transparent,
        elevation: 0,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        splashColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        child: SpeedDial(
          overlayColor: Colors.transparent,
          visible: _fabVisible,
          children: widget.speedDialChild,
          onPress: widget.onFabTab,
          overlayOpacity: 0,
          child: widget.fabChild,
        ),
      ),
    );
  }
}
