// ignore_for_file: sort_child_properties_last, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kings_connect/constants/colors.dart';

class CreditCardInputForm extends StatefulWidget {
  const CreditCardInputForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CreditCardInputFormState createState() => _CreditCardInputFormState();
}

class _CreditCardInputFormState extends State<CreditCardInputForm> {
  final _formKey = GlobalKey<FormState>();
  String? _cardHolder;
  String? _cardNumber;
  String? _expirationDate;
  String? _cvc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Credit Card'),
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(
                label: 'Card holder*',
                onSaved: (value) => _cardHolder = value,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'Credit/debit card number*',
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(16),
                  _CardNumberFormatter(),
                ],
                onSaved: (value) => _cardNumber = value,
                suffixIcon: Image.asset('assets/images/mastercard.png', width: 32),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      label: 'Expiration month and year*',
                      keyboardType: TextInputType.datetime,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                        _ExpirationDateFormatter(),
                      ],
                      onSaved: (value) => _expirationDate = value,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                      label: 'CVC*',
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                      ],
                      onSaved: (value) => _cvc = value,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                '*This field is mandatory',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      child: const Text('Cancel',
                      style: TextStyle(
                        letterSpacing: -1,
                      ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      child: const Text('Update',
                      style: TextStyle(
                        letterSpacing: -1,
                        color: AppColors.white
                      ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                      ),
                      onPressed: _submitForm,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      backgroundColor: AppColors.white,
    );
  }

  Widget _buildTextField({
    required String label,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    Function(String?)? onSaved,
    Widget? suffixIcon,
  }) {
    return TextFormField(
  decoration: InputDecoration(
    labelText: label,
    labelStyle: const TextStyle(color: AppColors.cardColor), // Hint text color
    border: const OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.primary, // Default border color when not focused
      ),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.primary, // Border color when focused
        width: 2.0, // You can customize the width as well
      ),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.primary, // Border color when enabled but not focused
        width: 2.0,
      ),
    ),
    suffixIcon: suffixIcon,
    hintStyle: const TextStyle(
      color: AppColors.cardColor, // Color for hint text
    ),
  ),
  keyboardType: keyboardType,
  inputFormatters: inputFormatters,
  cursorColor: AppColors.primary, // Set the cursor color
  onSaved: onSaved,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  },
);

  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Process the credit card information
      print('Card Holder: $_cardHolder');
      print('Card Number: $_cardNumber');
      print('Expiration Date: $_expirationDate');
      print('CVC: $_cvc');
    }
  }
}

class _CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write(' ');
      }
    }
    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}

class _ExpirationDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text;
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    var buffer = StringBuffer();
    for (int i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != newText.length) {
        buffer.write('/');
      }
    }
    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}