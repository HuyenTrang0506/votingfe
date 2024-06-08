import 'package:flutter/material.dart';
import 'package:flutter_application/models/user.dart';
import 'package:flutter_application/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class bill extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    final user = authViewModel.userCurrentModel;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Invoice Generator',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: InvoiceForm(user: user),
    );
  }
}

class InvoiceForm extends StatefulWidget {
  final UserModel user;

  InvoiceForm({required this.user});
  @override
  _InvoiceFormState createState() => _InvoiceFormState();
}

class _InvoiceFormState extends State<InvoiceForm> {
  final _formKey = GlobalKey<FormState>();

  final List<Item> _items = [
    Item(description: "Premium Account Upgrade", quantity: 1, unitPrice: 29.99)
  ];

  String? _bankAccountNumber;

  @override
  Widget build(BuildContext context) {
    UserModel user = context.watch<AuthViewModel>().userCurrentModel;
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice Generator'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Full Name: ${user.fullname}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  'Email: ${user.email}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Divider(),
                SizedBox(height: 20),
                ..._items.map((item) {
                  int index = _items.indexOf(item);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${item.description}: \$${item.unitPrice.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                    ],
                  );
                }).toList(),
                Divider(),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Bank Account Number',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _bankAccountNumber = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your bank account number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _showInvoice(context, user);
                      }
                    },
                    child: Text('Generate Invoice'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showInvoice(BuildContext context, UserModel user) {
    final invoiceId = 'INV-${DateTime.now().millisecondsSinceEpoch}';
    final date = DateTime.now().toString().split(' ')[0];
    final dueDate =
        DateTime.now().add(Duration(days: 30)).toString().split(' ')[0];
    final fullname = user.fullname;
    final email = user.email;
    final totalAmount = _items.fold(0.0, (sum, item) => sum + item.total);

    showDialog(
      context: context,
      builder: (context) {
        return InvoiceDialog(
          invoiceId: invoiceId,
          date: date,
          dueDate: dueDate,
          fullname: fullname ?? '',
          email: email ?? '',
          items: _items,
          totalAmount: totalAmount,
          bankAccountNumber: _bankAccountNumber ?? '',
          onClose: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}

class InvoiceDialog extends StatelessWidget {
  final String invoiceId;
  final String date;
  final String dueDate;
  final String fullname;
  final String email;
  final List<Item> items;
  final double totalAmount;
  final String bankAccountNumber;
  final VoidCallback onClose;

  const InvoiceDialog({
    required this.invoiceId,
    required this.date,
    required this.dueDate,
    required this.fullname,
    required this.email,
    required this.items,
    required this.totalAmount,
    required this.bankAccountNumber,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Invoice'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10),
            Text('Invoice ID: $invoiceId'),
            SizedBox(height: 10),
            Text('Date: $date'),
            SizedBox(height: 10),
            Text('Due Date: $dueDate'),
            SizedBox(height: 10),
            Text('Full Name: $fullname'),
            SizedBox(height: 10),
            Text('Email: $email'),
            Divider(),
            SizedBox(height: 20),
            Text(
              'Items:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ...items.map((item) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  '${item.description}: \$${item.unitPrice.toStringAsFixed(2)}',
                ),
              );
            }).toList(),
            Divider(),
            SizedBox(height: 20),
            Text(
              'Total Amount: \$${totalAmount.toStringAsFixed(2)}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Bank Account Number: $bankAccountNumber',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: onClose,
          child: Text('Close'),
        ),
      ],
    );
  }
}

class Item {
  String description;
  int quantity;
  double unitPrice;

  Item({this.description = '', this.quantity = 1, this.unitPrice = 0.0});

  double get total => quantity * unitPrice;
}
