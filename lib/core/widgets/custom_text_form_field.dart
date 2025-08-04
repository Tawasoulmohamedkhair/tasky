import 'package:flutter/material.dart';

class CustomTextFormFields extends StatelessWidget {
  const CustomTextFormFields({
    super.key,
    required this.title,
    this.validator,

    this.maxLines,
    required this.hintText,
    required this.controller,
  });
  final String title;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final int? maxLines;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.displaySmall),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          style: Theme.of(context).textTheme.labelMedium,

          decoration: InputDecoration(hintText: hintText),

          maxLines: maxLines,
        ),
      ],
    );
  }
}
