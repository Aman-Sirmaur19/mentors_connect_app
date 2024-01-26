import 'package:flutter/material.dart';

import 'otp_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  // final _amountController = TextEditingController();
  // final _dateinputController = TextEditingController();
  // final _collegeController = TextEditingController();
  // DateTime? _selectedDate;

  @override
  void initState() {
    print('initState()');
    super.initState();
  }

  @override
  void didUpdateWidget(LoginPage oldWidget) {
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
        title: Text('SignUp'),
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
              Container(
                height: MediaQuery.of(context).size.height * 0.35,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/login.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Email',
                ),
                controller: _emailController,
                onSubmitted: (_) => _submitData(),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                    hintText: "Phone no.", icon: Icon(Icons.phone)),
                controller: _phoneController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                onSaved: (_) => _submitData(),
                decoration: InputDecoration(
                  hintText: "Mentor / Student",
                  icon: Icon(Icons.school),
                ),
                items: <String>['Mentor', 'Student'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
                onChanged: (_) {},
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Send OTP', style: TextStyle(color: Colors.white)),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).primaryColor,
                  ),
                ),
                onPressed: () =>
                    Navigator.of(context).pushNamed(OtpPage.routeName),
              ),
              SizedBox(height: 110),
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
