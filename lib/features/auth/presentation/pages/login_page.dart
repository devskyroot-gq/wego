import 'package:demo_pss/core/theme/app_colors.dart';
import 'package:demo_pss/features/auth/presentation/pages/register_page.dart';
import 'package:demo_pss/features/auth/presentation/pages/start_page.dart';
import 'package:demo_pss/features/auth/presentation/widgets/app_large_text.dart';
import 'package:demo_pss/features/auth/presentation/widgets/app_button.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Opacity(opacity: 0.9, child: ColoredBox(color: Colors.blue)),
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
                      key: _loginFormKey,
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
                              "USUARIO",
                              style: TextStyle(fontSize: 12, letterSpacing: 2),
                            ),
                          ),

                          SizedBox(height: 6),
                          TextFormField(
                            controller: usernameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Completa este campo";
                              } else {
                                return null;
                              }
                            },
                            style: TextStyle(fontSize: 18),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.shade300,
                              hintText: "Usuario, email o telefono",
                              suffixIcon: Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.blue),
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
                            controller: passwordController,
                            obscureText: true,
                            obscuringCharacter: "*",
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
                              fillColor: Colors.grey.shade300,
                              hintText: "Contraseña",
                              suffixIcon: Icon(Icons.lock),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => StartPage(),
                              ));
                            },
                            child: AppButton(
                              isIcon: false,
                              text: "Acceder",
                              color: Colors.white,
                              bgColor: Colors.blue,
                              borderRadius: 20,
                              borderColor: Colors.transparent,
                            ),
                          ),

                          const SizedBox(height: 15),
                          Center(
                            child: Column(
                              children: [
                                AppButton(
                                  isIcon: false,
                                  text: "Acceder con Google",
                                  color: Colors.black54,
                                  bgColor: Colors.transparent,
                                  borderRadius: 20,
                                  borderColor: Colors.black54,
                                  icon: Icons.verified_user,
                                ),
                                
                                SizedBox(height: 15),
                                InkWell(
                                  onTap: () {
                                    
                                  },
                                  child: Text(
                                    "¿Has olvidado la contraseña?",
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => RegisterPage(),
                                    ));
                                  },
                                  child: Text(
                                    "Registrarse",
                                    style: TextStyle(
                                      color: Colors.blue,
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

