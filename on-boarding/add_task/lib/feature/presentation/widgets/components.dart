import 'package:add_task/core/constants.dart';
import 'package:flutter/material.dart';

class TaskPropertyName extends StatelessWidget {
  String propertyName;

  TaskPropertyName(this.propertyName);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 20.0, bottom: 5.0),
        child: Text(
          propertyName,
          style: propertyNameStyle,
        ));
  }
}

class TaskPropertyValue extends StatelessWidget {
  String propertyValue;
  bool isDescription;
  bool isDatePicker;

  TaskPropertyValue(this.propertyValue, this.isDescription, this.isDatePicker);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return IntrinsicWidth(
        child: Container(
      width: width * 0.8,
      // height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: secondaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(
                0, 2), // Adjust the offset to control the shadow position
          ),
        ],
      ),
      child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(20.0),
          child: (isDatePicker == false)
              ? Text(
                  propertyValue,
                  style:
                      (isDescription == false) ? propertyValueStyle : bodyStyle,
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      propertyValue,
                      style: propertyValueStyle,
                    ),
                    const Icon(
                      Icons.calendar_month,
                      color: primaryColor,
                    ),
                  ],
                )),
    ));
  }
}

class PrimaryButton extends StatelessWidget {
  String buttonText;

  PrimaryButton(this.buttonText);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: 150.0),
      child: MaterialButton(
        onPressed: () {
          // Add your onPressed logic here
        },
        color: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          buttonText,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
