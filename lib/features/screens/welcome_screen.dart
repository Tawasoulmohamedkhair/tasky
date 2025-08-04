// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/widgets/custom_elevated_button.dart';
import 'package:tasky/core/widgets/custom_svg_picture.dart';
import 'package:tasky/core/widgets/custom_text_form_field.dart';
import 'package:tasky/features/screens/main_screen.dart';

class WelcomScreen extends StatelessWidget {
  WelcomScreen({super.key});
  final TextEditingController namecontroller = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomSvgPicture.withcolorfilter(
                        svgAssetPath: 'assets/svg/logo.svg',
                      ),
                      SizedBox(width: 16),
                      Text(
                        'Tasky',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: 108),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome To Tasky ',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      CustomSvgPicture.withcolorfilter(
                        svgAssetPath: 'assets/svg/waving-hand.svg',
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Your productivity journey starts here.',
                    style: Theme.of(
                      context,
                    ).textTheme.displaySmall!.copyWith(fontSize: 16),
                  ),
                  SizedBox(height: 24),

                  CustomSvgPicture.withcolorfilter(
                    svgAssetPath: 'assets/svg/pana.svg',
                    width: 215,
                    height: 200,
                  ),

                  SizedBox(height: 28),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CustomTextFormFields(
                        title: 'Full Name',
                        hintText: 'e.g. Sarah Khalid',
                        controller: namecontroller,
                        validator:
                            (value) =>
                                value == null || value.trim().isEmpty
                                    ? 'Please enter your  fullname'
                                    : null,
                      ),
                    ),
                  ),

                  SizedBox(height: 24),
                  CustomElevatedButton(
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        await PreferencesManager().setString(
                          'username',
                          namecontroller.text,
                        );

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => MainScreen()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please enter your  fullname'),
                          ),
                        );
                      }
                    },
                    label: Text(
                      'Let’s Get Started',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
