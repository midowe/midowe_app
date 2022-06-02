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
import '../../models/CampaignData.dart';
import 'package:http/http.dart' as http;

import '../../widgets/primary_outline_button.dart';

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

  Map<String, dynamic> _donatinData = {
    "campaign": "4",
    "transaction_id": "ffjhjj",
    "amount": 37777,
    "donor_name": "dias",
    "donor_phone": "t7ghbbnnn",
    "donor_email": "bnnmm@nn.bb",
    "donor_message": "nnnn valeu"
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
    AlertDialog alert = AlertDialog(
      content: new Wrap(
        alignment: WrapAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Constants.primaryColor,
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Text("Confirme o pagamento no teu telemovel"),
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
    _formData['amount'] = amountPicker.pickedAmount.toString();
    var response = await http.post(
        Uri.parse(
            "https://7wgwulf5j77dp6ypbnspcqxteu0rosoi.lambda-url.af-south-1.on.aws"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(_formData));
    if (response.statusCode == 201) {
      var payment_response = jsonDecode(response.body)['payment_response'];

      var donation = jsonEncode({
        "data": {
          "campaign": _formData['campaign_id'],
          "transaction_id": payment_response['TransactionId'],
          "amount": _formData['amount'],
          "donor_name": _formData['supporter_name'],
          "donor_phone": _formData['payment_address'],
          "donor_email": _formData['supporter_email'],
          "donor_message": _formData['supporter_message']
        }
      });

      var donationResponse = await http.post(
          Uri.parse("https://cms.dev.midowe.co.mz/api/donations"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: donation);
      Navigator.of(context).pop();
      if (donationResponse.statusCode == 200) {
        showThanksDialog(
            context, widget.campaign.thank_you_message, _formData['amount']);
      } else
        showThanksDialog(
            context, widget.campaign.thank_you_message, _formData['amount']);
    } else {
      Navigator.pop(context); //pop dialogti
      throw Exception("Failed to regist donation");
    }
  }

  showThanksDialog(BuildContext context, String message, String amount) {
    // set up the buttons
    PrimaryOutlineButton okButton = new PrimaryOutlineButton(
        text: "Fechar",
        onPressed: () {
          Navigator.of(context).pop();
        });

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image:
                AssetImage("assets/images/hands-holding-words-thank-you.png"),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Recebemos a sua contribução",
            style: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w600,
                color: Constants.primaryColor),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Montante:",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                amount + ' MT',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Text(
            message,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          okButton
        ],
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
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
