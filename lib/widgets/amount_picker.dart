import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:midowe_app/models/amount_model.dart';
import 'package:provider/provider.dart';
import 'package:midowe_app/utils/constants.dart';

class AmountPicker extends StatefulWidget {
  int pickedAmount = 100;

  @override
  State<StatefulWidget> createState() {
    return _AmountPicker();
  }
}

class _AmountPicker extends State<AmountPicker> {
  final AmountModel amountModel = new AmountModel();
  final TextEditingController amountController =
      TextEditingController(text: "1000");
  int selectedAmount = 100;
  bool otherAmount = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _createButtonItem(context, amount: 100)),
            SizedBox(
              width: 4,
            ),
            Expanded(child: _createButtonItem(context, amount: 200)),
            SizedBox(
              width: 4,
            ),
            Expanded(child: _createButtonItem(context, amount: 500)),
            SizedBox(
              width: 4,
            ),
            Expanded(child: _createButtonItem(context)),
          ],
        ),
        otherAmount ? _createCustomAmountArea(context) : SizedBox()
      ],
    );
  }

  Widget _createButtonItem(BuildContext context, {int amount = 0}) {
    final String label = amount == 0 ? "OUTRO" : "${amount}MT";

    return TextButton(
      onPressed: () => updateAmount(context, amount, amount == 0),
      style: TextButton.styleFrom(
        backgroundColor:
            selectedAmount == amount || (label == "OUTRO" && otherAmount)
                ? Constants.primaryColor
                : Constants.secondaryColor3,
        primary: Constants.secondaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
        child: Text(
          label,
          style: TextStyle(
              fontSize: 13,
              color:
                  selectedAmount == amount || (label == "OUTRO" && otherAmount)
                      ? Colors.white
                      : Constants.primaryColor,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _createCustomAmountArea(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Row(
        children: [
          Text("Outra quantia:"),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Constants.primaryColor),
                ),
                border: const OutlineInputBorder(),
                suffixText: 'MT',
              ),
              controller: amountController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.end,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (value) => {
                if (value != "0")
                  {updateAmount(context, int.parse(value), true)}
              },
            ),
          )
        ],
      ),
    );
  }

  void updateAmount(BuildContext context, int amount, bool other) {
    var amountModel = context.read<AmountModel>();

    setState(() {
      if (amount == 0 && other) {
        amountController.value = TextEditingValue(text: "1000");
        selectedAmount = 1000;
        amountModel.amount = 1000;
      } else {
        selectedAmount = amount;
        amountModel.amount = amount;
      }
      widget.pickedAmount = amountModel.amount;

      otherAmount = other;
    });
  }
}
