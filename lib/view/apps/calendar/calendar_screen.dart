import 'package:fldc/controller/apps/calendar/calendar_controller.dart';
import 'package:fldc/helpers/theme/app_theme.dart';
import 'package:fldc/helpers/utils/mixins/ui_mixin.dart';
import 'package:fldc/helpers/utils/my_shadow.dart';
import 'package:fldc/helpers/widgets/my_breadcrumb.dart';
import 'package:fldc/helpers/widgets/my_breadcrumb_item.dart';
import 'package:fldc/helpers/widgets/my_button.dart';
import 'package:fldc/helpers/widgets/my_card.dart';
import 'package:fldc/helpers/widgets/my_container.dart';
import 'package:fldc/helpers/widgets/my_flex.dart';
import 'package:fldc/helpers/widgets/my_flex_item.dart';
import 'package:fldc/helpers/widgets/my_spacing.dart';
import 'package:fldc/helpers/widgets/my_text.dart';
import 'package:fldc/helpers/widgets/my_text_style.dart';
import 'package:fldc/view/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart' as sf_calendar;

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  final CalendarController _controller = Get.put(CalendarController());
  @override
  late OutlineInputBorder outlineInputBorder;

  @override
  void initState() {
    outlineInputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none);
    // _controller = CalendarController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: _controller,
        tag: 'calendar_controller',
        builder: (_) {
          return Column(
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium(
                      "Calendar",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'App'),
                        MyBreadcrumbItem(name: 'Calendar'),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing / 2),
                child: MyFlex(
                  children: [
                    MyFlexItem(
                      sizes: 'lg-3',
                      child: MyCard(
                        paddingAll: 23,
                        shadow: MyShadow(
                            position: MyShadowPosition.bottom, elevation: .5),
                        borderRadiusAll: 8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyButton.block(
                                elevation: 0.5,
                                onPressed: () {},
                                backgroundColor: contentTheme.primary,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      LucideIcons.plus,
                                      color: contentTheme.onPrimary,
                                    ),
                                    MySpacing.width(12),
                                    MyText.bodyMedium(
                                      'Create New Event',
                                      color: contentTheme.onPrimary,
                                    ),
                                  ],
                                )),
                            MySpacing.height(16),
                            MyText.bodyMedium(
                                'Drag and drop your event or click in the calendar'),
                            MySpacing.height(20),
                            buildEventButtons(LucideIcons.circle,
                                contentTheme.secondary, 'New Theme Release'),
                            MySpacing.height(20),
                            buildEventButtons(LucideIcons.circle,
                                contentTheme.success, 'My Event'),
                            MySpacing.height(20),
                            buildEventButtons(LucideIcons.circle,
                                contentTheme.warning, 'Meet Manager'),
                            MySpacing.height(20),
                            buildEventButtons(LucideIcons.circle,
                                contentTheme.danger, 'Create New Theme'),
                            MySpacing.height(20),
                            MyText.bodyMedium(
                              'How It Work?',
                              fontWeight: 600,
                            ),
                            MySpacing.height(16),
                            MyText.bodyMedium(_controller.dummyTexts[2],
                                fontWeight: 600, muted: true),
                          ],
                        ),
                      ),
                    ),
                    MyFlexItem(
                      sizes: 'lg-9',
                      child: MyCard(
                        paddingAll: 23,
                        shadow: MyShadow(
                            elevation: 0.5, position: MyShadowPosition.bottom),
                        borderRadiusAll: 8,
                        height: 700,
                        child: sf_calendar.SfCalendar(
                          view: sf_calendar.CalendarView.week,
                          allowedViews: _controller.allowedViews,
                          dataSource: _controller.events,
                          allowDragAndDrop: true,
                          allowAppointmentResize: true,
                          onDragEnd: _controller.dragEnd,
                          monthViewSettings: sf_calendar.MonthViewSettings(
                              showAgenda: true,
                              appointmentDisplayMode: sf_calendar
                                  .MonthAppointmentDisplayMode.appointment),
                          controller: sf_calendar.CalendarController(),
                          allowViewNavigation: true,
                          showTodayButton: true,
                          showCurrentTimeIndicator: true,
                          showNavigationArrow: true,
                          onSelectionChanged: (calendarSelectionDetails) {
                            _controller.onSelectDate(calendarSelectionDetails);
                            addDataModal(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget buildEventButtons(IconData icon, Color color, String eventName) {
    return MyButton.block(
        elevation: 0.5,
        onPressed: () {},
        backgroundColor: color,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: contentTheme.onPrimary,
            ),
            MySpacing.width(12),
            MyText.bodyMedium(
              eventName,
              color: contentTheme.onPrimary,
            ),
          ],
        ));
  }

  Future<void> addDataModal(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          title: Text('Add Event'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              title(),
              MySpacing.height(12),
              location(),
              MySpacing.height(12),
              description(),
              MySpacing.height(12),
              colorSelect(),
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge),
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Text('Add'),
              onPressed: () {
                Navigator.of(context).pop();
                _controller.addEvent();
              },
            ),
          ],
        );
      },
    );
  }

  Widget colorSelect() {
    return DropdownButtonFormField<Color>(
        dropdownColor: contentTheme.background,
        value: _controller.selectedColor,
        items: _controller.colorCollection.map((Color color) {
          return DropdownMenuItem<Color>(
            value: color,
            child: Row(
              children: [
                MyContainer(
                    color: color,
                    height: 20,
                    width: 50,
                    clipBehavior: Clip.antiAliasWithSaveLayer),
                MySpacing.width(12),
                MyText.bodyMedium(colorToString(color), fontWeight: 600),
              ],
            ),
          );
        }).toList(),
        onChanged: (Color? value) {
          _controller.onSelectedColor(value);
        },
        decoration: InputDecoration(
          border: outlineInputBorder,
          enabledBorder: outlineInputBorder,
          disabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          filled: true,
          contentPadding: MySpacing.all(12),
          hintText: "Select Color",
          hintStyle: MyTextStyle.bodyMedium(fontWeight: 600),
        ));
  }

  String colorToString(Color color) {
    if (color == Colors.red) return 'Red';
    if (color == Colors.blue) return 'Blue';
    if (color == Colors.green) return 'Green';
    if (color == Colors.yellow) return 'Yellow';
    if (color == Colors.pink) return 'Pink';
    if (color == Colors.purple) return 'Purple';
    if (color == Colors.brown) return 'Brown';
    return '';
  }

  Widget description() {
    return TextFormField(
      controller: _controller.descriptionTE,
      decoration: InputDecoration(
        border: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        disabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        filled: true,
        hintText: "Add Description",
        hintStyle: MyTextStyle.bodyMedium(fontWeight: 600),
      ),
    );
  }

  Widget location() {
    return TextFormField(
      controller: _controller.locationTE,
      decoration: InputDecoration(
        border: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        disabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        filled: true,
        hintText: "Add Location",
        hintStyle: MyTextStyle.bodyMedium(fontWeight: 600),
      ),
    );
  }

  Widget title() {
    return TextFormField(
      controller: _controller.titleTE,
      decoration: InputDecoration(
        border: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        disabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        filled: true,
        hintText: "Add Title",
        hintStyle: MyTextStyle.bodyMedium(fontWeight: 600),
      ),
    );
  }
}
