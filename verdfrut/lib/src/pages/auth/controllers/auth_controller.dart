import 'package:get/get.dart';
import 'package:greenfrut/src/constants/storage_keys.dart';
import 'package:greenfrut/src/models/user_model.dart';
import 'package:greenfrut/src/pages/auth/repository/auth_repository.dart';
import 'package:greenfrut/src/pages/auth/result/auth_result.dart';
import 'package:greenfrut/src/pages_routes/app_pages.dart';
import 'package:greenfrut/src/services/utils_services.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  final authRepository = AuthRepository();
  final utilsServices = UtilsServices();

  void saveTokenAndProceedToBase() {
    // save token
    utilsServices.saveLocalData(key: StorageKeys.token, data: user.token!);

    // go to base
    Get.offAllNamed(PagesRoutes.baseRoute);
  }

  UserModel user = UserModel();

  @override
  void onInit() {
    super.onInit();

    validateToken();
  }

  Future<void> validateToken() async {
    String? token = await utilsServices.getlocalData(key: StorageKeys.token);
    if (token == null) {
      Get.offAllNamed(PagesRoutes.signInRoute);
      return;
    }

    AuthResult result = await authRepository.validateToken(token);

    result.when(
      success: (user) {
        this.user = user;

        saveTokenAndProceedToBase();
      },
      error: (message) {
        signOut();
      },
    );
  }

  Future<void> signOut() async {
    // zerar user
    user = UserModel();
    // remover o token local
    await utilsServices.removeLocalData(key: StorageKeys.token);
    // ir para login
    Get.offAllNamed(PagesRoutes.signInRoute);
  }

  Future<void> signUp() async {
    isLoading.value = true;

    AuthResult result = await authRepository.signUp(user);

    isLoading.value = false;

    result.when(
      success: (user) {
        this.user = user;

        saveTokenAndProceedToBase();
      },
      error: (message) {
        utilsServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;
    AuthResult result = await authRepository.signIn(
      email: email,
      password: password,
    );
    isLoading.value = false;

    result.when(
      success: (user) {
        this.user = user;

        saveTokenAndProceedToBase();
      },
      error: (message) {
        utilsServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }
}
