import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final IconData? prefixIcon;
  final bool isNumber;
  final int? maxLength;
  final EdgeInsets? contentPadding;
  final String? Function(String? value)? validator;
  final ValueChanged<String>? onSubmit;
  final TextStyle? hintStyle;
  final Color prefixColor;
  final TextStyle style;
  final GestureTapCallback? onTap;
  final FocusNode? focusNode;
  final VoidCallback? onEditingComplete;


  const CustomTextField({

    this.focusNode,
    super.key,
    this.onTap,
    required this.textEditingController,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    required this.validator,
    required this.onSubmit,
    this.isNumber = false,
    this.maxLength,
    this.contentPadding,
    required this.style,
    this.hintStyle ,
    this.prefixColor = Colors.white54, this.onEditingComplete,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return TextFormField(
      textDirection: TextDirection.rtl,
      onTap: onTap,
      maxLines: 1,
      onEditingComplete: onEditingComplete,
      style: style,
      textInputAction: TextInputAction.next,
      maxLength: maxLength,
      onFieldSubmitted: onSubmit,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: obscureText,
      keyboardType: keyboardType,
      controller: textEditingController,
      decoration: InputDecoration(
        counterText: "",
        hintStyle: hintStyle,
        disabledBorder: InputBorder.none,
        errorStyle: const TextStyle(height: 0.6, fontSize: 13),
        hintMaxLines: 1,
        contentPadding: contentPadding,
        suffixIcon: suffixIcon,
        suffixIconColor: theme.iconTheme.color,
        hintText: hintText,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide:  BorderSide(color: theme.primaryColor, width: 3.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.grey, width: 1.5),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.grey, width: 1.0),
        ),
      ),
    );
  }
}

