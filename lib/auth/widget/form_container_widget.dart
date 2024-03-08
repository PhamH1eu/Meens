import 'package:flutter/material.dart';
import 'package:webtoon/utilities/color.dart';
import 'package:gradient_borders/gradient_borders.dart';

class FormContainerWidget extends StatefulWidget {
  final TextEditingController? controller;
  final Key? fieldKey;
  final bool? isPasswordField;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputType? inputType;

  const FormContainerWidget({
    super.key,
    this.controller,
    this.isPasswordField,
    this.fieldKey,
    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
    this.inputType,
  });

  @override
  State<FormContainerWidget> createState() => _FormContainerWidgetState();
}

class _FormContainerWidgetState extends State<FormContainerWidget> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        // border: Border.all(
        //   color: CustomColors.mainText,
        //   width: 1,
        // ),
        border: const GradientBoxBorder(
          gradient: LinearGradient(
              colors: [Color(0xffFC1B7C), Color(0xff714CF4), Color(0xff0084F3)]),
          width: 2,
        ),
      ),
      child: TextFormField(
        style: const TextStyle(color: CustomColors.mainText, fontSize: 15, fontWeight: CustomColors.regular),
        controller: widget.controller,
        keyboardType: widget.inputType,
        key: widget.fieldKey,
        obscureText: widget.isPasswordField == true ? _obscureText : false,
        onSaved: widget.onSaved,
        validator: widget.validator,
        onFieldSubmitted: widget.onFieldSubmitted,
        decoration: InputDecoration(
          errorText: null,
          border: InputBorder.none,
          fillColor: Colors.transparent,
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: CustomColors.gray, fontSize: 15, fontWeight: CustomColors.regular),
          prefixIcon: Icon(
            widget.isPasswordField == true
                ? Icons.lock_outline
                : Icons.email_outlined,
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: widget.isPasswordField == true
                ? Icon(
                    _obscureText
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  )
                : const Text(''),
          ),
        ),
      ),
    );
  }
}
