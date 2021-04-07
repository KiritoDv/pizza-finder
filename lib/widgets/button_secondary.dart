import 'package:flutter/material.dart';

class ButtonSecondaryComponent extends StatelessWidget {

  final Widget child;
  final Function onTap;

  ButtonSecondaryComponent({this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap ?? (){},
      style: ButtonStyle(
        alignment: Alignment.center,
        elevation: MaterialStateProperty.all<double>(2),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: BorderSide(color: Colors.black12)
          )
        ),
        backgroundColor:  MaterialStateProperty.all<Color>( Colors.black54 )
      ),
      child: this.child
    );
  }
}