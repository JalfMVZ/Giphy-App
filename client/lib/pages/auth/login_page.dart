// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc_tutorial/utils/auth.dart';
import 'package:flutter_bloc_tutorial/utils/snack_bar.dart';
import 'package:flutter_bloc_tutorial/home/view/home_page.dart';
import 'package:flutter_bloc_tutorial/pages/auth/register_page.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = 'Login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _auth = AuthService();
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  void _checkAuthStatus() async {
    bool isLoggedIn = await _auth.checkAuthStatus();
    if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Bienvenido a Gyphy App',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    FormBuilderTextField(
                      name: 'User',
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
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  _formKey.currentState?.save();
                  if (_formKey.currentState?.validate() == true) {
                    final formData = _formKey.currentState?.value;
                    final success = await _auth.signInWithEmailAndPassword(
                      formData?['User'],
                      formData?['password'],
                    );
                    if (success) {
                      Navigator.pushReplacementNamed(
                          context, HomePage.routeName);
                    } else {
                      showSnackBar(context, 'Usuario o contraseña incorrectos');
                    }
                  }
                },
                child: const Text('Iniciar Sesión'),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RegisterPage.routeName);
                },
                child: const Text(
                  '¿No tienes una cuenta?',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
