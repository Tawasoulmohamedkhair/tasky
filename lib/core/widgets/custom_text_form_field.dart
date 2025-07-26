import 'package:flutter/material.dart';
//import 'package:tasky/core/theme/dark_theme.dart';

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
          style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 16),

          decoration: InputDecoration(
            hintText: hintText,
            //  hintStyle: Theme.of(context).textTheme.titleMedium,
          ),

          maxLines: maxLines,
        ),
      ],
    );
  }
}
