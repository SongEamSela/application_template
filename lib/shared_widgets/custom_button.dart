import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final String? title;
  const CustomButton({Key? key, this.onPressed, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Theme.of(context).primaryColor,
      onPressed: onPressed ?? () {},
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 56,
        child: Center(
          child: Text(
            title ?? '',
            style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
