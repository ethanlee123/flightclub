import 'package:flutter/material.dart';

class ProductName extends StatelessWidget {
  const ProductName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListBody(
      children: <Widget>[
        SizedBox(height: 5.0),
        TextFormField(
          // The validator receives the text that the user has entered.
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Cannot be left empty';
            }
            return null;
          },
        ),
      ],
    ));
  }
}
