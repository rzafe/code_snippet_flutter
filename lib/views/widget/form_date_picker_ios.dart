
import 'package:flutter/cupertino.dart';

/// Form Date Picker IOS -------------------------------------------------------
class FormDatePickerIOS extends StatelessWidget {
  const FormDatePickerIOS({
    super.key,
    required this.onDateTimeChanged,
  });

  final Function(DateTime) onDateTimeChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Column(
        children: [
          SizedBox(
            height: 400,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              minimumYear: 1900,
              maximumDate: DateTime.now(),
              onDateTimeChanged: onDateTimeChanged,
            ),
          ),
          CupertinoButton(
            child: const Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }
}
