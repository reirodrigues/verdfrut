import 'package:greenfrut/src/constants/endpoints.dart';
import 'package:greenfrut/src/models/user_model.dart';
import 'package:greenfrut/src/pages/auth/repository/auth_erros.dart'
    as authErrors;
import 'package:greenfrut/src/pages/auth/result/auth_result.dart';
import 'package:greenfrut/src/services/http_manager.dart';

class AuthRepository {
  final HttpManager _httpManager = HttpManager();

  AuthResult handleUserOrErorr(Map<dynamic, dynamic> result) {
    if (result['result'] != null) {
      final user = UserModel.fromJson(result['result']);

      return AuthResult.success(user);
    } else {
      return AuthResult.error(authErrors.authErrorString(result['error']));
    }
  }

  Future<AuthResult> validateToken(
    String token,
  ) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.validateToken,
      method: httpMethods.post,
      headers: {
        'X-Parse-Session-Token': token,
      },
    );

    return handleUserOrErorr(result);
  }

  Future<AuthResult> signIn({
    required String email,
    required String password,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.signin,
      method: httpMethods.post,
      body: {
        "email": email,
        "password": password,
      },
    );

    return handleUserOrErorr(result);
  }

  Future<AuthResult> signUp(UserModel user) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.signup,
      method: httpMethods.post,
      body: user.toJson(),
    );

    return handleUserOrErorr(result);
  }

  Future<void> resetPassword(String email) async {
    await _httpManager.restRequest(
      url: Endpoints.resetPassword,
      method: httpMethods.post,
      body: {'email': email},
    );
  }
}
