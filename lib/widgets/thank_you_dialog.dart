import 'package:flutter/material.dart';
import 'package:midowe_app/utils/colors.dart';
import 'package:midowe_app/widgets/primary_outline_button.dart';

class ThankYouDialogBox extends StatelessWidget {
  final String amount, paymentMethod, userPhone, userName;

  const ThankYouDialogBox(
      {Key? key,
      required this.amount,
      required this.paymentMethod,
      required this.userPhone,
      required this.userName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          child: Image.asset("assets/images/hands-holding-words-thank-you.png"),
        ),
        SizedBox(
          height: 25,
        ),
        Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                "Recebemos a sua doação",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Constants.primaryColor),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Quantia: $amount",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text("Método de pagamento: $paymentMethod"),
              SizedBox(
                height: 5,
              ),
              Text("Número: $userPhone"),
              SizedBox(
                height: 5,
              ),
              Text("Nome: $userName"),
              SizedBox(
                height: 20,
              ),
              PrimaryOutlineButton(
                text: "Fechar",
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        )
      ],
    );
  }
}
