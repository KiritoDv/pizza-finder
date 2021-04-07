import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInputComponent extends StatefulWidget  {

  final String placeholder;
  final Widget prefixIcon;
  final IconData suffixIcon;
  final TextEditingController controller;
  final Function(String) validator;
  final TextInputType type;
  final List<TextInputFormatter> inputFormatters;
  final bool isPassword;
  final int maxLength;
  const TextInputComponent({Key key, this.maxLength, this.placeholder, this.prefixIcon, this.suffixIcon, this.controller, this.validator, this.type, this.inputFormatters, this.isPassword = false}) : super(key: key);

  @override
  _TextInputComponentState createState() => _TextInputComponentState();
}

class _TextInputComponentState extends State<TextInputComponent> {

  bool visiblePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: widget.inputFormatters,
      controller: widget.controller,
      keyboardType: widget.type,
      maxLength: widget.maxLength,
      style: TextStyle(
        color: Colors.black,
        fontSize: 14
      ),
      cursorColor: Colors.black54,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 10),
        prefixIcon: this.widget.prefixIcon,
        suffixIcon: this.widget.isPassword ?? false ? GestureDetector(
            onTap: (){
              setState(() {
                this.visiblePassword = !this.visiblePassword;
              });
            },
            child: Icon( this.visiblePassword ?  Icons.lock : Icons.lock_open, color: Colors.black26, size: 18,),
          ) : widget.suffixIcon ?? null,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black26, width: 0.25),
          borderRadius: BorderRadius.all(const Radius.circular(14.0))
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color:Colors.black26, width: 0.25),
          borderRadius: BorderRadius.all(const Radius.circular(14.0))
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black26, width: 0.25),
          borderRadius: BorderRadius.all(const Radius.circular(14.0))
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red.withOpacity(0.26), width: 0.25),
          borderRadius: BorderRadius.all(const Radius.circular(14.0))
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red.withOpacity(0.26), width: 0.25),
          borderRadius: BorderRadius.all(const Radius.circular(14.0))
        ),
        filled: true,
        fillColor: Colors.white,
        labelText: this.widget.placeholder,
        labelStyle: TextStyle(fontSize: 14, color: Colors.black45, fontWeight: FontWeight.w300),
        alignLabelWithHint: true
      ),
      obscureText: widget.isPassword ? this.visiblePassword : false,
      validator: widget.validator,
    );
  }
}