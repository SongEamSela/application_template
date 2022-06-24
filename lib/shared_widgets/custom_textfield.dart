import 'package:flutter/material.dart';

class CustomTextFeild extends StatelessWidget {
  const CustomTextFeild({
    Key? key,
    this.height = 59,
    this.width,
    this.hintText,
    this.errorText,
    this.validator,
  }) : super(key: key);

  final double height;
  final double? width;
  final String? hintText;
  final String? errorText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: height,
          width: width,
          padding: const EdgeInsets.only(left: 16, right: 16),
          decoration: BoxDecoration(
            color: Theme.of(context).hoverColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: TextFormField(
              validator: validator,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
              ),
            ),
          ),
        ),
        if (errorText != '')
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 5),
            child: Text(
              errorText ?? '',
              style: TextStyle(color: Theme.of(context).errorColor),
            ),
          )
      ],
    );
  }
}
