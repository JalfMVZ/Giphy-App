import 'package:shared_preferences/shared_preferences.dart';

class PreferenciesUsers {
  //* Generar instancia

  static late SharedPreferences _prefs;

  //* Inicializar las preferencias
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  String get ultimaPagina {
    return _prefs.getString('ultimaPagina') ?? 'Login';
  }

  set ultimaPagina(String value) {
    _prefs.setString('ultimaPagina', value);
  }

  String get token {
    return _prefs.getString('token') ?? '';
  }

  set token(String value) {
    _prefs.setString('token', value);
  }
}
