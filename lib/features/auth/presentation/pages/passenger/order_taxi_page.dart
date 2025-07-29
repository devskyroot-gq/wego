import 'package:demo_pss/features/auth/presentation/pages/main_page.dart';
import 'package:demo_pss/features/auth/presentation/pages/services_page.dart';
import 'package:demo_pss/features/auth/presentation/widgets/app_button.dart';
import 'package:demo_pss/features/auth/presentation/widgets/app_large_text.dart';
import 'package:demo_pss/features/auth/presentation/widgets/custom_app_bar.dart';
import 'package:demo_pss/features/auth/presentation/widgets/input_form.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart'; // For formatting DateTime
import 'package:flutter/material.dart';

class OrderTaxiPage extends StatefulWidget {
  const OrderTaxiPage({super.key});

  @override
  State<OrderTaxiPage> createState() => _OrderTaxiPageState();
}

class _OrderTaxiPageState extends State<OrderTaxiPage> {
  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _dateTimeController = TextEditingController();
  //DateTime _defaultDateTime = DateTime.now();
  final DateFormat _dateTimeFormat = DateFormat('dd-MM-yyyy | HH:mm');

  final _taxiFormKey = GlobalKey<FormState>();
  bool selectedNow = false;
  bool selectedToday = false;
  bool selectedFuture = false;

  @override
  void initState() {
    super.initState();
    selectedNow = true;
    selectedToday = false;
    selectedFuture = false;
    _dateTimeController.text = _dateTimeFormat.format(DateTime.now());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _textEditingController.dispose();
    _dateTimeController.dispose();
  }

  Future<void> _selectDateTime(BuildContext context) async {
    DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      minTime: DateTime.now(),
      maxTime: DateTime(2101),
      onConfirm: (date) {
        setState(() {
          _dateTimeController.text = _dateTimeFormat.format(date);
        });
      },
      currentTime: DateTime.now(),
      locale: LocaleType.es,
    );
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CustomAppBar(title: "Pedir taxi"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Form(
              key: _taxiFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Donde te encuentras actualmente? El nombre del barrio o referencia publica.",
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      fontStyle: FontStyle.italic,
                      height: 0.9,
                    ),
                  ),
                  SizedBox(height: 10),
                  InputForm(
                    controller: TextEditingController(),
                    prefixIcon: Icon(Icons.location_on),
                    keyboardType: TextInputType.text,
                    label: "Tu ubicacion actual",
                    //value: "Lugar sin nombrar",
                    focusBorderColor: Colors.blue,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Donde quieres ir? El nombre del barrio o referencia publica.",
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      fontStyle: FontStyle.italic,
                      height: 0.9,
                    ),
                  ),
                  SizedBox(height: 10),
                  InputForm(
                    controller: TextEditingController(),
                    prefixIcon: Icon(Icons.directions_sharp),
                    keyboardType: TextInputType.text,
                    label: "Hacia donde vas?",
                    //value: "",
                    focusBorderColor: Colors.blue,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Se razonable con el monto, precios muy bajos pueden hacer que ignoren tu solicitud.",
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      fontStyle: FontStyle.italic,
                      height: 0.9,
                    ),
                  ),
                  SizedBox(height: 10),
                  InputForm(
                    controller: TextEditingController(),
                    prefixIcon: Icon(Icons.attach_money),
                    keyboardType: TextInputType.number,
                    label: "Cuanto vas a pagar?",
                    hintText: "",
                    //value: "",
                    focusBorderColor: Colors.blue,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Para cuando es el viaje? Elija el tipo de viaje a realizar.",
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      fontStyle: FontStyle.italic,
                      height: 0.9,
                    ),
                  ),
                  SizedBox(height: 10),

                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              selectedNow = !selectedNow;
                            });
                            if (selectedNow) {
                              selectedFuture = false;
                              selectedToday = false;
                            }
                          },
                          child: Column(
                            children: [
                              AnimatedContainer(
                                padding: EdgeInsets.all(5),
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                  color:
                                      selectedNow
                                          ? Colors.blue
                                          : Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                child: Icon(
                                  Icons.front_hand_outlined,
                                  color:
                                      selectedNow ? Colors.white : Colors.grey,
                                  size: 40,
                                ),
                              ),
                              AppLargeText(
                                size: 14,
                                text: "Ahora",
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              selectedToday = !selectedToday;
                              _dateTimeController.text = _dateTimeFormat.format(DateTime.now());
                            });
                            if (selectedToday) {
                              selectedNow = false;
                              selectedFuture = false;
                            }
                          },
                          child: Column(
                            children: [
                              AnimatedContainer(
                                padding: EdgeInsets.all(5),
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                  color:
                                      selectedToday
                                          ? Colors.blue
                                          : Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                child: Icon(
                                  Icons.timer,
                                  color:
                                      selectedToday
                                          ? Colors.white
                                          : Colors.grey,
                                  size: 40,
                                ),
                              ),
                              AppLargeText(
                                size: 14,
                                text: "Hoy",
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              selectedFuture = !selectedFuture;
                              _dateTimeController.text = _dateTimeFormat.format(DateTime.now());
                            });
                            if (selectedFuture) {
                              selectedNow = false;
                              selectedToday = false;
                            }
                          },
                          child: Column(
                            children: [
                              AnimatedContainer(
                                padding: EdgeInsets.all(5),
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                  color:
                                      selectedFuture
                                          ? Colors.blue
                                          : Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                child: Icon(
                                  Icons.calendar_month,
                                  color:
                                      selectedFuture
                                          ? Colors.white
                                          : Colors.grey,
                                  size: 40,
                                ),
                              ),
                              AppLargeText(
                                size: 14,
                                text: "Programado",
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  selectedNow ? SizedBox() : Text(
                    "Establezca la fecha y hora del viaje.",
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      fontStyle: FontStyle.italic,
                      height: 0.9,
                    ),
                  ),
                  SizedBox(height: 10),
                  //TODO show trip time inthe input
                  selectedNow
                      ? SizedBox()
                      : InputForm(
                        controller: _dateTimeController,
                        onTap: () {
                          _selectDateTime(context);
                        },
                        //prefixIcon: Icon(Icons.calendar_month),
                        keyboardType: TextInputType.datetime,
                        label: "",
                        readOnly: true,
                        //initialValue: _dateController.text,
                        focusBorderColor: Colors.blue,
                        suffixIcon: InkWell(
                          onTap: () {
                            _selectDateTime(context);
                          },
                          child: Icon(Icons.calendar_month),
                        ),
                      ),
                  SizedBox(height: 10),

                  InkWell(
                    onTap: () {},
                    child: AppButton(
                      isIcon: false,
                      text: "Enviar",
                      color: Colors.white,
                      bgColor: Colors.blue,
                      borderRadius: 20,
                      borderColor: Colors.transparent,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
