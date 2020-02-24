import 'package:flutter/material.dart';
import 'package:quick_editor_v2/bloc/navigation_bloc.dart';
import 'package:quick_editor_v2/model/abstract/table_item.dart' as ct;
import 'package:quick_editor_v2/utils/validators/table_settings.dart';

class TableSettings extends StatelessWidget {
  final _settingsValidator = TableSettingsValidator();
  final _formKey = GlobalKey<FormState>();
  final ct.Table table;
  final void Function(ct.Table table) onUpdate;

  TableSettings({Key key, this.table, this.onUpdate}) : super(key: key);
  void _save() {
    if (_formKey.currentState.validate()) {
      onUpdate(table.copyWith(name: _settingsValidator.tableName));
      NavigatorBloc.instance.add(Pop());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 3),
              TextFormField(
                initialValue: table.name,
                decoration:
                    const InputDecoration(labelText: "Counter table name"),
                validator: _settingsValidator.tableNameValidator,
              ),
              RaisedButton(
                onPressed: _save,
                child: const Text("Save"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
