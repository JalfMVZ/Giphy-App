import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String _authKey = 'auth_status';

  Stream<User?> authStateChanges() {
    return _auth.authStateChanges();
  }

  Future<bool> createAccount(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
    } catch (_) {}
    return false;
  }

  Future<void> _saveAuthStatus(bool isLoggedIn) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_authKey, isLoggedIn);
    print("Estado de autenticación guardado: $isLoggedIn");
  }

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      print("Inicio de sesión con correo: $email");
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _saveAuthStatus(true); // Guardar la bandera de autenticación
      print("Inicio de sesión exitoso para el usuario: $email");
      return true;
    } on FirebaseAuthException catch (e) {
      print("Error de inicio de sesión: ${e.message}");
      return false;
    } catch (error) {
      print("Error inesperado durante el inicio de sesión: $error");
      return false;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _saveAuthStatus(false); // Eliminar la bandera de autenticación
  }

  Future<bool> checkAuthStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_authKey) ?? false;
  }

  // Future<bool> autoSignIn() async {
  //   try {
  //     final bool isLoggedIn = await checkAuthStatus();
  //     if (isLoggedIn) {
  //       // Si el usuario está autenticado, iniciar sesión automáticamente
  //       final SharedPreferences prefs = await SharedPreferences.getInstance();
  //       final String? email = prefs.getString('user_email');
  //       final String? password = prefs.getString('user_password');
  //       if (email != null && password != null) {
  //         await signInWithEmailAndPassword(email, password);
  //         return true;
  //       }
  //     }
  //   } catch (error) {
  //     print("Error durante el inicio de sesión automático: $error");
  //   }
  //   return false;
  // }
}
