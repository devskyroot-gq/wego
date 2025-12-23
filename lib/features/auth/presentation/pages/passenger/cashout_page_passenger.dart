import 'package:demo_pss/core/theme/app_colors.dart';
import 'package:demo_pss/features/auth/presentation/widgets/app_form_button.dart';
import 'package:demo_pss/features/auth/presentation/widgets/custom_app_bar.dart';
import 'package:demo_pss/features/auth/presentation/widgets/input_form.dart';
import 'package:flutter/material.dart';

class CashoutPagePassenger extends StatefulWidget {
  const CashoutPagePassenger({super.key});

  @override
  State<CashoutPagePassenger> createState() => _TransferPagePassengerState();
}

class _TransferPagePassengerState extends State<CashoutPagePassenger> {
  final _cashoutFormKey = GlobalKey<FormState>();

  bool isFormValid = false;
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    isFormValid = false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70), 
        child: CustomAppBar(title: "Cash out")
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Form(
              key: _cashoutFormKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Fondos disponibles",
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textPrimary2,
                      fontStyle: FontStyle.italic,
                      height: 0.9,
                    ),
                  ),
                  SizedBox(height: 10,),
                  InputForm(
                    controller: TextEditingController(text: "0000"),
                    readOnly: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Completa este campo";
                      }
                      return null;
                    },
                    prefixIcon: Icon(Icons.numbers),
                    keyboardType: TextInputType.text,
                    label: "Fondos",
                    focusBorderColor: AppColors.primary,
                  ),

                  SizedBox(height: 10,),
                  Text(
                    "Ingresa el monto que desea retirar de su cuenta",
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textPrimary2,
                      fontStyle: FontStyle.italic,
                      height: 0.9,
                    ),
                  ),
                  SizedBox(height: 10,),
                  InputForm(
                    controller: TextEditingController(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Completa este campo";
                      }
                      return null;
                    },
                    prefixIcon: Icon(Icons.numbers),
                    keyboardType: TextInputType.number,
                    label: "Monto",
                    focusBorderColor: AppColors.primary,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Ingrese su contraseña para confirmar la operación",
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textPrimary2,
                      fontStyle: FontStyle.italic,
                      height: 0.9,
                    ),
                  ),
                  SizedBox(height: 10,),
                  InputForm(
                    controller: TextEditingController(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Completa este campo";
                      }
                      return null;
                    },
                    prefixIcon: Icon(Icons.password),
                    keyboardType: TextInputType.text,
                    label: "Contraseña",
                    focusBorderColor: AppColors.primary,
                  ),
                  SizedBox(height: 10,),
                  AppFormButton(
                    onpress: () {},
                    text: "Aceptar",
                    color:
                        isFormValid
                            ? AppColors.primary
                            : AppColors.primaryShade300,
                    width: double.maxFinite,
                    textColor: AppColors.background,
                  ),
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}