import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class DefaultFormField extends StatelessWidget {

  Widget? prefixIcon;
  Widget? SuffixIcon;
  TextInputType? keyType;
  Color? cursor;
  String? title;
  bool? isPassword;
  double paddingHorizontal;
  double paddingVertical;
  TextEditingController Controller;
  VoidCallback onpressed;
  final String? Function (String?)? validate;



  DefaultFormField({
    this.prefixIcon =null,
    this.SuffixIcon=null,
    this.isPassword =false,
    required this.keyType,
    this.cursor = Colors.grey,
    required this.title,
    this.paddingHorizontal=0,
    this.paddingVertical=0,
    required this.Controller,
    required this.onpressed,
    this.validate,

  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: Controller,
        onTap: onpressed,
        validator: validate,
        obscureText: isPassword!,
        keyboardType: keyType,
        cursorColor: cursor,
        decoration: InputDecoration(
          fillColor: Colors.grey.shade100,
          filled: true,
          contentPadding:  EdgeInsets.symmetric(vertical: paddingVertical,horizontal: paddingHorizontal),
          hintText: title,
          prefixIcon: prefixIcon,
          suffixIcon: (SuffixIcon==null)?null:IconTheme(data: IconThemeData(
              color: Colors.grey
          ),
              child: SuffixIcon!),
          suffixIconColor: Colors.grey,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.grey.shade200,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.grey.shade100,

            ),
          ),
        )
    );
  }
}
