import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/widgets/custom_elevated_button.dart';
import 'package:tasky/core/widgets/custom_text_form_field.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({
    super.key,
    required this.username,
    required this.motivationQuote,
  });
  final String username;
  final String motivationQuote;

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  late final TextEditingController usernamecontroller;

  late final TextEditingController motivationquotecontroller;

  final formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    usernamecontroller = TextEditingController(text: widget.username);
    motivationquotecontroller = TextEditingController(
      text: widget.motivationQuote,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Details',
          style: Theme.of(
            context,
          ).textTheme.displayMedium!.copyWith(fontSize: 20),
        ),
      ),
      body: Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomTextFormFields(
                title: 'User Name',
                hintText: 'Usama Elgendy',
                controller: usernamecontroller,
                validator:
                    (value) =>
                        value == null || value.trim().isEmpty
                            ? 'Please enter your  User Name'
                            : null,
              ),
              SizedBox(height: 20),
              CustomTextFormFields(
                title: 'Motivation Quote',
                hintText: 'One task at a time. One step closer.',
                controller: motivationquotecontroller,
                maxLines: 5,
                //Motivation Quote
                validator:
                    (value) =>
                        value == null || value.trim().isEmpty
                            ? 'Please enter Motivation Quote'
                            : null,
              ),
              Spacer(),
              CustomElevatedButton(
                onPressed: () async {
                  if (formkey.currentState!.validate()) {
                    PreferencesManager().setString(
                      'username',
                      usernamecontroller.value.text,
                    );
                    PreferencesManager().setString(
                      'motivationQuote',
                      motivationquotecontroller.value.text,
                    );

                    Navigator.pop(context, true);
                  }
                },

                label: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
