import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/user.dart';

enum RadioOptions { option1, option2, option3 }

class FormWidget extends StatefulWidget {
  final Map<String, dynamic> initialValues;

  const FormWidget({Key? key, required this.initialValues}) : super(key: key);

  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _doubleController;
  late TextEditingController _stringController;
  RadioOptions? _selectedRadio;
  bool _checkbox1 = false;
  bool _checkbox2 = false;
  bool _checkbox3 = false;
  User? _selectedUser;
  final List<User> _users = List.generate(
    10,
    (index) => User('First$index', 'Last$index'),
  );

  @override
  void initState() {
    super.initState();
    _doubleController = TextEditingController(
      text: widget.initialValues['doubleValue']?.toString() ?? '',
    );
    _stringController = TextEditingController(
      text: widget.initialValues['stringValue'] ?? '',
    );
    _selectedRadio = widget.initialValues['radioValue'];
    _checkbox1 = widget.initialValues['checkbox1'] ?? false;
    _checkbox2 = widget.initialValues['checkbox2'] ?? false;
    _checkbox3 = widget.initialValues['checkbox3'] ?? false;
    _selectedUser = widget.initialValues['dropdownValue'];
  }

  @override
  void dispose() {
    _doubleController.dispose();
    _stringController.dispose();
    super.dispose();
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      final formData = {
        'doubleValue': double.tryParse(_doubleController.text),
        'stringValue': _stringController.text,
        'radioValue': _selectedRadio,
        'checkbox1': _checkbox1,
        'checkbox2': _checkbox2,
        'checkbox3': _checkbox3,
        'dropdownValue': _selectedUser,
      };
      print(formData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Widget'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Double Input
              TextFormField(
                controller: _doubleController,
                decoration: const InputDecoration(labelText: 'Enter a number'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  final number = double.tryParse(value ?? '');
                  if (number == null) {
                    return 'Please enter a valid number';
                  }
                  if (number < 3.0 || number > 10.0) {
                    return 'Number must be between 3.00 and 10.00';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // String Input
              TextFormField(
                controller: _stringController,
                decoration: const InputDecoration(labelText: 'Enter a string'),
                maxLength: 20,
                validator: (value) {
                  if (value == null || value.length < 5) {
                    return 'String must be at least 5 characters';
                  }
                  if (value.length > 20) {
                    return 'String must not exceed 20 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Radio Buttons
              const Text('Select an option:'),
              Column(
                children: RadioOptions.values.map((option) {
                  return RadioListTile<RadioOptions>(
                    title: Text(option.toString().split('.').last),
                    value: option,
                    groupValue: _selectedRadio,
                    onChanged: (value) {
                      setState(() {
                        _selectedRadio = value;
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),

              // Checkboxes
              const Text('Select checkboxes:'),
              CheckboxListTile(
                title: const Text('Checkbox 1'),
                value: _checkbox1,
                onChanged: (value) {
                  setState(() {
                    _checkbox1 = value ?? false;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Checkbox 2'),
                value: _checkbox2,
                onChanged: (value) {
                  setState(() {
                    _checkbox2 = value ?? false;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Checkbox 3'),
                value: _checkbox3,
                onChanged: (value) {
                  setState(() {
                    _checkbox3 = value ?? false;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Dropdown
              const Text('Select a user:'),
              DropdownButtonFormField<User>(
                value: _selectedUser,
                items: _users.map((user) {
                  return DropdownMenuItem<User>(
                    value: user,
                    child: Text(user.toString()),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedUser = value;
                  });
                },
                decoration: const InputDecoration(labelText: 'User'),
                validator: (value) {
                  if (value == null) {
                    return 'Please select a user';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Save Button
              ElevatedButton(
                onPressed: _saveForm,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}