import 'package:fldc/controller/AirlineController.dart';
import 'package:fldc/controller/HomeScreenController.dart';
import 'package:fldc/controller/ui/tabs_controller.dart';
import 'package:fldc/helpers/theme/app_theme.dart';
import 'package:fldc/helpers/utils/mixins/ui_mixin.dart';
import 'package:fldc/helpers/utils/my_shadow.dart';
import 'package:fldc/helpers/widgets/my_breadcrumb.dart';
import 'package:fldc/helpers/widgets/my_breadcrumb_item.dart';
import 'package:fldc/helpers/widgets/my_button.dart';
import 'package:fldc/helpers/widgets/my_card.dart';
import 'package:fldc/helpers/widgets/my_flex.dart';
import 'package:fldc/helpers/widgets/my_flex_item.dart';
import 'package:fldc/helpers/widgets/my_spacing.dart';
import 'package:fldc/helpers/widgets/my_text.dart';
import 'package:fldc/model/airline_model.dart';
import 'package:fldc/model/routes_model.dart';
import 'package:fldc/services/api.service.dart';
import 'package:fldc/view/layouts/layout.dart';
import 'package:fldc/widgets/InputField.dart';
import 'package:fldc/widgets/fldc_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_reorderable_grid_view/utils/definitions.dart';
import 'package:get/get.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late Airlinecontroller controller = Get.put(Airlinecontroller());
  TextEditingController departureController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  TextEditingController costPerFlightController = TextEditingController();
  TextEditingController paxPerFlightController = TextEditingController();
  TextEditingController utilizationController =
      TextEditingController(text: "0.8");

  RxBool calculateError = false.obs;
  RxDouble calculateResult = 0.0.obs;
  RxString calculateMessage = "".obs;
  bool activeCalculate = false;

  Airline? selectedOption;
  late List<Airline> dropdownOptions = [];
  RxInt ticketpp = 0.obs;

  @override
  void initState() {
    super.initState();
    dropdownOptions = controller.airlines;
    selectedOption = dropdownOptions.firstWhere(
        (airline) => airline.id == '100172',
        orElse: () => dropdownOptions.first);
    controller.getRouteByAirlineId(100172);
  }

  void calculate() {
    if (departureController.text.isEmpty ||
        destinationController.text.isEmpty ||
        costPerFlightController.text.isEmpty ||
        paxPerFlightController.text.isEmpty ||
        utilizationController.text.isEmpty) {
      calculateError.value = true;
      return;
    }
    activeCalculate = true;

    var costPerFlight = double.parse(costPerFlightController.text);
    var paxPerFlight = double.parse(paxPerFlightController.text);
    var utilization = double.parse(utilizationController.text);
    var pricePerTicket = ticketpp.value.toDouble();

    calculateResult.value =
        (pricePerTicket * paxPerFlight * utilization) - costPerFlight;
    calculateError.value = false;
  }

  int getPrice(String departure, String destination) {
    if (departure.isEmpty || destination.isEmpty || controller.routes.isEmpty) {
      print("Something went wrong: $departure, $destination");
      return -1;
    }

    var route = controller.routes.firstWhereOrNull((route) =>
        route.dep == departure.toUpperCase() &&
        route.des == destination.toUpperCase());

    if (route == null) {
      print("Route not found: $departure, $destination");
      return -1;
    }
    print("Route: $route");

    return route.ticketpp;
  }
 
  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium(
                      "Calculators",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Calculators'),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              MyFlex(
                children: [
                  MyFlexItem(
                    sizes: "lg-4 md-6",
                    child: MyCard(
                      color: theme.cardTheme.color,
                      child: Container(
                        child: Column(
                          children: [
                            MyText.titleMedium(
                              "Profitability Calculator for AI",
                              fontSize: 18,
                              fontWeight: 600,
                            ),
                            MySpacing.height(10),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: theme.dividerColor,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: DropdownButton<String>(
                                underline: Container(),
                                icon: Icon(LucideIcons.chevron_down),
                                borderRadius: BorderRadius.circular(5),
                                dropdownColor: theme.dialogBackgroundColor,
                                value: selectedOption?.id,
                                items: dropdownOptions
                                    .map<DropdownMenuItem<String>>(
                                        (Airline option) {
                                  return DropdownMenuItem<String>(
                                    value: option.id,
                                    child: Text(option.name),
                                  );
                                }).toList(),
                                onChanged: (String? value) {
                                  if (value != null) {
                                    setState(() {
                                      selectedOption = dropdownOptions.firstWhere(
                                          (airline) => airline.id == value);
                                      controller
                                          .getRouteByAirlineId(int.parse(value));
                                    });
                                  }
                                },
                              ),
                            ),
                            MySpacing.height(10),
                            CustomInputField(
                              controller: departureController,
                              labelText: "Input Departure",
                              helperText: "e.g. LOWW",
                            ),
                            MySpacing.height(10),
                            CustomInputField(
                              controller: destinationController,
                              labelText: "Input Destination",
                              helperText: "e.g. EGLL",
                            ),
                            MySpacing.height(10),
                            CustomInputField(
                              controller: paxPerFlightController,
                              labelText: "Max. PAX from Aircraft",
                              helperText: "e.g. 440",
                            ),
                            MySpacing.height(10),
                            CustomInputField(
                              controller: utilizationController,
                              labelText: "Utilization",
                              helperText: "e.g. 0.8",
                            ),
                            MySpacing.height(10),
                            CustomInputField(
                              controller: costPerFlightController,
                              labelText: "Cost per Flight",
                              helperText: "e.g. 5000",
                            ),
                            MySpacing.height(10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyButton(
                                  borderRadiusAll: 5,
                                  padding: EdgeInsets.all(15),
                                  onPressed: () {
                                    setState(() {
                                      ticketpp = getPrice(
                                              departureController.text,
                                              destinationController.text)
                                          .obs;
                                      calculate();
                                    });
                                  },
                                  child: Text("Calculate"),
                                ),
                                Obx(
                                  () {
                                    if ((calculateError.value ||
                                            calculateResult.value == 0.0) &&
                                        activeCalculate) {
                                      return MyText("Something is wrong!");
                                    } else {
                                      if (calculateResult.value > 0) {
                                        return Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.green,
                                            ),
                                            color:
                                                Colors.green.withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Text(
                                            "Estimated Profit: ${calculateResult.value.round()} \$",
                                            style:
                                                TextStyle(color: Colors.green),
                                          ),
                                        );
                                      } else if (calculateResult.value < 0) {
                                        return Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.red,
                                            ),
                                            color: Colors.red.withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Text(
                                            "Estimated Loss: ${calculateResult.value.round()} \$",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        );
                                      } else {
                                        return Container();
                                      }
                                    }
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
