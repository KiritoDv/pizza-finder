import 'package:flutter/material.dart';

class ButtonComponent extends StatelessWidget {

  final Widget child;
  final Function onTap;

  ButtonComponent({this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap ?? (){},
      style: ButtonStyle(
        alignment: Alignment.center,
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: BorderSide(color: Colors.black45)
          )
        ),
        backgroundColor:  MaterialStateProperty.all<Color>(
          Colors.black
        )
      ),
      child: this.child
    );
  }
}