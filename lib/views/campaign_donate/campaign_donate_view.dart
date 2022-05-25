import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:midowe_app/models/amount_model.dart';
import 'package:midowe_app/providers/accounting_provider.dart';
import 'package:midowe_app/utils/constants.dart';
import 'package:midowe_app/widgets/amount_picker.dart';
import 'package:midowe_app/widgets/primary_button_icon.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:midowe_app/models/payment_request.dart';
import '../../models/CampaignData.dart';

import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class CampaignDonateView extends StatefulWidget {
  final CampaignData campaign;

  const CampaignDonateView({Key? key, required this.campaign})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CampaignDonateViewState();
  }
}

class _CampaignDonateViewState extends State<CampaignDonateView> {
  final Map<String, dynamic> _formData = {
    'account_id': '',
    'campaign_id': '',
    'amount': '',
    'campaign_name': '',
    'third_party_reference': '',
    'payment_method': '',
    'payment_address': '',
    'supporter_email': '',
    'supporter_name': '',
    'supporter_message': ''
  };

  final AmountPicker amountPicker = AmountPicker();

  final accoutingProvider = GetIt.I.get<AccountingProvider>();

  @override
  Widget build(BuildContext context) {
    _formData['campaign_name'] = widget.campaign.title.trim();
    _formData['campaign_id'] = widget.campaign.id.toString();
    _formData['third_party_reference'] =
        DateTime.now().millisecondsSinceEpoch.toString().trim();
    _formData['account_id'] = widget.campaign.fundraiser!.email;
    _formData['payment_method'] = 'mpesa';
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.arrowLeft,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: ChangeNotifierProvider(
                    create: (_) => AmountModel(),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _headerArea(),
                          _amountArea(),
                          _paymentMethodArea(),
                          _userDataArea(),
                          _actionDonateArea(context)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _headerArea() {
    return Row(children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Doar para ajudar:",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
            SizedBox(
              height: 8,
            ),
            Text(
              widget.campaign.title,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            )
          ],
        ),
      ),
      Container(
        width: 80,
        height: 80,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: widget.campaign.images![0].url,
              width: double.infinity,
              fit: BoxFit.fitHeight),
        ),
      )
    ]);
  }

  Widget _amountArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 50,
        ),
        Text("Quantia:",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        SizedBox(
          height: 10,
        ),
        amountPicker
      ],
    );
  }

  Widget _paymentMethodArea() {
    var textFormField = TextFormField(
      onChanged: (value) => _formData['payment_address'] = "258" + value.trim(),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Constants.primaryColor),
        ),
        border: const OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    );
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Text("Pagar por:",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () => {},
              style: TextButton.styleFrom(
                backgroundColor: Constants.secondaryColor3,
                primary: Constants.secondaryColor,
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Constants.primaryColor,
                        width: 1,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(3)),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 7, horizontal: 20),
                child: Text(
                  "M-PESA",
                  style: TextStyle(
                      fontSize: 13,
                      color: Constants.primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Text("Nº de telefone (84/85):",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
              SizedBox(
                height: 10,
              ),
              textFormField
            ],
          ),
        )
      ],
    );
  }

  Widget _userDataArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 30,
        ),
        Text(
          "Apoiar em nome de (opcional):",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          onChanged: (value) => _formData['supporter_name'] = value,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Constants.primaryColor),
            ),
            border: const OutlineInputBorder(),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Informe sue email(opcional):",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          onChanged: (value) => _formData['supporter_email'] = value.trim(),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Constants.primaryColor),
            ),
            border: const OutlineInputBorder(),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Deixar ficar uma mensagem (opcional):",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          onChanged: (value) => _formData['supporter_message'] = value.trim(),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Constants.primaryColor),
            ),
            border: const OutlineInputBorder(),
          ),
          maxLines: 3,
        )
      ],
    );
  }

  Widget _actionDonateArea(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        Consumer<AmountModel>(
          builder: (context, amountModel, child) => Column(
            children: [
              PrimaryButtonIcon(
                text: "Apoiar com  ${amountModel.amount}MT",
                icon: Icon(CupertinoIcons.heart),
                onPressed: () {
                  actionDonate(context);
                },
              )
            ],
          ),
        )
      ],
    );
  }

  void actionDonate(BuildContext context) async {
    _formData['amount'] = amountPicker.pickedAmount.toString();
    var response = await http.post(
        Uri.parse(
            "https://7wgwulf5j77dp6ypbnspcqxteu0rosoi.lambda-url.af-south-1.on.aws"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(_formData));
    if (response.statusCode == 201) {
      var decodedData = jsonDecode(response.body);
      //TODO: POST TO CMS

    } else {
      throw Exception("Failed to regist donation");
    }
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Text(widget.campaign.thank_you_message),
          ),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );

    new Future.delayed(new Duration(seconds: 3), () {
      Navigator.pop(context); //pop dialog
    });
  }

  String? validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);

    if (value.length == 0) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }

    return null;
  }
}
