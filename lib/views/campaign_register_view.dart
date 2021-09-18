import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:midowe_app/utils/constants.dart';
import 'package:midowe_app/widgets/markdown-editable-textinput/format_markdown.dart';
import 'package:midowe_app/widgets/markdown-editable-textinput/markdown_text_input.dart';
import 'package:midowe_app/widgets/primary_outline_button.dart';
import 'package:midowe_app/widgets/title_subtitle_heading.dart';
import 'package:transparent_image/transparent_image.dart';

class CampaignRegisterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 13),
                  child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.arrowLeft,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: TitleSubtitleHeading("Criar campanha de doação",
                      "Introduza os dados da campanha de angariação de fundos"),
                ),
                Theme(
                    data: ThemeData(
                        accentColor: Constants.primaryColor,
                        colorScheme:
                            ColorScheme.light(primary: Constants.primaryColor)),
                    child: CampaignRegisterForm()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CampaignRegisterForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CampaignRegisterForm();
}

class _CampaignRegisterForm extends State<CampaignRegisterForm> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;

  @override
  Widget build(BuildContext context) {
    return Stepper(
      type: stepperType,
      physics: ScrollPhysics(),
      currentStep: _currentStep,
      onStepTapped: (step) => _onTapped(step),
      onStepContinue: _onContinued,
      onStepCancel: _onCancel,
      steps: <Step>[
        Step(
          title: new Text('Dados básicos'),
          content: _composeBasicDataArea(),
          isActive: _currentStep >= 0,
          state: _currentStep >= 0 ? StepState.complete : StepState.disabled,
        ),
        Step(
          title: new Text('Conteúdo'),
          content: _composeContentArea(),
          isActive: _currentStep >= 0,
          state: _currentStep >= 1 ? StepState.complete : StepState.disabled,
        ),
        Step(
          title: new Text('Imagens'),
          content: _composeImagesArea(),
          isActive: _currentStep >= 0,
          state: _currentStep >= 2 ? StepState.complete : StepState.disabled,
        ),
        Step(
          title: new Text('Realocação de valores'),
          content: _composeReallocationArea(),
          isActive: _currentStep >= 0,
          state: _currentStep >= 3 ? StepState.complete : StepState.disabled,
        ),
      ],
    );
  }

  Widget _composeBasicDataArea() {
    return Column(
      children: [
        SizedBox(
          height: 2,
        ),
        TextFormField(
          decoration: InputDecoration(
              labelText: 'Titulo da campanha',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 5))),
        ),
        SizedBox(
          height: 15,
        ),
        DropdownButtonFormField(
          value: 1,
          items: [
            DropdownMenuItem(
              child: Text("Solidariedade"),
              value: 1,
            ),
            DropdownMenuItem(
              child: Text("Saude"),
              value: 2,
            ),
            DropdownMenuItem(
              child: Text("Educação"),
              value: 3,
            ),
          ],
          decoration: InputDecoration(
            labelText: 'Categoria',
            contentPadding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
            border: const OutlineInputBorder(),
          ),
          onChanged: (newValue) {},
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                    labelText: 'Valor desejado',
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 5))),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                    labelText: 'Data limite',
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 5))),
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _composeContentArea() {
    return MarkdownTextInput(
      (String value) => {},
      '',
      label: 'Description',
      maxLines: 10,
      actions: MarkdownType.values,
    );
  }

  Widget _composeImagesArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Imagem de destaque"),
        SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black12,
          ),
          padding: EdgeInsets.symmetric(vertical: 55, horizontal: 10),
          child: Center(
            child: Icon(
              Icons.add_a_photo_rounded,
              size: 30,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text("Outras imagens"),
        SizedBox(
          height: 10,
        ),
        SizedBox(
            height: 100.0,
            child: ListView(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black12,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.add_a_photo_rounded,
                      size: 30,
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: "https://picsum.photos/300/250",
                          ).image),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
                SizedBox(width: 15),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: "https://picsum.photos/300/251",
                          ).image),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
              ],
            ))
      ],
    );
  }

  Widget _composeReallocationArea() {
    return Column(
      children: [
        SizedBox(
          height: 2,
        ),
        DropdownButtonFormField(
          value: 1,
          items: [
            DropdownMenuItem(
              child: Text("Semanal"),
              value: 1,
            ),
            DropdownMenuItem(
              child: Text("Mensal"),
              value: 2,
            ),
            DropdownMenuItem(
              child: Text("Diário"),
              value: 3,
            ),
          ],
          decoration: InputDecoration(
            labelText: 'Periodicidade de envio de valores',
            contentPadding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
            border: const OutlineInputBorder(),
          ),
          onChanged: (newValue) {},
        ),
        SizedBox(
          height: 15,
        ),
        DropdownButtonFormField(
          value: 1,
          items: [
            DropdownMenuItem(
              child: Text("M-Pesa"),
              value: 1,
            ),
            DropdownMenuItem(
              child: Text("Conta Móvel"),
              value: 2,
            ),
            DropdownMenuItem(
              child: Text("Transferência Bancaria"),
              value: 3,
            ),
          ],
          decoration: InputDecoration(
            labelText: 'Método de recepção',
            contentPadding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
            border: const OutlineInputBorder(),
          ),
          onChanged: (newValue) {},
        ),
        SizedBox(
          height: 15,
        ),
        TextFormField(
          decoration: InputDecoration(
              labelText: 'Número M-Pesa',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 5))),
        ),
      ],
    );
  }

  _onTapped(int step) {
    setState(() => _currentStep = step);
  }

  _onContinued() {
    _currentStep < 3 ? setState(() => _currentStep += 1) : _onFinish();
  }

  _onCancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  _onFinish() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: Container(
            height: 370,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                  child: Image.asset("assets/images/people-gratitude.png"),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        "Campanha criada com sucesso",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Constants.primaryColor),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      PrimaryOutlineButton(
                        text: "Ver perfil da campanha",
                        onPressed: () {},
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
