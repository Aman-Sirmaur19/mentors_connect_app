import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './mentors_screen.dart';

class UserDetails extends StatefulWidget {
  static const routeName = '/user-details';

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  // final _amountController = TextEditingController();
  final _dateinputController = TextEditingController();
  final _collegeController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void initState() {
    print('initState()');
    super.initState();
  }

  @override
  void didUpdateWidget(UserDetails oldWidget) {
    print('didUpdateWidget()');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print('dispose()');
    super.dispose();
  }

  void _submitData() {
    // if (_amountController.text.isEmpty) return;
    // final enteredTitle = _nameController.text;
    // final enteredAmount = double.parse(_amountController.text);

    // if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null)
    //   return;
    //
    // widget.addTx(enteredTitle, enteredAmount, _selectedDate);
    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Profile'),
        foregroundColor: Theme.of(context).colorScheme.background,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
          ),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.blue.shade100,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.person,
                      size: 48,
                    ),
                  )),
              TextField(
                decoration: InputDecoration(
                  labelText: "Name",
                  icon: Icon(Icons.person),
                ),
                controller: _nameController,
                onSubmitted: (_) => _submitData(),
              ),
              DropdownButtonFormField<String>(
                onSaved: (_) => _submitData(),
                decoration: InputDecoration(
                  labelText: "Gender",
                  icon: Icon(Icons.person_outline),
                ),
                items: <String>['Male', 'Female', 'Other'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
                onChanged: (_) {},
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Email",
                  icon: Icon(Icons.email),
                ),
                controller: _emailController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: "Phone no.", icon: Icon(Icons.phone)),
                controller: _phoneController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                controller: _dateinputController,
                //editing controller of this TextField
                decoration: InputDecoration(
                  icon: Icon(Icons.calendar_today),
                  labelText: "D-O-B",
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now());

                  if (pickedDate != null) {
                    print(pickedDate);
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    print(formattedDate);

                    setState(() {
                      _dateinputController.text = formattedDate;
                    });
                  } else {
                    print("Date is not selected");
                  }
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "College",
                  icon: Icon(Icons.school),
                ),
                controller: _collegeController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Specification",
                  icon: Icon(Icons.book),
                ),
                controller: _collegeController,
                onSubmitted: (_) => _submitData(),
              ),
              ElevatedButton(
                child: Text('Save', style: TextStyle(color: Colors.white)),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).primaryColor,
                  ),
                ),
                onPressed: () =>
                    Navigator.of(context).pushNamed(MentorsScreen.routeName),
              ),
              SizedBox(height: 87),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Mentors',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      color: Colors.blue,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green,
                    ),
                    child: Text(
                      'CONNECT',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
