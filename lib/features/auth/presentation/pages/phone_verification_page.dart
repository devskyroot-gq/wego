import 'package:demo_pss/core/theme/app_colors.dart';
import 'package:demo_pss/data/repositories/auth_repositories/user_repository.dart';
import 'package:demo_pss/data/repositories/controller/signup_controller.dart';
import 'package:demo_pss/features/auth/presentation/pages/register_page.dart';
import 'package:demo_pss/features/auth/presentation/pages/start_page.dart';
import 'package:demo_pss/features/auth/presentation/widgets/app_large_text.dart';
import 'package:demo_pss/features/auth/presentation/widgets/app_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneVerificationPage extends StatefulWidget {
  @override
  State<PhoneVerificationPage> createState() => _PhoneVerificationPageState();
}

class _PhoneVerificationPageState extends State<PhoneVerificationPage> {
  final TextEditingController phoneController = TextEditingController();
  final phoneFormKey = GlobalKey<FormState>();
  bool isFormValid = false;
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    // phoneController.addListener(_validateForm);
  }

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  void _validateForm(){
    final isValid = phoneFormKey.currentState?.validate() ?? false;
    if(isValid != isFormValid){
      setState(() {
        isFormValid = isValid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Opacity(opacity: 0.9, child: ColoredBox(color: AppColors.primary)),
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
                      key: phoneFormKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: AppLargeText(
                              text: "Verificacion",
                              size: 24,
                            ),
                          ),
                          SizedBox(height: 8),

                          Padding(
                            padding: const EdgeInsets.only(left: 4, right: 8),
                            child: Text(
                              "Ingresa el codigo de verificacion",
                              softWrap: true,
                              style: TextStyle(
                                fontSize: 12, 
                                letterSpacing: 2,
                              ),
                            ),
                          ),

                          SizedBox(height: 6),
                          TextFormField(
                            controller: phoneController,
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "Completa este campo";
                              }
                              return null;
                            },
                            style: TextStyle(fontSize: 18),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColors.bgCard,
                              suffixIcon: Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: AppColors.primary),
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

                          const SizedBox(height: 24),
                          InkWell(
                            onTap: () {
                              if(isFormValid){
                                //SignupController.instance.verifyOTP(phoneController.text);
                              }
                            },
                            child: AppButton(
                              isIcon: false,
                              text: "Verificar",
                              color: AppColors.background,
                              bgColor: isFormValid ? AppColors.primary : AppColors.primaryShade300,
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

