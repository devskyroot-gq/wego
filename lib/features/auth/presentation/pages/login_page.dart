import 'package:demo_pss/core/theme/app_colors.dart';
import 'package:demo_pss/core/utils/loading_dialog.dart';
import 'package:demo_pss/data/repositories/auth_repositories/user_repository.dart';
import 'package:demo_pss/data/repositories/controller/login_controller.dart';
import 'package:demo_pss/features/auth/presentation/pages/register_page.dart';
import 'package:demo_pss/features/auth/presentation/pages/start_page.dart';
import 'package:demo_pss/features/auth/presentation/widgets/app_form_button.dart';
import 'package:demo_pss/features/auth/presentation/widgets/app_large_text.dart';
import 'package:demo_pss/features/auth/presentation/widgets/app_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = Get.put(LoginController());
  final loginFormKey = GlobalKey<FormState>();
  bool isFormValid = false;
  bool actionInProgress = false;
  String errorMessage = "";

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
    controller.phone.dispose();
    controller.password.dispose();
    setState(() {
      actionInProgress = false;
    });
  }

  void _validateForm() {
    final isValid = loginFormKey.currentState?.validate() ?? false;
    if (isValid != isFormValid) {
      setState(() {
        isFormValid = isValid;
      });
    }
  }

  //Show progress dialog
  Future<void> _showProgressDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      //barrierLabel: ,
      builder: (context) => Dialog(child: LoadingDialog(text: "Procesando...")),
    );
  }

//when submit show progress dialog when is loging
  void _submitForm() async {
    setState(() {
      actionInProgress = true;
    });
    actionInProgress ? _showProgressDialog(context) : null;
    if (loginFormKey.currentState!.validate()) {
      try {
        await authService.value.signIn(
          email: controller.phone.text.trim(),
          password: controller.password.text.trim(),
        );
       
        if (!mounted) return;
        Get.off(() => StartPage());
      } on FirebaseAuthException catch (e) {
        Navigator.of(context).pop();
        if (e.code == "internal-error") {
          errorMessage = 'Error interno del servidor';
        }else if(e.code == "invalid-credential"){
          errorMessage = "Uauario o contraseña no válidos";
        }else{
          errorMessage = e.message!;
        }
        // errorMessage = 'Usuario o contraseña no válidos';
        Get.snackbar(
          "Info",
          errorMessage,
          colorText: AppColors.textError,
          backgroundColor: AppColors.background,
          isDismissible: true,
          duration: Duration(seconds: 5),
        );
        print(
          "ERROR: ${e.code} "
          " ${e.message!} \n"
          " ${e.stackTrace.toString()}",
        );
      }
      setState(() {
        actionInProgress = false;
      });
    }
  }

  //login with phone and password
  void _loginWithPhoneAndPassword() async {
    try {
       await authService.value.signByPhoneAndPassword(
        controller.phone.text.trim(),
        controller.password.text.trim(),
      ).then(
        (value) {
          Get.off(() => StartPage());
        },
      );
    } catch (e) {
      print("ERROR: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.9,
              child: ColoredBox(color: AppColors.primary),
            ),
          ),

          Column(
            children: [
              SizedBox(height: 100),
              Container(
                width: 150,
                height: 110,
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.asset(
                  "assets/images/logo-black.png",
                  fit: BoxFit.cover,
                ),
              ),

              SizedBox(height: 100),

              Expanded(
                child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Form(
                      key: loginFormKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: AppLargeText(
                              text: "Inicio de sesion",
                              size: 24,
                            ),
                          ),
                          SizedBox(height: 8),

                          Padding(
                            padding: const EdgeInsets.only(left: 4, right: 8),
                            child: Text(
                              "CORREO ELECTRONICO",
                              style: TextStyle(fontSize: 12, letterSpacing: 2),
                            ),
                          ),

                          SizedBox(height: 6),
                          //phone text field
                          TextFormField(
                            controller: controller.phone,
                            style: TextStyle(fontSize: 18),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Completa este campo";
                              }
                              if (!RegExp(
                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                              ).hasMatch(value)) {
                                return "Correo no válido";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColors.bgCard,
                              hintText: "ejemplo@gmail.com",
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
                          Padding(
                            padding: EdgeInsets.only(left: 4, right: 4),
                            child: Text(
                              "CONTRASEÑA",
                              style: TextStyle(fontSize: 12, letterSpacing: 2),
                            ),
                          ),

                          SizedBox(height: 6),
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
                              hintText: "Contraseña",
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
              
                          const SizedBox(height: 24),
                          AppFormButton(
                            onpress: isFormValid ?  _submitForm : _validateForm,
                            text: "Acceder",
                            color: AppColors.primary,
                            width: double.maxFinite,
                            textColor: AppColors.background,
                          ),

                          /* InkWell(
                            onTap: () {
                              if(isFormValid){
                               _submitForm();
                              }
                            },
                            child: AppButton(
                              isIcon: false,
                              text: "Acceder",
                              color: AppColors.background,
                              bgColor: isFormValid ? AppColors.primary : AppColors.primaryShade300,
                              borderRadius: 20,
                              borderColor: AppColors.inherit,
                            ),
                          ), */
                          const SizedBox(height: 15),
                          Center(
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    // UserRepository.instance.signWithGoogle();
                                  },
                                  child: AppButton(
                                    isIcon: false,
                                    text: "Acceder con Google",
                                    color: AppColors.textPrimary2,
                                    bgColor: AppColors.inherit,
                                    borderRadius: 20,
                                    borderColor: AppColors.textPrimary2,
                                    icon: Icons.verified_user,
                                  ),
                                ),

                                SizedBox(height: 15),
                                InkWell(
                                  onTap: () {},
                                  child: Text(
                                    "¿Has olvidado la contraseña?",
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => RegisterPage(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Registrarse",
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                              ],
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
