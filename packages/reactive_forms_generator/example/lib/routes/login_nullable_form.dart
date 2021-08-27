import 'package:example/forms/login_nullable.dart';
import 'package:example/forms/login_nullable.gform.dart';
import 'package:example/helpers.dart';
import 'package:example/sample_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ProgressIndicator;
import 'package:intl/intl.dart';
import 'package:reactive_dropdown_search/reactive_dropdown_search.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_touch_spin/reactive_touch_spin.dart';

class LoginNullableFormWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SampleScreen(
      title: Text('Login nullable'),
      body: LoginNullableFormBuilder(
        model: LoginNullable(),
        builder: (context, formModel, child) {
          return Column(
            children: [
              ReactiveTextField<String>(
                formControl: formModel.emailControl,
                validationMessages: (control) => {
                  ValidationMessage.required: 'The email must not be empty',
                  ValidationMessage.email:
                      'The email value must be a valid email',
                  'unique': 'This email is already in use',
                },
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  helperText: '',
                  helperStyle: TextStyle(height: 0.7),
                  errorStyle: TextStyle(height: 0.7),
                ),
              ),
              const SizedBox(height: 16.0),
              ReactiveTextField<String>(
                formControl: formModel.passwordControl,
                obscureText: true,
                validationMessages: (control) => {
                  ValidationMessage.required: 'The password must not be empty',
                  ValidationMessage.minLength:
                      'The password must be at least 8 characters',
                },
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  helperText: '',
                  helperStyle: TextStyle(height: 0.7),
                  errorStyle: TextStyle(height: 0.7),
                ),
              ),
              const SizedBox(height: 16.0),
              ReactiveDropdownSearch<String>(
                formControl: formModel.themeControl,
                decoration: InputDecoration(
                  helperText: '',
                  contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                  border: OutlineInputBorder(),
                ),
                mode: Mode.MENU,
                hint: "Select a theme",
                showSelectedItem: true,
                items: [
                  "light",
                  "dark",
                ],
                label: "Theme",
                showClearButton: true,
              ),
              const SizedBox(height: 16.0),
              ReactiveDropdownSearch<UserMode>(
                formControl: formModel.modeControl,
                decoration: InputDecoration(
                  helperText: '',
                  contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                  border: OutlineInputBorder(),
                ),
                mode: Mode.MENU,
                hint: "Select a theme",
                showSelectedItem: true,
                items: [
                  UserMode.admin,
                  UserMode.user,
                ],
                compareFn: (item, selectedItem) => item == selectedItem,
                label: "Theme",
                showClearButton: true,
              ),
              ReactiveTouchSpin<int>(
                formControl: formModel.timeoutControl,
                decoration: InputDecoration(
                  labelText: 'Logout timeout mins.',
                ),
                valueAccessor: NumValueAccessor(),
                displayFormat: NumberFormat()..minimumFractionDigits = 0,
                min: 0,
                max: 10,
              ),
              ListTile(
                title: Text('remember me'),
                trailing: ReactiveSwitch(
                  formControl: formModel.rememberMeControl,
                ),
              ),
              ReactiveSlider(
                formControl: formModel.heightControl,
                min: 120,
                max: 220,
              ),
              ElevatedButton(
                onPressed: () {
                  if (formModel.form.valid) {
                    print(formModel.model);
                  } else {
                    formModel.form.markAllAsTouched();
                  }
                },
                child: const Text('Sign Up'),
              ),
              ReactiveLoginNullableFormConsumer(
                builder: (context, formModel, child) {
                  return ElevatedButton(
                    child: Text('Submit'),
                    onPressed: formModel.form.valid ? () {} : null,
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
