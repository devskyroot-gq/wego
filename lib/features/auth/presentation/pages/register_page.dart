import 'package:demo_pss/core/theme/app_colors.dart';
import 'package:demo_pss/core/utils/loading_dialog.dart';
import 'package:demo_pss/features/auth/presentation/pages/login_page.dart';
import 'package:demo_pss/features/auth/presentation/pages/start_page.dart';
import 'package:demo_pss/data/models/user_model.dart';
import 'package:demo_pss/data/repositories/auth_repositories/user_repository.dart';
import 'package:demo_pss/data/repositories/controller/signup_controller.dart';
import 'package:demo_pss/features/auth/presentation/widgets/app_button.dart';
import 'package:demo_pss/features/auth/presentation/widgets/app_large_text.dart';
import 'package:demo_pss/features/auth/presentation/widgets/app_leading_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final controller = Get.put(SignupController());
  final registerFormKey = GlobalKey<FormState>();
  bool actionInProgress = false;
  //vars
  bool isFormValid = false;
  String errorMessage = "";
  String phoneCode = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      actionInProgress = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    setState(() {
      actionInProgress = false;
      controller.name.dispose();
      controller.surname.dispose();
      controller.email.dispose();
      controller.phone.dispose();
      controller.username.dispose();
      controller.password.dispose();
      controller.password2.dispose();
    });
  }

//form validation
  void _validateForm() {
    final isValid = registerFormKey.currentState?.validate() ?? false;
    if (isValid != isFormValid) {
      setState(() {
        isFormValid = isValid;
      });
    }
  }

  //loading dialog
  Future<void> _showProgressDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      //barrierLabel: ,
      builder:
          (context) => Dialog(
            elevation: 10,
            child: LoadingDialog(text: "Procesando..."),
          ),
    );
  }

  //submit form
  void _submitForm() async {
    setState(() {
      actionInProgress = true;
    });
    _showProgressDialog(context);
    if (registerFormKey.currentState!.validate()) {
      //send data to controller
      final user = UserModel(
        name: controller.name.text.trim(),
        surname: controller.surname.text.trim(),
        phone: phoneCode + controller.phone.text.trim(),
        email: controller.email.text.trim(),
        username: controller.username.text.trim(),
        password: controller.password.text.trim(),
      );
      try {
        await authService.value.signUp(user);
        setState(() {
          actionInProgress = false;
        });
      } on FirebaseAuthException catch (e) {
        Get.snackbar(
          "Info",
          e.message!,
          colorText: AppColors.textError,
          backgroundColor: AppColors.background,
          isDismissible: true,
          duration: Duration(seconds: 5),
        );
      }
      Get.off(() => StartPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(opacity: 0.9, child: ColoredBox(color: Colors.blue)),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: AppLeadingButton(),
                ),
              ),

              SizedBox(height: 50),

              Expanded(
                child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Form(
                      key: registerFormKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: _validateForm,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Column(
                              children: [
                                AppLargeText(text: "Registro", size: 24),
                                AppLargeText(
                                  text:
                                      "Completa el formulario de registro para crear una cuenta",
                                  size: 12,
                                  color: AppColors.textSecondary,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8),
                          //name text field
                          TextFormField(
                            controller: controller.name,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Completa este campo";
                              }
                              if (value.length < 3) {
                                return "El nombre debe tener un minimo de 3 caracteres";
                              }
                              return null;
                            },
                            style: TextStyle(fontSize: 18),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColors.bgCard,
                              label: Text(
                                "Nombre",
                                style: TextStyle(fontSize: 18),
                              ),
                              hintText: "Nombre",
                              alignLabelWithHint: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 16),
                          //surname text field
                          TextFormField(
                            controller: controller.surname,
                            style: TextStyle(fontSize: 18),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Completa este campo";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColors.bgCard,
                              label: Text(
                                "Apellidos",
                                style: TextStyle(fontSize: 18),
                              ),
                              hintText: "Apellidos",
                              alignLabelWithHint: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 16),
                          //email text field
                          TextFormField(
                            controller: controller.email,
                            style: TextStyle(fontSize: 18),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Completa este campo";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColors.bgCard,
                              label: Text(
                                "Coreo electronico(opcional)",
                                style: TextStyle(fontSize: 18),
                              ),
                              hintText: "example@gmail.com",
                              alignLabelWithHint: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 16),
                          //phone text field
                          IntlPhoneField(
                            controller: controller.phone,
                            validator: (phone) {
                              if (phone == null || phone.number.isEmpty) {
                                return "Introduzca un numero de telefono";
                              }
                              phoneCode = phone.countryCode;
                              return null;
                            },
                            style: TextStyle(fontSize: 18),
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColors.bgCard,
                              label: Text(
                                "Numero de telefono",
                                style: TextStyle(fontSize: 18),
                              ),
                              hintText: "Numero de telefono",
                              alignLabelWithHint: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                            initialCountryCode: "GQ",
                            disableLengthCheck: true,
                          ),

                          SizedBox(height: 16),
                          //username text field
                          TextFormField(
                            controller: controller.username,
                            style: TextStyle(fontSize: 18),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Completa este campo";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColors.bgCard,
                              label: Text(
                                "Nombre de usuario o alias",
                                style: TextStyle(fontSize: 18),
                              ),
                              hintText: "Nombre de usuario o alias",
                              alignLabelWithHint: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 16),
                          //password text field
                          TextFormField(
                            controller: controller.password,
                            obscureText: true,
                            obscuringCharacter: "*",
                            style: TextStyle(fontSize: 18),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Completa este campo";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColors.bgCard,
                              label: Text(
                                "Contrasena",
                                style: TextStyle(fontSize: 18),
                              ),
                              hintText: "Contrasena",
                              alignLabelWithHint: true,
                              suffixIcon: Icon(Icons.lock),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 16),
                          //password2 text field
                          TextFormField(
                            controller: controller.password2,
                            obscureText: true,
                            obscuringCharacter: "*",
                            style: TextStyle(fontSize: 18),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Completa este campo";
                              }
                              if (controller.password.text !=
                                  controller.password2.text) {
                                return "Las contraseñas no coinciden";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColors.bgCard,
                              label: Text(
                                "Repite la contrasena",
                                style: TextStyle(fontSize: 18),
                              ),
                              hintText: "Repite la contrasena",
                              alignLabelWithHint: true,
                              suffixIcon: Icon(Icons.lock),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),
                          InkWell(
                            onTap: isFormValid ? _submitForm : null,
                            child: AppButton(
                              isIcon: false,
                              text: "Aceptar",
                              color: AppColors.background,
                              bgColor:
                                  isFormValid
                                      ? AppColors.primary
                                      : AppColors.primaryShade300,
                              borderRadius: 20,
                              borderColor: AppColors.inherit,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
