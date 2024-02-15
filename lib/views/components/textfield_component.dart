import 'package:flutter/material.dart';

class TextFieldComponent extends StatelessWidget {
  const TextFieldComponent(
      {super.key,
      this.controller,
      this.currentFocus,
      this.nextFocus,
      this.autocorrect,
      this.keyboardType,
      this.minLines,
      this.maxLines,
      required this.hintText,
      this.textCapitalization,
      this.validator,
      this.onTap,
      this.onChanged,
      this.border});
  final TextEditingController? controller;
  final FocusNode? currentFocus;
  final FocusNode? nextFocus;
  final bool? autocorrect;
  final TextInputType? keyboardType;
  final int? minLines;
  final int? maxLines;
  final InputBorder? border;
  final String hintText;
  final TextCapitalization? textCapitalization;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: currentFocus,
      autocorrect: autocorrect ?? false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: keyboardType,
      minLines: minLines ?? 1,
      maxLines: maxLines,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      textInputAction:
          nextFocus != null ? TextInputAction.next : TextInputAction.done,
      onTap: onTap,
      onChanged: (_) => onChanged == null ? () {} : onChanged!(_),
      onEditingComplete: () {
        currentFocus!.unfocus();
        if (nextFocus != null) {
          nextFocus?.requestFocus();
        }
      },
      decoration: InputDecoration(
        border: border ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
        hintText: hintText,
      ),
      validator: validator ??
          (v) {
            if (v!.isEmpty) {
              return "Field Required";
            } else {
              return null;
            }
          },
    );
  }
}
