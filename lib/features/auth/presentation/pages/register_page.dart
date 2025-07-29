import 'package:demo_pss/core/theme/app_colors.dart';
import 'package:demo_pss/features/auth/presentation/widgets/app_button.dart';
import 'package:demo_pss/features/auth/presentation/widgets/app_large_text.dart';
import 'package:demo_pss/features/auth/presentation/widgets/app_leading_button.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _registerFormKey = GlobalKey<FormState>();

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
                      key: _registerFormKey,
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
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8),
                          TextFormField(
                            controller: null,
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
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                            ),
                          ),

                          SizedBox(height: 16),
                          TextFormField(
                            controller: null,
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
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                            ),
                          ),

                          SizedBox(height: 16),
                          TextFormField(
                            controller: null,
                            style: TextStyle(fontSize: 18),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Completa este campo";
                              }
                              // Basic email validation regex
                              if (!RegExp(
                                r'^[^@]+@[^@]+\.[^@]+',
                              ).hasMatch(value)) {
                                return 'introduzca una direccion de coreo valida';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.shade300,
                              label: Text(
                                "Coreo electronico",
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
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                            ),
                          ),

                          SizedBox(height: 16),
                          IntlPhoneField(
                            controller: null,
                            style: TextStyle(fontSize: 18),
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.shade300,
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
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                            ),
                            initialCountryCode: "GQ",
                            disableLengthCheck: true,
                          ),

                          SizedBox(height: 16),
                          TextFormField(
                            controller: null,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Completa este campo";
                              } else {
                                return null;
                              }
                            },
                            style: TextStyle(fontSize: 18),
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.shade300,
                              label: Text(
                                "Nombre de usuario",
                                style: TextStyle(fontSize: 18),
                              ),
                              hintText: "Nombre de usuario",
                              alignLabelWithHint: true,
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
                          TextFormField(
                            controller: null,
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
                              fillColor: Colors.grey.shade300,
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
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                            ),
                          ),

                          SizedBox(height: 16),
                          TextFormField(
                            controller: null,
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
                              fillColor: Colors.grey.shade300,
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
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),
                          InkWell(
                            onTap: () {},
                            child: AppButton(
                              isIcon: false,
                              text: "Aceptar",
                              color: Colors.white,
                              bgColor: Colors.blue,
                              borderRadius: 20,
                              borderColor: Colors.transparent,
                            ),
                          ),

                          const SizedBox(height: 15),
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
