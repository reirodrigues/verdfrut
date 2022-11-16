import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greenfrut/src/pages/auth/controllers/auth_controller.dart';
import 'package:greenfrut/src/pages/widgets/app_name_widget.dart';
import 'package:greenfrut/src/pages/widgets/custom_text_field.dart';
import 'package:greenfrut/src/pages_routes/app_pages.dart';
import 'package:greenfrut/src/services/validators.dart';
import '../../../config/custom_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  // Form controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColors.customContrastColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ----------------------------------------- App Name
                    const AppNameWidget(
                      purpleTitleColor: Colors.white,
                      textSize: 50,
                    ),
                    // --------------------------------------------- Categories
                    SizedBox(
                      height: 30,
                      child: DefaultTextStyle(
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                        child: AnimatedTextKit(
                          pause: Duration.zero,
                          repeatForever: true,
                          animatedTexts: [
                            FadeAnimatedText('Frutas',
                                textStyle: GoogleFonts.adamina()),
                            FadeAnimatedText('Verduras',
                                textStyle: GoogleFonts.adamina()),
                            FadeAnimatedText('Legumes',
                                textStyle: GoogleFonts.adamina()),
                            FadeAnimatedText('Carnes',
                                textStyle: GoogleFonts.adamina()),
                            FadeAnimatedText('Cereais',
                                textStyle: GoogleFonts.adamina()),
                            FadeAnimatedText('Laticineos',
                                textStyle: GoogleFonts.adamina()),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // ------------------------------------------------ Form
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 40,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(45),
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // --------------------------------------------- Email
                      CustomTextField(
                        controller: emailController,
                        icon: Icons.email,
                        label: 'Email',
                        validator: emailValidator,
                      ),
                      // ----------------------------------------------- Password
                      CustomTextField(
                        controller: passwordController,
                        icon: Icons.lock,
                        label: 'Senha',
                        isSecret: true,
                        validator: passwordValidator,
                      ),
                      // ---------------------------------------------- button SignIn
                      SizedBox(
                        height: 50,
                        child: GetX<AuthController>(
                          builder: (authController) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              onPressed: authController.isLoading.value
                                  ? null
                                  : () {
                                      FocusScope.of(context).unfocus();
                                      if (_formKey.currentState!.validate()) {
                                        String email = emailController.text;
                                        String password =
                                            passwordController.text;
                                        print(
                                            'email: $email, senha: $password');

                                        authController.signIn(
                                            email: email, password: password);
                                      } else {
                                        print('Campos inválidos');
                                      }

                                      //Get.offNamed(PagesRoutes.baseRoute);
                                    },
                              child: !authController.isLoading.value
                                  ? const Text(
                                      'Entrar',
                                      style: TextStyle(fontSize: 18),
                                    )
                                  : const CircularProgressIndicator(),
                            );
                          },
                        ),
                      ),
                      // -------------------------------------------- Forget password?
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Esqueceu a senha?',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      // ----------------------------------------------- Divider
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey.withAlpha(90),
                                thickness: 2,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text('Ou'),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey.withAlpha(90),
                                thickness: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      //------------------------------------------------ New User
                      SizedBox(
                        height: 50,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18)),
                              side: const BorderSide(
                                width: 2,
                                color: Colors.purple,
                              )),
                          onPressed: () {
                            Get.toNamed(PagesRoutes.signUpRoute);
                          },
                          child: const Text(
                            'Criar Conta',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
