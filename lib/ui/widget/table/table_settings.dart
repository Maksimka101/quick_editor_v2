import 'package:flutter/material.dart';
import 'package:quick_editor_v2/bloc/navigation_bloc.dart';
import 'package:quick_editor_v2/model/abstract/table_item.dart' as ct;
import 'package:quick_editor_v2/utils/validators/table_settings.dart';

void showTableSettingsBottomSheet(BuildContext context, ct.Table table,
    void Function(ct.Table table) onUpdate) {
  var _table = table;
  final _settingsValidator = TableSettingsValidator();
  final _formKey = GlobalKey<FormState>();

  void _save() {
    if (_formKey.currentState.validate()) {
      _table = _table.copyWith(name: _settingsValidator.tableName);
      onUpdate(_table);
      NavigatorBloc.instance.add(Pop());
    }
  }

  showBottomSheet<Widget>(
    context: context,
    builder: (context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 3),
              TextFormField(
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
    ),
  );
}
