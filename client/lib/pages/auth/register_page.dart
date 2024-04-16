// ignore_for_file: unrelated_type_equality_checks, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc_tutorial/home/view/home_page.dart';
import 'package:flutter_bloc_tutorial/utils/auth.dart';
import 'package:flutter_bloc_tutorial/utils/snack_bar.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class RegisterPage extends StatelessWidget {
  static const String routeName = 'Register';

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  RegisterPage({super.key});

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                FormBuilderTextField(
                  name: 'email', // Cambiar de 'user' a 'email'
                  decoration: const InputDecoration(
                    labelText: 'Usuario',
                    border: OutlineInputBorder(),
                  ),
                  validator: FormBuilderValidators.required(),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                FormBuilderTextField(
                  name: 'password',
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(),
                  ),
                  validator: FormBuilderValidators.required(),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    _formKey.currentState?.save();
                    if (_formKey.currentState?.validate() == true) {
                      final formData = _formKey.currentState?.value;
                      final success = await _auth.createAccount(
                        formData?['email'],
                        formData?['password'],
                      );
                      if (success) {
                        Navigator.pushNamed(context, HomePage.routeName);
                      } else {
                        showSnackBar(context, 'Error al registrar la cuenta');
                      }
                    }
                  },
                  child: const Text('Registrarse'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
