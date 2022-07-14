import 'package:flutter/material.dart';


Widget inputFormField({
  required TextEditingController controller,
  required FormFieldValidator<String> validator,
  required String hintText,
  required IconData prefixIcon,
  required GestureTapCallback? onTap,
  required ValueChanged<String>? onFieldSubmitted,
  required TextInputType textInputType,
}){
  return Padding(
    padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 5),
    child: TextFormField(
      onTap: onTap,
      onFieldSubmitted: onFieldSubmitted,
      controller: controller,
      validator: validator,
      keyboardType: textInputType,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(prefixIcon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
  );
}