import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parking_system/styles.dart';

enum ValidationType {
  none,
  normalType,
  emailType,
  passwordType,
  confrimPasswordType
}

class TextFieldComponent extends StatelessWidget {
  final String label;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? textInputType;
  final TextEditingController? textController;
  final TextAlign textAlign;
  final AutovalidateMode? autovalidateMode;
  final bool autofocus;
  final Function(String)? onChanged;
  final bool readOnly;
  final String? hintText;

  const TextFieldComponent({
    this.label = "",
    this.inputFormatters,
    this.textInputType,
    this.textController,
    this.textAlign = TextAlign.start,
    this.autovalidateMode,
    this.autofocus = false,
    this.onChanged,
    this.readOnly = false,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        TextFormField(
          inputFormatters: inputFormatters,
          keyboardType: textInputType,
          controller: textController,
          textAlign: textAlign,
          style: const TextStyle(color: Styles.borderColor),
          autovalidateMode: autovalidateMode,
          autofocus: autofocus,
          onChanged: onChanged,
          readOnly: readOnly,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(8),
            // isDense: true,
            filled: true,
            hintText: hintText,
            // hintStyle: style ??
            //     UTextStyles.caption.copyWith(
            //       color: UColors.textHint,
            //       fontWeight: FontWeight.normal,
            //     ),
            fillColor: Colors.white,
            // suffixIcon: suffixIcon,
            // prefix: prefix,
            // suffix: suffix,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3.0),
              borderSide: const BorderSide(
                color: Styles.primaryColor,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3.0),
              borderSide: const BorderSide(
                color: Styles.borderColor,
                width: 0.5,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
