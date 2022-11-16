import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greenfrut/src/pages/auth/controllers/auth_controller.dart';
import 'package:greenfrut/src/pages/widgets/custom_text_field.dart';
import 'package:greenfrut/src/config/custom_colors.dart';
import 'package:greenfrut/src/services/validators.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final cpfFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {'#': RegExp(r'[0-9]')},
  );

  final phoneFormatter = MaskTextInputFormatter(
    mask: '## # ####-####',
    filter: {'#': RegExp(r'[0-9]')},
  );

  final _formKey = GlobalKey<FormState>();

  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColors.customContrastColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              Column(
                children: [
                  // ------------------------------- Name 'SignUp'
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Cadastre-se',
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  // --------------------------------------------------------- Form
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 40,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(45)),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomTextField(
                            onSaved: (value) {
                              authController.user.email = value;
                            },
                            validator: emailValidator,
                            icon: Icons.email,
                            label: 'Email',
                            textInputType: TextInputType.emailAddress,
                          ),
                          CustomTextField(
                            onSaved: (value) {
                              authController.user.password = value;
                            },
                            validator: passwordValidator,
                            icon: Icons.lock,
                            label: 'Senha',
                            isSecret: true,
                          ),
                          CustomTextField(
                            onSaved: (value) {
                              authController.user.name = value;
                            },
                            validator: nameValidator,
                            icon: Icons.person,
                            label: 'Nome',
                          ),
                          CustomTextField(
                            onSaved: (value) {
                              authController.user.phone = value;
                            },
                            validator: phoneValidator,
                            inputFormatters: [phoneFormatter],
                            icon: Icons.phone,
                            label: 'Celular',
                            textInputType: TextInputType.number,
                          ),
                          CustomTextField(
                            onSaved: (value) {
                              authController.user.cpf = value;
                            },
                            validator: cpfValidator,
                            inputFormatters: [cpfFormatter],
                            icon: Icons.file_copy,
                            label: 'CPF',
                            textInputType: TextInputType.number,
                          ),
                          // ---------------------------------------------- Button SignUp
                          SizedBox(
                            height: 50,
                            child: Obx(
                              () {
                                return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18)),
                                  ),
                                  onPressed: authController.isLoading.value
                                      ? null
                                      : () {
                                          FocusScope.of(context).unfocus();
                                          if (_formKey.currentState!
                                              .validate()) {
                                            _formKey.currentState!.save();

                                            authController.signUp();
                                          }
                                        },
                                  child: !authController.isLoading.value
                                      ? const Text(
                                          'Cadastrar Usuário',
                                          style: TextStyle(fontSize: 18),
                                        )
                                      : const CircularProgressIndicator(),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Positioned(
                left: 10,
                top: 10,
                child: SafeArea(
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
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
