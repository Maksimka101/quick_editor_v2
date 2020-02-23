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

  const FabScaffold(
      {Key key,
      this.scrollController,
      this.body,
      this.appBar,
      this.fabChild,
      this.speedDialChild = const [],
      this.onFabTab})
      : super(key: key);

  @override
  _FabScaffoldState createState() => _FabScaffoldState();
}

class _FabScaffoldState extends State<FabScaffold> {
  var _fabVisible = true;

  @override
  void initState() {
    widget.scrollController.addListener(() {
      _fabVisible = widget.scrollController.position.userScrollDirection ==
          ScrollDirection.forward;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      body: widget.body,
      floatingActionButton: SpeedDial(
        overlayColor: Colors.transparent,
        visible: _fabVisible,
        children: widget.speedDialChild,
        onPress: widget.onFabTab,
        overlayOpacity: 0,
        child: widget.fabChild,
      ),
    );
  }
}
